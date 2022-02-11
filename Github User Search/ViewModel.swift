//
//  ViewModel.swift
//  Github User Search
//
//  Created by JK on 2022/02/10.
//

import Combine
import Foundation

@MainActor
final class ViewModel: ObservableObject {

  // MARK: Lifecycle

  init() {
    $query
      .debounce(for: 0.5, scheduler: RunLoop.current)
      .sink { [weak self] _ in
        self?.searchUsers()
      }
      .store(in: &cancelBag)
  }

  // MARK: Internal

  struct Post: Decodable {
    var value: String
  }

  @Published private(set) var isLoading = false
  @Published private(set) var items: [User] = []
  @Published var query: String = ""
  @Published var currentSelected: User? = nil

  func searchUsers() {
    pageNum = 1
    totalCount = nil
    items = []

    if query.count > 0 {
      isLoading = true
      request()
    }
  }

  func needMoreContents(id: Int) {
    if isLoading { return }
    if
      let index = items.lastIndex(where: { $0.id == id }),
      index > items.count - 2
    {

      isLoading = true
      pageNum += 1
      request()
    }
  }

  // MARK: Private

  private var perPage = 10

  private var pageNum = 1
  private var totalCount: Int?

  private var cancelBag = Set<AnyCancellable>()

  private func changeLoadingState(_ bool: Bool) async {
    isLoading = bool
  }

  private func request() {
    Task(priority: .userInitiated) {
      defer { Task { await self.changeLoadingState(false) } }

      if
        let totalCount = totalCount,
        (pageNum * perPage) > totalCount
      {
        return
      }

      guard let searchResult = try? await GithubService.searchUser(query: query, perPage: perPage, pageNum: pageNum) else { return }
      totalCount = searchResult.totalCount
      for item in searchResult.items {
        let num = try? await GithubService.userInfo(userName: item.login).publicRepos
        self.items.append(User(id: item.id, name: item.login, avatarURL: item.avatarURL, repoCount: num))
      }
    }
  }
}
