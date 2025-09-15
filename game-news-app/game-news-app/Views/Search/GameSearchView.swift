//
//  GameSearchView.swift
//  game-news-app
//
//  Created by Milan Parađina on 15.09.2025..
//

import SwiftUI

struct GameSearchView: View {
    @StateObject var viewModel = GameSearchViewModel(service: RawgIOApiClient())
    private let columns = [GridItem(.adaptive(minimum: .infinity, maximum: .infinity))]

    var body: some View {
        NavigationStack {
            Group {
                switch viewModel.state {
                case .loadedSingle(let game):
                    SkeletonGrid(columns: columns)

                case .idle:
                    VStack(spacing: 12) {
                        Image(systemName: "magnifyingglass").font(.largeTitle)
                        Text("Search for games").font(.headline)
                        Text("Try “Portal 2”, “Little Nightmares”, or “horror platformer”.")
                            .font(.subheadline).foregroundStyle(.secondary)
                    }
                    .padding()

                case .loading:
                    SkeletonGrid(columns: columns)

                case .failed(let error):
                    LoadErrorView(
                        title: "Could not search games",
                        errorText: error,
                        buttonTitle: "Try again"
                    ) { viewModel.submitSearch() }

                case .loaded(let results):
                    ScrollView {
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
                                VStack {
                                    ProgressView().padding(.vertical, 16)
                                    Text("Loading more…").font(.footnote).foregroundStyle(.secondary)
                                }
                                .frame(maxWidth: .infinity)
                                .task { viewModel.loadMoreIfNeeded(currentItem: results.last) }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Search")
        }
        .searchable(text: $viewModel.searchQuery, placement: .navigationBarDrawer(displayMode: .always))
        .onChange(of: viewModel.searchQuery) { _ in viewModel.debounceSearch() }
        .onSubmit(of: .search) { viewModel.submitSearch() }
        .toolbar {
            Menu {
                // Simple ordering filter demo
                Picker("Sort by", selection: Binding(
                    get: { viewModelOrdering },
                    set: { new in viewModel.setFilters(updatedFilters(ordering: new)) }
                )) {
                    Text("Relevance").tag(Optional<String>.none)
                    Text("Updated ↓").tag(Optional("-updated"))
                    Text("Rating ↓").tag(Optional("-rating"))
                    Text("Metacritic ↓").tag(Optional("-metacritic"))
                    Text("Released ↓").tag(Optional("-released"))
                }
                Toggle("Exact match", isOn: Binding(
                    get: { currentFilters.exact },
                    set: { on in var f = currentFilters; f.exact = on; viewModel.setFilters(f) }
                ))
                Toggle("Precise (no fuzziness)", isOn: Binding(
                    get: { currentFilters.precise },
                    set: { on in var f = currentFilters; f.precise = on; viewModel.setFilters(f) }
                ))
            } label: {
                Label("Filters", systemImage: "line.3.horizontal.decrease.circle")
            }
        }
    }

    // Helpers to read/update filters via closures (keeps the view concise)
    private var currentFilters: GameSearchFilters {
        // You can expose filters as @Published in the VM if you prefer.
        // For brevity, we rebuild from defaults here; in practice, store in VM.
        GameSearchFilters()
    }
    private var viewModelOrdering: String? { nil }
    private func updatedFilters(ordering: String?) -> GameSearchFilters {
        var f = currentFilters; f.ordering = ordering; return f
    }
}

