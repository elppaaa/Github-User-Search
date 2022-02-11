//
//  SafariView.swift
//  Github User Search
//
//  Created by JK on 2022/02/11.
//

import SafariServices
import SwiftUI

// MARK: - SafariView

struct SafariView: UIViewControllerRepresentable {
  typealias UIViewControllerType = SFSafariViewController
  var url: URL

  func makeUIViewController(context: Context) -> SFSafariViewController {
    SFSafariViewController(url: url)
  }

  func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) { }

}

// MARK: - SafariView_Previews

struct SafariView_Previews: PreviewProvider {
  static var previews: some View {
    SafariView(url: URL(string: "https://github.com")!)
  }
}
