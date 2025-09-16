//
//  GameSpecificSearchView.swift
//  game-news-app
//
//  Created by Milan Parađina on 16.09.2025..
//

import SwiftUI

struct GameSpecificSearchView: View {
    @ObservedObject var viewModel: GameSpecificSearchViewModel
    @State private var selectedGenreSlugs: Set<String> = []

    var body: some View {
        NavigationStack {
            ScrollView {
                Text("Choose game genres")
                switch viewModel.gameGenreState {
                case .idle, .loading:
                    ProgressView()
                case .loaded(let array):
                    MultiSelectGrid(allItems: array, selectedIDs: $selectedGenreSlugs, id: \.slug, label: \.name)
                case .loadedSingle(_):
                    SkeletonGrid(columns: [GridItem()])
                case .failed(let string):
                    Text(string)
                }
                
                Divider()
                
                Text("Choose game platforms")
                switch viewModel.gamePlatformState {
                case .idle, .loading:
                    ProgressView()
                case .loaded(let array):
                    MultiSelectGrid(allItems: array, selectedIDs: $selectedGenreSlugs, id: \.slug, label: \.name)
                case .loadedSingle(_):
                    SkeletonGrid(columns: [GridItem()])
                case .failed(let string):
                    Text(string)
                }
            }
            
            SFSymbolButton(btnText: "Search", sfSymbolName: "dpad", symbolEffect: nil)

        }
        .task {
            viewModel.getAllGenres()
            viewModel.getAllPlatforms()
        }
        .navigationTitle("Advanced search")
        .navigationBarTitleDisplayMode(.large)

//            switch viewModel.gamePlatformState {
//            case .idle, .loadedSingle(_):
//                SkeletonGrid(columns: [GridItem()])
//            case .loaded(let games):
//                MultiSelectList(all: games, selected: games.first?.name ?? "") { label in
//                    
//                }
//            case .failed:
//                Text("Failed to load data")
//            }
    }
}

#Preview {
    GameSpecificSearchView(viewModel: GameSpecificSearchViewModel(service: RawgIOApiClient()))
}
