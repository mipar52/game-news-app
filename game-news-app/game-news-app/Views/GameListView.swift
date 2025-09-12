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
            case .loaded(let games):
                ScrollView {
                    LazyVGrid(columns: columns) {
                        ForEach(games, id: \.id) { game in
                            NavigationLink {
                                
                            } label: {
                                GameListCard(gamePreview: game)
                                    .padding()
                            }

                        }
                    }
                }
            }
        }
        .navigationTitle(viewModel.genre)
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
    GameListView(viewModel: GameListViewModel(gameService: RawgIOApiClient(), genre: "action"))
}
