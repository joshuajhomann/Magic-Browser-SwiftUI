//
//  CardSearchView.swift
//  Magic Browser SwiftUI
//
//  Created by Joshua Homann on 5/15/20.
//  Copyright © 2020 com.josh. All rights reserved.
//

import SwiftUI

struct CardSearchView: View {
  @ObservedObject private var viewModel = CardSearchViewModel()
  var body: some View {
    VStack {
      TextField("Search...", text: $viewModel.searchTerm)
        .font(.largeTitle)
        .padding()
      List {
        ForEach(viewModel.cards) { card in
          HStack(alignment: .top) {
            NetworkImage(url: (card.imageUris?.normal).flatMap(URL.init(string:)))
              .frame(width: 250, height: 350)
            VStack(alignment: .leading) {
              Text(card.name)
                .font(.largeTitle)
              Text((card.prices["usd"] as? String).map { "$\($0)"} ?? "none")
                .font(.headline)
              Text(card.rarity.rawValue.capitalized)
                .font(.headline)
              Text("Colors: \(CardSearchViewModel.replacingUnescapedTokens(in:card.colorIdentity.map{$0.rawValue}.joined(separator: ",")))")
              .font(.headline)
              Text(CardSearchViewModel.replacingEscapedTokens(in: card.oracleText ?? ""))
                .font(.body)
                .padding(.top, 12)
            }
          }
        }
      }
    }
  }
}
