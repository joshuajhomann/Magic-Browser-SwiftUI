//
//  NetworkImage.swift
//  Magic Browser SwiftUI
//
//  Created by Joshua Homann on 5/15/20.
//  Copyright © 2020 com.josh. All rights reserved.
//

import Combine
import Nuke
import SwiftUI

struct NetworkImage: View {
  @State private var image: UIImage?
  private let download = CurrentValueSubject<ImageTask?, Never>(nil)
  private let url: URL?
  init(url: URL? = nil, placeHolder: UIImage? = nil) {
    self.url = url
    image = placeHolder
  }
  var body: some View {
    SwiftUI.Image(uiImage: self.image ?? UIImage())
      .resizable()
      .aspectRatio(contentMode: .fit)
      .onAppear {
        self.download.send(self.url.map { url in
          ImagePipeline.shared.loadImage(with: url) { result in
            switch result {
            case let .success(response): self.image = response.image
            case let .failure(error): print(error)
            }
          }
        })
      }
      .onDisappear {
        self.download.value?.cancel()
      }
  }
}
