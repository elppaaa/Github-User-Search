//
//  User.swift
//  Github User Search
//
//  Created by JK on 2022/02/10.
//

import Foundation

// MARK: - User

struct User: Hashable, Identifiable {
  var id: Int

  let name: String
  let avatarURL: String
  let repoCount: Int?
}

extension User {
  var profileURL: URL {
    URL(string: "https://github.com/\(name)")!
  }
}
