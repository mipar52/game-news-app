//
//  GameAdvanceSearchList.swift
//  game-news-app
//
//  Created by Milan Parađina on 16.09.2025..
//

import SwiftUI

struct GameAdvanceSearchList: View {
    @EnvironmentObject private var theme: ThemeManager
    @EnvironmentObject private var settings: SettingsStore
    @ObservedObject var viewModel: GameAdvanceSearchViewModel
    private var columns: [GridItem] {
        Array(repeating: GridItem(.flexible(), spacing: 8), count: settings.numberOfColumns)
    }
    
    var body: some View {
            Group {
                ZStack {
                    LinearGradient(gradient: Gradient(colors: [theme.theme.palette.background, theme.theme.palette.accent]), startPoint: .topLeading, endPoint: .bottomTrailing)
                        .ignoresSafeArea(.all)
                    
                    switch viewModel.gameSearchState {
                    case .idle, .loadedSingle(_):
                        EmptyView()
                    case .loading:
                        SkeletonGrid(columns: columns)
                    case .loaded(let games):
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
                                        viewModel.loadMoreIfNeeded(currentItem: game)
                                    }
                                }
                                
                                if viewModel.hasMoreData || viewModel.isLoadingMore {
                                    GameLoadingProgressView(text: "Getting more games, hang tight...") {
                                        viewModel.loadMoreIfNeeded(currentItem: games.last)
                                    }
                                }
                            }
                        }
                    case .failed(let string):
                        LoadErrorView(title: "Failed to load games", errorText: string, buttonTitle: "Try again") {
                            viewModel.performAdvancedSearch()
                        }
                    }
                }
            }
            .navigationTitle("Advanced Search")
            .searchable(text: $viewModel.searchQuery, placement: .navigationBarDrawer(displayMode: .always))
        .task {
            viewModel.performAdvancedSearch()
        }
    }
}

#Preview {
    GameAdvanceSearchList(viewModel: GameAdvanceSearchViewModel(service: RawgIOApiClient(), filters: .default))
}
