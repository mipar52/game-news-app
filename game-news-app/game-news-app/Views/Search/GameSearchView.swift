//
//  GameSearchView.swift
//  game-news-app
//
//  Created by Milan Parađina on 15.09.2025..
//

import SwiftUI

struct GameSearchView: View {
    @EnvironmentObject private var theme: ThemeManager
    @EnvironmentObject private var settings: SettingsStore
    @ObservedObject private var viewModel: GameSearchViewModel
    
    private var columns: [GridItem] {
        Array(repeating: GridItem(.flexible(), spacing: 8), count: settings.numberOfColumns)
    }
    
    init(viewModel: GameSearchViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [theme.theme.palette.background, theme.theme.palette.accent]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea(.all)
                
                switch viewModel.state {
                case .loadedSingle(_):
                    SkeletonGrid(columns: columns)
                    
                case .idle:
                    SearchSuggestionView {
                        GameSpecificSearchView(viewModel: GameSpecificSearchViewModel(service: RawgIOApiClient(), settings: settings))
                    }
                    
                case .loading:
                    SkeletonGrid(columns: columns)
                    
                case .failed(let error):
                    LoadErrorView(
                        title: "Could not search games",
                        errorText: error,
                        buttonTitle: "Try again"
                    ) {  }
                    
                case .loaded(let results):
                    ScrollView {
                        if results.isEmpty {
                            SearchSuggestionView(title: "No games found", subtitle: "It looks like there are no games with the searched phrase: \(viewModel.searchQuery)", sfSymbol: "x.circle.fill", suggestions: ["Elden Ring", "Lies of P", "Grand Theft Auto VI"], onSuggestionTap: nil) {
                                GameSpecificSearchView(viewModel: GameSpecificSearchViewModel(service: RawgIOApiClient(), settings: settings))
                            }
                        }
                        
                        LazyVGrid(columns: columns) {
                            ForEach(results, id: \.id) { game in
                                NavigationLink {
                                    GameDetailsView(viewModel: GameDetailsViewModel(gamePreview: game, gameService: RawgIOApiClient()))
                                } label: {
                                    GameListCard(gamePreview: game).padding()
                                }
                                .onAppear {
                                    viewModel.loadMoreIfNeeded(currentItem: game)
                                }
                            }
                            
                            if viewModel.hasMore || viewModel.isLoadingMore {
                                GameLoadingProgressView(text: "Loading more…") {
                                    viewModel.loadMoreIfNeeded(currentItem: results.last)
                                }
                            }
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Search for games")
            .searchable(text: $viewModel.searchQuery, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search: Lies of P")
    }
}

