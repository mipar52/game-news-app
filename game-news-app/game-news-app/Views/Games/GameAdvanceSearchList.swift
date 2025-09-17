//
//  GameAdvanceSearchList.swift
//  game-news-app
//
//  Created by Milan Parađina on 16.09.2025..
//

import SwiftUI

struct GameAdvanceSearchList: View {
    @ObservedObject var viewModel: GameAdvanceSearchViewModel
    private let columns = [GridItem(.adaptive(minimum: .infinity, maximum: .infinity))]

    var body: some View {
        NavigationStack {
            Group {
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
                                VStack {
                                    ProgressView()
                                        .padding(.vertical, 16)
                                    Text("Getting more games, hang tight...")
                                        .font(.appSemiBoldFont(size: 14))
                                        .foregroundStyle(AppColors.appHeaderText)
                                }
                                .frame(maxWidth: .infinity)
                                .task {
                                    viewModel.loadMoreIfNeeded(currentItem: games.last)
                                }
                            }
                        }
                    }
                case .failed(let string):
                    Text(string)
                }

            }
            .navigationTitle("Advanced Search")
            .searchable(text: $viewModel.searchQuery, placement: .navigationBarDrawer(displayMode: .always))
        }
        .task {
            viewModel.performAdvancedSearch()
        }
    }
}

#Preview {
    GameAdvanceSearchList(viewModel: GameAdvanceSearchViewModel(service: RawgIOApiClient(), filters: .default))
}
