//
//  GameGenresView.swift
//  game-news-app
//
//  Created by Milan Parađina on 11.09.2025..
//

import SwiftUI

struct GameGenresView: View {
    @ObservedObject private var viewModel: GameGenreViewModel
    
    private let columns = [GridItem(.adaptive(minimum: .infinity, maximum: .infinity))]
    @State private var searchText = ""
    
    var filteredGenres: [GameGenre] {
//        switch viewModel.state {
//        case .loaded(let genres):
//
//        default:
//            return []
//        }
        // sugar
        guard case .loaded(let genres) = viewModel.state else { return [] }
        let query = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !query.isEmpty else { return genres }
        return genres.filter { $0.name.localizedStandardContains(query) }
    }
    
    @State private var genres: [GameGenre] = []
    
    init(viewModel: GameGenreViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationStack {
            switch viewModel.state {
            case .idle, .loading:
                SkeletonGrid(columns: columns)
            case .failed(let error):
                LoadErrorView(title: "Could not load Game Genres", errorText: error, buttonTitle: "Try again") {
                    viewModel.getGameGenres(forceRefresh: true)
                }
            case .loaded:
                if filteredGenres.isEmpty {
                    ContentUnavailableView("No genres", image: AppText.UIImages.logoViewImageGameController)
                } else {
                    ScrollView {
                        LazyVGrid(columns: columns) {
                            ForEach(filteredGenres, id: \.id) { genre in
                                NavigationLink {
                                    GameListView(viewModel: GameListViewModel(gameService: RawgIOApiClient(), genre: genre.slug))
                                    
                                } label: {
                                    GameGenreCard(gameGenre: genre)
                                        
                                }

                            }
                        }
                    }
                    .padding()
                    .navigationTitle("Genres")
                    .navigationBarTitleDisplayMode(.large)
                    .searchable(text: $searchText, prompt: "Search genres")
                }
            }
        }
        .task {
            if viewModel.state == .idle {
                viewModel.getGameGenres(forceRefresh: false)
            }
        }
        .refreshable {
            await viewModel.refresh()
        }
    }
}

#Preview {
    GameGenresView(viewModel: GameGenreViewModel(gameApiProvider: RawgIOApiClient()))
}
