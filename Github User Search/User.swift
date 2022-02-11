//
//  User.swift
//  Github User Search
//
//  Created by JK on 2022/02/10.
//

import Foundation

struct User: Hashable, Identifiable {
  var id: Int

  let name: String
  let avatarURL: String
  let repoCount: Int?
}
