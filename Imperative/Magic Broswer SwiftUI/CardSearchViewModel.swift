//
//  CardSearchViewModel.swift
//  Magic Browser SwiftUI
//
//  Created by Joshua Homann on 5/15/20.
//  Copyright © 2020 com.josh. All rights reserved.
//

import Foundation
import Combine

final class CardSearchViewModel: ObservableObject {
  @Published var searchTerm: String = ""
  @Published private (set) var cards: [MagicCard] = []
  private var subscriptions = Set<AnyCancellable>()
  private enum Constant {
    static let replacements = [Character: Character](uniqueKeysWithValues:zip(
      "123456789RBGWUT".map {$0}, "①②③④⑤⑥⑦⑧⑨🔴⚫️🟢⚪️🔵↪️".map {$0}
    ))
    static let regex = try! NSRegularExpression.init(pattern: #"\{(.*?)\}"#, options: [])
  }
  init(
    cardSearchService: CardSearchServiceProtocol = CardSearchService()
  ) {

    cardSearchService.search(query: "dragon") { [weak self] result in
      DispatchQueue.main.async {
        switch result {
        case let .success(cards):
          self?.cards = cards
        case let .failure(error):
          print(error)
          self?.cards = []
        }
      }
    }
  }

  static func replacingUnescapedTokens(in string: String) -> String {
    string.indices.reduce(into: "") { accumulated, index in
      let character = string[index]
      accumulated.append(Constant.replacements[character] ?? character)
    }
  }

  static func replacingEscapedTokens(in string: String) -> String {
    let range = NSRange(string.startIndex..<string.endIndex, in: string)
    var ranges: [Range<String.Index>] = []
    Constant.regex.enumerateMatches(in: string, options: [], range: range) { match, _, _ in
      if let range = (match?.range).flatMap({Range($0, in: string)}) {
        ranges.append(range)
      }
    }
    let replacements = ranges.map { range -> String in
      var index = range.lowerBound
      var acummulated = ""
      while index < range.upperBound {
        let character = string[index]
        if character != "{" && character != "}" {
          acummulated.append(Constant.replacements[character] ?? character)
        }
        index = string.index(after: index)
      }
      return acummulated
    }
    var copy = string
    zip(ranges, replacements).reversed().forEach { range, replacement in
      copy.replaceSubrange(range, with: replacement)
    }
    return copy
  }
}
