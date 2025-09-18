//
//  GameListView.swift
//  game-news-app
//
//  Created by Milan Parađina on 11.09.2025..
//

import SwiftUI

struct GameListView: View {
    @EnvironmentObject var settings: SettingsStore
    @EnvironmentObject var theme: ThemeManager
    
    @ObservedObject var viewModel: GameListViewModel
    private var columns: [GridItem] {
        Array(repeating: GridItem(.flexible(), spacing: 8), count: settings.numberOfColumns)
    }
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [theme.theme.palette.background, theme.theme.palette.accent]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea(.all)
            
            switch viewModel.state {
            case .loading, .idle:
                SkeletonGrid(columns: columns)
            case .failed(let error):
                LoadErrorView(title: "Could not load games with genre \(viewModel.genre)", errorText: error, buttonTitle: "Try again") {
                    viewModel.getGamesFromGenre()
                }
            case .loadedSingle(_):
                EmptyView()
            case .loaded(let games):
                // why?? list
                ScrollView {
                    LazyVGrid(columns: columns) {
                        ForEach(games, id: \.id) { game in
                            NavigationLink {
                                GameDetailsView(viewModel: GameDetailsViewModel(gamePreview: game, gameService: RawgIOApiClient()))
                            } label: {
                                GameListCard(gamePreview: game)
                                    .padding()
                            }
                            .onAppear {
                                viewModel.loadMoreIfNeeded(currentGamePreview: game)
                            }
                        }
                        
                        if viewModel.hasMoreGamePreviews || viewModel.isLoadingMore {
                            GameLoadingProgressView(text: "Getting more games, hang tight...") {
                                viewModel.loadMoreIfNeeded(currentGamePreview: games.last)
                            }
                        }
                    }
                }
            }
            
        }
        .navigationTitle(viewModel.genre.name)
        .task {
            viewModel.getGamesFromGenre()
        }
        .refreshable {
            viewModel.getGamesFromGenre()
        }
    }
}

#Preview {
    //   GameListView(viewModel: GameListViewModel(gameService: RawgIOApiClient(), genre: "action"))
}
