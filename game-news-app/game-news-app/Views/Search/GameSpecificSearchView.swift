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
    @State private var selectedPlatformSlugs: Set<Int> = []

    @State private var minMC: Int = 0
    @State private var maxMC: Int = 100
    @State private var fromDate = Calendar.current.date(byAdding: .year, value: -10, to: Date())!
    @State private var toDate = Date()
    @State private var isPresented: Bool = false
    
    var body: some View {
        NavigationStack {
            Form {
                Section("Choose game genres") {
                    switch viewModel.gameGenreState {
                    case .idle, .loading:
                        ProgressView()
                    case .loaded(let array):
                        MultiSelectGrid(allItems: array, selectedIDs: $selectedGenreSlugs, id: \.slug, label: \.name, numsOfColumns: array.count / 5)
                            .onChange(of: selectedGenreSlugs) { oldValue, newValue in
                                viewModel.setSelectedGenres(slugs: selectedGenreSlugs)
                            }
                    case .loadedSingle(_):
                        SkeletonGrid(columns: [GridItem()])
                    case .failed(let string):
                        Text(string)
                    }
                }
                
                Section("Choose game platforms") {
                    switch viewModel.gamePlatformState {
                    case .idle, .loading:
                        ProgressView()
                    case .loaded(let array):
                        MultiSelectGrid(allItems: array, selectedIDs: $selectedPlatformSlugs, id: \.id, label: \.name, numsOfColumns: array.count / 10)
                            .onChange(of: selectedPlatformSlugs) { oldValue, newValue in
                                viewModel.setSelectedPlatforms(ids: selectedPlatformSlugs)
                            }
                    case .loadedSingle(_):
                        SkeletonGrid(columns: [GridItem()])
                    case .failed(let string):
                        Text(string)
                    }
                }
                
                Section("Metacritic") {
                    GameMetacriticStepper(filters: $viewModel.gameFilter)
                }
                
                Section("Release dates") {
                    GameDatePicker(fromDate: $fromDate, toDate: $toDate) {
                        viewModel.updateDates(from: fromDate, to: toDate)
                    } onReset: {
                        viewModel.gameFilter.dateRange = nil

                    }
                }
                
                Section("Ordering") {
                    Picker("Sort by", selection: Binding(
                        get: { viewModel.gameFilter.ordering },
                        set: { viewModel.gameFilter.ordering = $0 }
                    )) {
                        Text("Relevance (default)").tag(GameSearchFilters.Ordering?.none)
                        ForEach(GameSearchFilters.Ordering.allCases) { o in
                            Text(o.label).tag(Optional(o))
                        }
                    }
                }
                
                Section("Page size") {
                    Stepper("\(viewModel.gameFilter.pageSize) per page", value: $viewModel.gameFilter.pageSize, in: 10...100, step: 10)
                }
                
                switch viewModel.resultsState {
                case .idle, .loadedSingle(_):
                    EmptyView()
                case .loading:
                    Section("Results") { ProgressView() }
                case .loaded(let results):
                    ScrollView {
                        LazyVGrid(columns: [GridItem(.adaptive(minimum: .infinity))]) {
                            ForEach(results, id: \.id) { game in
                                GameListCard(gamePreview: game)
                                    .padding(.vertical, 6)
                                    .onAppear { viewModel.loadMoreIfNeeded(current: game) }
                            }
                        }
                        if viewModel.isLoadingMore  { //|| viewModel.hasMore
                            VStack {
                                ProgressView().padding(.vertical, 12)
                                Text("Loading more…")
                                    .font(.footnote).foregroundStyle(.secondary)
                            }
                        }
                    }
                case .failed(let string):
                    Section("Results") { Text(string) }

                }


            }
            .task {
                viewModel.loadReferenceData()
            }
            .navigationTitle("Advanced search")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("Reset") {
                        viewModel.gameFilter = .default
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Done") {} //dismiss() }.bold()
                }
            }
            
            NavigationLink {
                GameAdvanceSearchList(viewModel: GameAdvanceSearchViewModel(service: RawgIOApiClient(), filters: viewModel.gameFilter))
            } label: {
                SFSymbolButton(btnText: "Search", sfSymbolName: "dpad", symbolEffect: nil)
            }


//            
//

        }
//        .fullScreenCover(isPresented: $isPresented) {
//            GameListView(viewModel: GameListViewModel(service: RawgIOApiClient()))
//        }


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
    private func updateDates() {
       // $filters.dateRange = fromDate <= toDate ? (fromDate, toDate) : nil
    }
}



#Preview {
    GameSpecificSearchView(viewModel: GameSpecificSearchViewModel(service: RawgIOApiClient()))
}
