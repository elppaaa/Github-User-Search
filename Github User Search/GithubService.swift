//
//  GithubService.swift
//  Github User Search
//
//  Created by JK on 2022/02/10.
//

import Foundation

final class GithubService {
  
  // MARK: Lifecycle
  
  private init() { }
  
  // MARK: Internal
  
  static func searchUser(query: String, perPage: Int = 10, pageNum: Int = 1) async throws -> GithubUserSearchDTO {
    guard let request = GithubQueryBuilder()
            .api(.searchUsers)
            .query(.q(query))
            .query(.perPage(perPage))
            .query(.page(pageNum))
            .urlRequest
    else {
      throw GithubServiceError.failedToCreateURL
    }
    
    let data = try await URLSession.shared.data(for: request).0
    let result = try JSONDecoder().decode(GithubUserSearchDTO.self, from: data)
    
    return result
  }
  
  static func userInfo(userName: String) async throws -> GithubUserInfoDTO {
    guard let request = GithubQueryBuilder()
            .api(.userInfo(userName: userName))
            .urlRequest
    else {
      throw GithubServiceError.failedToCreateURL
    }
    
    let data = try await URLSession.shared.data(for: request).0
    let result = try JSONDecoder().decode(GithubUserInfoDTO.self, from: data)
    
    return result
  }
}

enum GithubServiceError: Error {
  case failedToCreateURL
}
