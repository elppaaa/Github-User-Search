//
//  Constraints.swift
//  Github User Search
//
//  Created by JK on 2022/02/11.
//

import Foundation

enum Constraints {
  static let GITHUB_BASE_URL = "https://api.github.com"
  static let GITHUB_API_KEY = (Bundle.main.object(forInfoDictionaryKey: "GITHUB_API_KEY") as? String) ?? ""
}
