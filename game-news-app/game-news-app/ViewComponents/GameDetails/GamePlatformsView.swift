//
//  GamePlatformsView.swift
//  game-news-app
//
//  Created by Milan Parađina on 13.09.2025..
//

import SwiftUI

struct GamePlatformsView: View {
    @EnvironmentObject var theme: ThemeManager
    let platforms: [Platform]
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Platforms").font(.headline).padding(.horizontal)
                .foregroundStyle(theme.theme.palette.header)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(platforms, id: \.id) { p in
                        Text(p.name)
                            .font(.caption.weight(.semibold))
                            .padding(.horizontal, 10).padding(.vertical, 6)
                            .background(theme.theme.palette.card)
                            .foregroundStyle(theme.theme.palette.text)
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
