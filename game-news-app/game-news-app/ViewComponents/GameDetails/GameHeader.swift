//
//  GameHeader.swift
//  game-news-app
//
//  Created by Milan Parađina on 13.09.2025..
//

import SwiftUI

struct GameHeader: View {
    @EnvironmentObject var theme: ThemeManager
    
    let game: GameDetail
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            AsyncImage(url: game.backgroundImage) { phase in
                switch phase {
                case .empty: theme.theme.palette.background
                case .success(let image): image.resizable().scaledToFill()
                case .failure: theme.theme.palette.background.opacity(0.2)
                @unknown default: theme.theme.palette.background.opacity(0.2)
                }
            }
            .frame(height: 220)
            .clipped()
            .overlay(LinearGradient(
                colors: [.clear, .black.opacity(0.6)],
                startPoint: .top, endPoint: .bottom
            ))
            VStack(alignment: .leading, spacing: 6) {
                Text(game.name).font(.title2.bold()).foregroundStyle(.white)
                HStack(spacing: 12) {
                    if let released = game.released { Text(released).foregroundStyle(theme.theme.palette.text.opacity(0.85)) }
                    if let mc = game.metacritic {
                        Text("Metacritic \(mc)")
                            .padding(.horizontal, 8).padding(.vertical, 4)
                            .background(mc >= 80 ? Color.green.opacity(0.9) : Color.yellow.opacity(0.9))
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .foregroundStyle(.black)
                            .font(.caption.bold())
                    }
                }.font(.subheadline)
            }
            .padding()
        }
    }
}

#Preview {
    //GameHeader(game: <#GameDetail#>)
}
