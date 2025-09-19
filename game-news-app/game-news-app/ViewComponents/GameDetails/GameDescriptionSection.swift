//
//  GameDescriptionSection.swift
//  game-news-app
//
//  Created by Milan Parađina on 13.09.2025..
//

import SwiftUI

struct GameDescriptionSection: View {
    @EnvironmentObject var theme: ThemeManager
    let text: String
    @State private var expanded = false
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("About").font(.headline).padding(.horizontal)
            Text(text)
                .font(.appSemiBoldFont(size: 16))
                .foregroundStyle(theme.theme.palette.header)
                .lineLimit(expanded ? nil : 6)
                .padding(.horizontal)
            Button(expanded ? "Show less" : "Read more") {
                withAnimation(.easeInOut) { expanded.toggle() }
            }
            .font(.caption.weight(.semibold))
            .padding(.horizontal)
        }
    }
}

#Preview {
    GameDescriptionSection(text: "some-text")
}
