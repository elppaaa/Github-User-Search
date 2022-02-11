//
//  GithubUserInfoDTO.swift
//  Github User Search
//
//  Created by JK on 2022/02/10.
//

import Foundation

// MARK: - GithubUserInfoDTO
struct GithubUserInfoDTO: Codable {
  let publicRepos: Int?

  enum CodingKeys: String, CodingKey {
    case publicRepos = "public_repos"
  }
}
