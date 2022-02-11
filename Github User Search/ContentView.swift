//
//  ContentView.swift
//  Github User Search
//
//  Created by JK on 2022/02/10.
//

import SwiftUI

// MARK: - ContentView

@MainActor
struct ContentView: View {

  // MARK: Lifecycle

  init(viewModel: ViewModel) {
    self.viewModel = viewModel
  }

  // MARK: Internal

  var body: some View {
    VStack {
      SearchBar(placeHolder: "이름을 입력하세요", text: $viewModel.query)
        .padding(.top)
        .padding(.horizontal, 8)
      
      List {
        ForEach(viewModel.items, id: \.id) { item in
          ResultCell(imageURL: item.avatarURL, name: item.name, repoCount: item.repoCount)
            .onAppear {
              viewModel.needMoreContents(id: item.id)
            }
        }
      }
      
      if viewModel.isLoading {
        ProgressView()
          .background(.clear)
      }
    }

  }

  // MARK: Private

  @ObservedObject private var viewModel: ViewModel
}

// MARK: - ContentView_Previews

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView(viewModel: .init())
  }
}
