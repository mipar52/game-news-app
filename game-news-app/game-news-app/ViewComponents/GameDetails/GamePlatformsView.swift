//
//  GamePlatformsView.swift
//  game-news-app
//
//  Created by Milan Parađina on 13.09.2025..
//

import SwiftUI

struct GamePlatformsView: View {
    let platforms: [Platform]
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Platforms").font(.headline).padding(.horizontal)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(platforms, id: \.id) { p in
                        Text(p.name)
                            .font(.caption.weight(.semibold))
                            .padding(.horizontal, 10).padding(.vertical, 6)
                            .background(Color.gray.opacity(0.15))
                            .clipShape(Capsule())
                    }
                }.padding(.horizontal)
            }
        }
    }
}

#Preview {
 //   GamePlatformsView()
}
