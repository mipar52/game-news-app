//
//  MetacriticRow.swift
//  game-news-app
//
//  Created by Milan Parađina on 13.09.2025..
//

import SwiftUI

struct MetacriticRow: View {
    @EnvironmentObject var theme: ThemeManager
    
    let game: GameDetail
    var body: some View {
        HStack(spacing: 16) {
            Label("\(game.rating?.formatted(.number.precision(.fractionLength(2))) ?? "-")/\(game.ratingTop ?? 5)", systemImage: "star.fill")
            if let hours = game.playtime { Label("\(hours)h avg", systemImage: "clock") }
            Label("\(game.ratingsCount ?? 0) ratings", systemImage: "person.3")
        }
        .font(.subheadline)
        .foregroundStyle(theme.theme.palette.text)
        .padding(.horizontal)
    }
}

#Preview {
    //MetacriticRow()
}
