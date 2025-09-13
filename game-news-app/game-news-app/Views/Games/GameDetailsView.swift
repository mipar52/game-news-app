//
//  GameDetailsView.swift
//  game-news-app
//
//  Created by Milan Parađina on 13.09.2025..
//

import SwiftUI

struct GameDetailsView: View {
    @ObservedObject var viewModel: GameDetailsViewModel
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        Group {
            switch viewModel.gameDetailsState {
            case .idle, .loading:
                ProgressView().controlSize(.large)
            case .failed(let error):
                VStack {
                    Text("Could not load the game")
                        .font(.appBoldFont(size: 30))
                        .foregroundStyle(AppColors.appHeaderText)
                    Text(error)
                        .font(.appBoldFont(size: 30))
                        .foregroundStyle(AppColors.appTextColor)
                    Button("Try again") {
                        viewModel.getGameDetails()
                    }
                }.padding()
            case .loadedSingle(let game):
                ScrollView {
                    VStack(spacing: 12) {
                        GameHeader(game: game)
                        MetacriticRow(game: game)
                        
                        
                        if game.redditUrl != nil
                            || (game.redditDescription?.isEmpty == false)
                            || (game.redditCount ?? 0) > 0
                            || (game.twitchCount ?? 0) > 0
                            || (game.youtubeCount ?? 0) > 0
                        {
                            SectionHeader(title: "Reddit")
                            GameRedditSection(
                                url: game.redditUrl,
                                logo: game.redditLogo,
                                displayName: game.redditName,
                                description: game.redditDescription,
                                subscribers: game.redditCount,
                                twitchCount: game.twitchCount,
                                youtubeCount: game.youtubeCount
                            )
                        }
                        
                        if !game.platforms.isEmpty {
                            GamePlatformsView(
                                platforms: game.platforms.map( {$0.platform })
                            )
                        }
                        
                        if !game.ratings.isEmpty {
                            GameRatingsView(ratings: game.ratings)
                        }
                        
                        if !game.genres.isEmpty {
                            GameGenreSection(title: "Genres", items: game.genres.map({$0.name}))
                        }
                        
                        
                        if !game.publishers.isEmpty {
                            GameGenreSection(title: "Publishers", items: game.publishers.map(\.name))
                        }

                        if !game.developers.isEmpty {
                            GameGenreSection(title: "Developers", items: game.developers.map(\.name))
                        }

                        if let esrb = game.esrbRating {
                            GameGenreSection(title: "ESRB", items: [esrb.name])
                        }
                        if let desc = game.descriptionRaw {
                            GameDescriptionSection(text: desc)
                        }

//                        if let desc = (game.description?.htmlToAttributedString ?? game.descriptionRaw) {
//                            GameDescriptionSection(text: game.descriptionRaw)
//                        }
                        
                        if let pcReq = game.platforms.first(where: { $0.platform.slug == "pc" })?.requirementsEn,
                           (pcReq.minimum != nil || pcReq.recommended != nil) {
                            GameRequirementsSection(requirements: pcReq)
                        }
                        
                        if !game.stores.isEmpty {
                            GameStoreSection(stores: game.stores.map({$0.store}), slug: game.slug, name: game.name)
                        }
                        if !viewModel.gamePreview.shortScreenshots.isEmpty {
                            GameScreenshotSection(images: viewModel.gamePreview.shortScreenshots.map({$0.image}))
                        } else if let extraBackground = game.backgroundImageAdditional {
                            GameScreenshotSection(images: [extraBackground])
                        }
                    }
                    
                }
            case .loaded(_):
                EmptyView()
            }
        }
        .task {
            if viewModel.gameDetailsState == .idle {
                viewModel.getGameDetails()
            }
        }
    }
}

#Preview {
   // GameDetailsView(viewModel: GameDetailsViewModel(slug: "elden-ring", gameService: RawgIOApiClient()))
}
