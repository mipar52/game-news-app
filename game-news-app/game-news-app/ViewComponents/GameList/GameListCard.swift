//
//  GameListCard.swift
//  game-news-app
//
//  Created by Milan Parađina on 12.09.2025..
//

import SwiftUI

struct GameListCard: View {
    @EnvironmentObject var theme: ThemeManager
    let gamePreview: GamePreview
    
    var body: some View {
        VStack(spacing: 8) {
            ZStack {
                LinearGradient(colors: [theme.theme.palette.background, theme.theme.palette.accent], startPoint: .bottomLeading, endPoint: .topTrailing)
                
                if let urlString = gamePreview.backgroundImage,
                    let url = URL(string: urlString) {
                    AsyncImage(url: url) { phase in
                        switch phase {
                        case .empty:
                            ViewUtils.getImage(with: AppText.UIImages.logoViewImageGameController)
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFill()
                        case .failure:
                            ViewUtils.getImage(with: AppText.UIImages.errorSymbol)
                        @unknown default:
                            ViewUtils.getImage(with: AppText.UIImages.logoViewImageGameController)
                        }
                    }
                } else {
                    ViewUtils.getImage(with: AppText.UIImages.logoViewImageGameController)
                }
                
            }
            .frame(maxWidth: .infinity, idealHeight: 200)
            .clipShape(RoundedRectangle(cornerRadius: 12, style: .continuous))
            .overlay(content: {
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .strokeBorder(theme.theme.palette.card, lineWidth: 2)
            })
            .contentShape(Rectangle())
            .aspectRatio(16/9, contentMode: .fit)
            
            Text(gamePreview.name)
                .font(.appBoldFont(size: 20))
                .foregroundStyle(theme.theme.palette.header)
            if let metacritic = gamePreview.metacritic {
                Text("Metacritic score: \(metacritic)")
                    .font(.appBoldFont(size: 15))
                    .foregroundStyle(theme.theme.palette.text)
//                if metacritic >= 90 {
//                    Image(systemName: "emoji.stars")
//                        .foregroundStyle(AppColors.appYellow)
//                } else if metacritic >= 80 {
//                    Image(systemName: "emoji.stars")
//                        .foregroundStyle(AppColors.appOrange)
//                } else {
//                    Image(systemName: "emoji.stars")
//                }
            } else {
                Text("Game has not been scored yet")
                    .font(.appBoldFont(size: 15))
                    .foregroundStyle(theme.theme.palette.text)
            }

                
        }
    }
}

#Preview {
//    GameListCard(gamePreview: GamePreview(id: 0, slug: "elden_ring", name: "Elden Ring", metacritic: 83, backgroundImage: "elden_ring.jpg"), )
}
