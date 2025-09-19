//
//  GameGenreSection.swift
//  game-news-app
//
//  Created by Milan Parađina on 13.09.2025..
//

import SwiftUI

struct GameGenreSection: View {
    @EnvironmentObject var theme: ThemeManager
    let title: String
    let items: [String]

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title).font(.headline).padding(.horizontal).foregroundStyle(theme.colors.header)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(items, id: \.self) { p in
                        Text(p)
                            .font(.caption.weight(.semibold))
                            .padding(.horizontal, 10).padding(.vertical, 6)
                            .background(theme.colors.card)
                            .foregroundStyle(theme.colors.text)
                            .clipShape(Capsule())
                    }
                }.padding(.horizontal)
            }
        }
    }
}
#Preview {
 //   GameGenreSection()
}
