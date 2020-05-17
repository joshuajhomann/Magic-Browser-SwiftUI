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
  func search(query: String) -> AnyPublisher<[MagicCard], CardSearchService.Error>
}

final class MockCardSearchService: CardSearchServiceProtocol {

  private var allCards: [MagicCard] = []

  init() {
    allCards = Bundle.main.url(forResource: "cards", withExtension: "json")
      .flatMap { try? Data(contentsOf: $0) }
      .flatMap { try? JSONDecoder().decode(CardSearchResult.self, from: $0) }
      .map(\.cards) ?? []
  }

  func search(query: String) -> AnyPublisher<[MagicCard], CardSearchService.Error> {
    Just(allCards)
      .setFailureType(to: CardSearchService.Error.self)
      .eraseToAnyPublisher()
  }

}


final class CardSearchService: CardSearchServiceProtocol {
  private enum Constant {
    static let searchUrl = URL(string:"https://api.scryfall.com/cards/search")!
  }

  enum Error: Swift.Error {
    case invalidURL, other(Swift.Error)
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
