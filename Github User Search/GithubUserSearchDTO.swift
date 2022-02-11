//
//  GithubUserSearchDTO.swift
//  Github User Search
//
//  Created by JK on 2022/02/10.
//

import Foundation

// MARK: - GithubUserSearchDTO

struct GithubUserSearchDTO: Codable {
  let totalCount: Int
  let incompleteResults: Bool
  let items: [Item]

  enum CodingKeys: String, CodingKey {
    case totalCount = "total_count"
    case incompleteResults = "incomplete_results"
    case items
  }
}

// MARK: - Item

struct Item: Codable {
  let id: Int
  let login: String
  let avatarURL: String

  enum CodingKeys: String, CodingKey {
    case id
    case login
    case avatarURL = "avatar_url"
  }
}
