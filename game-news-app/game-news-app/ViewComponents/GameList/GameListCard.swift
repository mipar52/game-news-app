//
//  GameListCard.swift
//  game-news-app
//
//  Created by Milan Parađina on 12.09.2025..
//

import SwiftUI

struct GameListCard: View {
    let gamePreview: GamePreview
    
    var body: some View {
        VStack(spacing: 8) {
            ZStack {
                LinearGradient(colors: [.appCellColor, .appYellow, .white], startPoint: .bottomLeading, endPoint: .topTrailing)
                
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
                    .strokeBorder(AppColors.appHeaderText, lineWidth: 2)
            })
            .contentShape(Rectangle())
            
            Text(gamePreview.name)
                .font(.appBoldFont(size: 20))
                .foregroundStyle(AppColors.appHeaderText)
            
            Text("Metacritic score: \(gamePreview.metacritic)")
                .font(.appBoldFont(size: 15))
                .foregroundStyle(AppColors.appTextColor)
                
        }
    }
}

#Preview {
    GameListCard(gamePreview: GamePreview(id: 0, slug: "elden_ring", name: "Elden Ring", metacritic: 83, backgroundImage: "elden_ring.jpg"))
}
