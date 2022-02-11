//
//  ResultCell.swift
//  Github User Search
//
//  Created by JK on 2022/02/10.
//

import SwiftUI

// MARK: - ResultCell

struct ResultCell: View {
  let imageURL: String
  let name: String
  let repoCount: Int?

  var body: some View {
    HStack {
      AsyncImage(url: URL(string: imageURL)) { image in
        image.resizable()
          .cornerRadius(8)
      } placeholder: {
        ProgressView()
      }
      .aspectRatio(contentMode: .fit)
      .frame(width: 90, height: 90, alignment: .center)
      .padding(.horizontal, 10)

      VStack(alignment: .leading) {
        Text(name)
          .font(.subheadline)
          .fontWeight(.bold)
          .padding(.bottom, 5)
        if let repoCount = repoCount {
          Text("Repos: \(repoCount)")
            .font(.footnote)
        }
      }
      .padding(.trailing, 10)
    }
  }
}

// MARK: - ResultCell_Previews

struct ResultCell_Previews: PreviewProvider {
  static var previews: some View {
    ResultCell(imageURL: "https://picsum.photos/100/100", name: "testUser", repoCount: 120)
      .previewLayout(.fixed(width: 300, height: 100))
  }
}
