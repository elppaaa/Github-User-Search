//
//  Github_User_SearchApp.swift
//  Github User Search
//
//  Created by JK on 2022/02/10.
//

import SwiftUI

@main
struct Github_User_SearchApp: App {
  var body: some Scene {
    WindowGroup {
      ContentView(viewModel: ViewModel())
    }
  }
}
