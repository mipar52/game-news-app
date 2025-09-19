//
//  GameScreenshotSection.swift
//  game-news-app
//
//  Created by Milan Parađina on 13.09.2025..
//

import SwiftUI

struct GameScreenshotSection: View {
    let images: [URL]
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Screenshots").font(.headline).padding(.horizontal)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(images, id: \.self) { url in
                        AsyncImage(url: url) { phase in
                            switch phase {
                            case .empty: Color.gray.opacity(0.2)
                            case .success(let image): image.resizable().scaledToFill()
                            case .failure: Color.gray.opacity(0.2)
                            @unknown default: Color.gray.opacity(0.2)
                            }
                        }
                        .frame(width: 220, height: 124)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .shadow(radius: 2)
                    }
                }.padding(.horizontal)
            }
        }
    }}

#Preview {
  //  GameScreenshotSection()
}
