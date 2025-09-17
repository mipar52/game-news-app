//
//  GameListView.swift
//  game-news-app
//
//  Created by Milan Parađina on 11.09.2025..
//

import SwiftUI

struct GameListView: View {
    @ObservedObject var viewModel: GameListViewModel
    private let columns = [GridItem(.adaptive(minimum: .infinity, maximum: .infinity))]
    
    var body: some View {
        NavigationStack {
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
                            VStack {
                                ProgressView()
                                    .padding(.vertical, 16)
                                Text("Getting more games, hang tight...")
                                    .font(.appSemiBoldFont(size: 14))
                                    .foregroundStyle(AppColors.appHeaderText)
                            }
                            .frame(maxWidth: .infinity)
                            .task {
                                viewModel.loadMoreIfNeeded(currentGamePreview: games.last)
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle(viewModel.genre.name)
        .navigationBarTitleDisplayMode(.large)
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
