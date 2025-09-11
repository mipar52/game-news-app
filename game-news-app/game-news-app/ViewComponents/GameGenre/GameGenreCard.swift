//
//  GameGenreCard.swift
//  game-news-app
//
//  Created by Milan Parađina on 11.09.2025..
//

import SwiftUI

struct GameGenreCard: View {
    let gameGenre: GameGenre
    
    var body: some View {
        ZStack(alignment: .center) {
            LinearGradient(colors: [AppColors.appBackground, AppColors.appRed], startPoint: .bottomLeading, endPoint: .topTrailing)
                .ignoresSafeArea(edges: .all)
            
            if let urlString = gameGenre.imageBackground, let url = URL(string: urlString) {
                AsyncImage(url: url) { imagePhase in
                    switch imagePhase {
                    case .empty:
                        getImage(with: AppText.UIImages.logoViewImageGameController)
                        
                    case .success(let genreImage):
                        genreImage
                            .resizable()
                            .scaledToFill()
                        
                    case .failure:
                        getImage(with: AppText.UIImages.errorSymbol)
                    @unknown default:
                        getImage(with: AppText.UIImages.logoViewImageGameController)
                    }
                }
            } else {
                getImage(with: AppText.UIImages.logoViewImageGameController)
            }
            
            VStack(alignment: .center, spacing: 8) {
                Text(gameGenre.name)
                    .font(.appBoldFont(size: 25))
                    .foregroundColor(.appHeaderText)
                
                Text("\(gameGenre.gamesCount) games")
                    .font(.appSemiBoldFont(size: 20))
                    .foregroundColor(.white)
            }
            .padding(10)
            
        }
        .frame(maxWidth: .infinity, idealHeight: 200)
        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
        .overlay(content: {
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .strokeBorder(AppColors.appHeaderText, lineWidth: 2)
        })
        .contentShape(Rectangle())
    }
    
    @ViewBuilder
    private func getImage(with symbolName: String) -> some View {
        Image(systemName: symbolName)
            .font(.appBoldFont(size: 40))
            .foregroundStyle(AppColors.appYellow)
            .symbolEffect(.pulse, isActive: true)
    }
}

#Preview {
    GameGenreCard(gameGenre: GameGenre(id: 0, name: "Elden Ring", slug: "elden_ring", gamesCount: 1000, imageBackground: "", games: nil))
}
