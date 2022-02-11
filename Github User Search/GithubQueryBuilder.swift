//
//  GithubQueryBuilder.swift
//  Github User Search
//
//  Created by JK on 2022/02/11.
//

import Foundation

struct GithubQueryBuilder {
  init() {
    var component = URLComponents(string: Constraints.GITHUB_BASE_URL)!
    component.queryItems = []
    self.component = component
  }
  
  private init(component: URLComponents) {
    self.component = component
  }
  
  private let component: URLComponents
  
  func api(_ api: API) -> Self {
    var component = self.component
    component.path = api.path
    return .init(component: component)
  }
  
  func query(_ item: Query) -> Self {
    var component = self.component
    component.queryItems?.append(item.queryItem)
    return .init(component: component)
  }
  
  var url: URL? {
    self.component.url
  }
  
  var urlRequest: URLRequest? {
    guard let url = url else { return nil }
    
    var request = URLRequest(url: url)
    request.setHeader(.accept("application/vnd.github.v3+json"))
    request.setHeader(.authorization("token \(Constraints.GITHUB_API_KEY)"))
    
    return request
  }
}

extension GithubQueryBuilder {
  enum Query {
    case q(String)
    case perPage(Int)
    case page(Int)
    
    var queryItem: URLQueryItem {
      switch self {
      case .q(let str): return URLQueryItem(name: "q", value: str)
      case .page(let page): return URLQueryItem(name: "page", value: "\(page)")
      case .perPage(let perPage): return URLQueryItem(name: "per_page", value: "\(perPage)")
      }
    }
  }
  
  enum API {
    case searchUsers
    case userInfo(userName: String)
    
    var path: String {
      switch self {
      case .searchUsers: return "/search/users"
      case .userInfo(userName: let userName): return "/users/\(userName)"
      }
    }
  }
}


fileprivate extension URLRequest {
  mutating func setHeader(_ header: Header) {
    let item = header.item
    self.setValue(item.value, forHTTPHeaderField: item.key)
  }
  
  enum Header {
    case accept(String)
    case authorization(String)
    
    var item: (key: String, value: String) {
      switch self {
      case .accept(let string): return ("Accept", string)
      case .authorization(let string): return ("Authorization", string)
      }
    }
  }
}
