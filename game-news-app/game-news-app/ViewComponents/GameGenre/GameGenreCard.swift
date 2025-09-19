//
//  GameGenreCard.swift
//  game-news-app
//
//  Created by Milan Parađina on 11.09.2025..
//

import SwiftUI

struct GameGenreCard: View {
    @EnvironmentObject var theme: ThemeManager
    @EnvironmentObject var settings: SettingsStore
    
    let gameGenre: GameGenre
    
    var body: some View {
        ZStack(alignment: .center) {
            LinearGradient(colors: [theme.theme.palette.background, theme.theme.palette.accent], startPoint: .bottomLeading, endPoint: .topTrailing)
                .ignoresSafeArea(edges: .all)
            // maskirat
            // rectangle
            // teme -> npr crvena, zelena -> customizacija
            
            if let urlString = gameGenre.imageBackground, let url = URL(string: urlString) {
                AsyncImage(url: url) { imagePhase in
                    switch imagePhase {
                    case .empty:
                        ViewUtils.getImage(with: AppText.UIImages.logoViewImageGameController)
                        
                    case .success(let genreImage):
                        genreImage
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
            
            VStack(alignment: .center, spacing: 8) {
                Text(gameGenre.name)
                    .font(.appBoldFont(size: CGFloat(25 / settings.numberOfColumns * 2)))
                    .foregroundColor(theme.theme.palette.header)
                
                Text("\(gameGenre.gamesCount) games")
                    .font(.appSemiBoldFont(size: CGFloat(20 / settings.numberOfColumns * 2)))
                    .foregroundColor(theme.theme.palette.text)
            }
            .padding(10)
            
        }
        .aspectRatio(16/9, contentMode: .fit)
        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
        .overlay(content: {
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .strokeBorder(theme.theme.palette.card, lineWidth: 2)
        })
        .contentShape(Rectangle())
    }
    
}

#Preview {
    GameGenreCard(gameGenre: GameGenre(id: 0, name: "Elden Ring", slug: "elden_ring", gamesCount: 1000, imageBackground: ""))
}
