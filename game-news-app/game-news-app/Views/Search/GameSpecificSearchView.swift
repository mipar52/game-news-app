//
//  GameSpecificSearchView.swift
//  game-news-app
//
//  Created by Milan Parađina on 16.09.2025..
//

import SwiftUI

struct GameSpecificSearchView: View {
    @EnvironmentObject var theme: ThemeManager
    @ObservedObject var viewModel: GameSpecificSearchViewModel
    @State private var selectedGenreSlugs: Set<String> = []
    @State private var selectedPlatformSlugs: Set<Int> = []
    
    @State private var minMC: Int = 0
    @State private var maxMC: Int = 100
    @State private var fromDate = Calendar.current.date(byAdding: .year, value: -10, to: Date())!
    @State private var toDate = Date()
    @State private var isPresented: Bool = false
    
    var body: some View {
            ZStack {
                LinearGradient(gradient: Gradient(colors: [theme.theme.palette.background, theme.theme.palette.accent]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea(.all)
                
                Form {
                    Section {
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
                    } header: {
                        FormSectionHeader(text: "Choose game genres")
                    }
                    .listRowBackground(theme.theme.palette.card)
                    
                    Section {
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
                    } header: {
                        FormSectionHeader(text: "Choose game platforms")
                    }
                    .listRowBackground(theme.theme.palette.card)
                    
                    Section {
                        GameMetacriticStepper(filters: $viewModel.gameFilter)
                    } header: {
                        FormSectionHeader(text: "Metacritic")
                    }
                    .listRowBackground(theme.theme.palette.card)
                    
                    Section {
                        GameDatePicker(fromDate: $fromDate, toDate: $toDate) {
                            viewModel.updateDates(from: fromDate, to: toDate)
                        } onReset: {
                            viewModel.gameFilter.dateRange = nil
                            
                        }
                    } header: {
                        FormSectionHeader(text: "Release dates")
                    }
                    .listRowBackground(theme.theme.palette.card)
                    
                    Section {
                        Picker("Sort by", selection: Binding(
                            get: { viewModel.gameFilter.ordering },
                            set: { viewModel.gameFilter.ordering = $0 }
                        )) {
                            Text("Relevance (default)").tag(GameSearchFilters.Ordering?.none)
                            ForEach(GameSearchFilters.Ordering.allCases) { o in
                                Text(o.label).tag(Optional(o))
                            }
                        }
                    } header: {
                        FormSectionHeader(text: "Ordering")
                    }
                    .listRowBackground(theme.theme.palette.card)
                    
                    Section {
                        Stepper("\(viewModel.gameFilter.pageSize) per page", value: $viewModel.gameFilter.pageSize, in: 10...100, step: 10)
                    } header: {
                        FormSectionHeader(text: "Page size")
                    }
                    .listRowBackground(theme.theme.palette.card)
                }
                .scrollContentBackground(.hidden)
                .background(.clear)
                
            }
            .task {
                viewModel.loadReferenceData()
            }
            .navigationTitle("Advanced search")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Reset") {
                        viewModel.gameFilter = .default
                    }
                    .foregroundStyle(theme.theme.palette.text)
                }
            }
            .safeAreaInset(edge: .bottom) {
                NavigationLink {
                    GameAdvanceSearchList(viewModel: GameAdvanceSearchViewModel(service: RawgIOApiClient(), filters: viewModel.gameFilter))
                } label: {
                    SFSymbolButton(btnText: "Search", sfSymbolName: "dpad", symbolEffect: nil)
                        .background(.ultraThinMaterial, in: Capsule())
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                }
              //  .padding()
            }
    }
    
    #Preview {
        //   GameSpecificSearchView(viewModel: GameSpecificSearchViewModel(service: RawgIOApiClient()))
    }
}
