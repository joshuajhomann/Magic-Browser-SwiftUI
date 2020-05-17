//
//  CardSearchService.swift
//  Magic Browser SwiftUI
//
//  Created by Joshua Homann on 5/15/20.
//  Copyright © 2020 com.josh. All rights reserved.
//

import Combine
import Foundation

protocol CardSearchServiceProtocol {
  func search(query: String, completion: @escaping (Result<[MagicCard], CardSearchService.Error>) -> Void)
}

final class MockCardSearchService: CardSearchServiceProtocol {

  private var allCards: [MagicCard] = []

  init() {
    let url = Bundle.main.url(forResource: "cards", withExtension: "json")!
    let data = try! Data(contentsOf: url)
    let container = try! JSONDecoder().decode(CardSearchResult.self, from: data)
    allCards = container.cards
  }

  func search(query: String, completion: @escaping (Result<[MagicCard], CardSearchService.Error>) -> Void) {
    completion(.success(allCards))
  }

}


final class CardSearchService: CardSearchServiceProtocol {
  private enum Constant {
    static let searchUrl = URL(string:"https://api.scryfall.com/cards/search")!
  }

  enum Error: Swift.Error {
    case invalidURL, noData, other(Swift.Error)
  }

  func search(query: String, completion: @escaping (Result<[MagicCard], CardSearchService.Error>) -> Void) {
    var components = URLComponents(url: Constant.searchUrl, resolvingAgainstBaseURL: false)
    components?.queryItems = [URLQueryItem(name: "q", value: query)]
    guard let url = components?.url else {
      return completion(.failure(Error.invalidURL))
    }
    URLSession.shared.dataTask(with: url) { data, response, error in
      completion( Result {
        guard let data = data else {
          throw Error.noData
        }
        let container = try JSONDecoder().decode(CardSearchResult.self, from: data)
        return container.cards
      }.mapError { Error.other($0)})
    }.resume()

  }

  func search(query: String) -> AnyPublisher<[MagicCard], Error> {
    var components = URLComponents(url: Constant.searchUrl, resolvingAgainstBaseURL: false)
    components?.queryItems = [URLQueryItem(name: "q", value: query)]
    guard let url = components?.url else {
      return Fail<[MagicCard], Error>(error: .invalidURL).eraseToAnyPublisher()
    }
    return URLSession
      .shared
      .dataTaskPublisher(for: url)
      .map(\.data)
      .decode(type: CardSearchResult.self, decoder: JSONDecoder())
      .map(\.cards)
      .mapError { Error.other($0) }
      .eraseToAnyPublisher()
  }

}
