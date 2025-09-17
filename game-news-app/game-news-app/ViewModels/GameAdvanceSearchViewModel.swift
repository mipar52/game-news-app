//
//  GameAdvanceSearchViewModel.swift
//  game-news-app
//
//  Created by Milan Parađina on 16.09.2025..
//

import Foundation
import Combine

@MainActor
final class GameAdvanceSearchViewModel: ObservableObject {
    @Published var gameSearchState: LoadingState<GamePreview> = .idle
    @Published var isLoadingMore = false
    @Published var searchQuery: String = ""
    
    private let service: GameServiceProvider
    private var nextPageUrl: URL?
    private var runningTask: Task<Void, Never>?
    private var cancellables: Set<AnyCancellable> = []
    
    var hasMoreData: Bool { nextPageUrl != nil }
    let filters: GameSearchFilters

    init(service: GameServiceProvider, filters: GameSearchFilters? = nil) {
        self.service = service
        self.filters = filters ?? .default
        bindSearchQuery()
    }
    
    private func bindSearchQuery() {
        $searchQuery
            .map {$0.trimmingCharacters(in: .whitespacesAndNewlines)}
            .filter {$0.isEmpty && $0.count < 2}
            .removeDuplicates()
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .sink { [weak self] query in
                guard let self = self else { return }
                self.performAdvancedSearch()
            }
            .store(in: &cancellables)
            
    }

    func performAdvancedSearch() {
        runningTask?.cancel()
        gameSearchState = .loading
        nextPageUrl = nil
        isLoadingMore = false

        runningTask = Task { [weak self] in
            guard let self else { return }
            do {
                let page = try await service.searchGames(query: searchQuery, filters: filters, next: nil)
                self.nextPageUrl = page.next
                self.gameSearchState = .loaded(page.results)
            } catch is CancellationError {
                // ignore
            } catch {
                self.gameSearchState = .failed(Utils.humanizeError(with: error))
            }
        }
    }

    func loadMoreIfNeeded(currentItem: GamePreview?) {
        guard case .loaded(let items) = gameSearchState,
              let currentItem,
              hasReachedThreshold(item: currentItem, items: items),
              !isLoadingMore,
              let url = nextPageUrl else { return }

        isLoadingMore = true
        runningTask = Task { [weak self] in
            guard let self else { return }
            defer { self.isLoadingMore = false }
            do {
                let page = try await service.searchGames(query: searchQuery, filters: filters, next: url)
                self.nextPageUrl = page.next
                debugPrint("[next page URL: \(url)]]")
                if case .loaded(let current) = self.gameSearchState {
                    self.gameSearchState = .loaded(current + page.results)
                }
            } catch is CancellationError {
                // ignore
            } catch {
                print("[AdvancedSearch] load-more failed:", error)
            }
        }
    }

    func hasReachedThreshold(item: GamePreview, items: [GamePreview], fetchDistance: Int = 6) -> Bool {
        guard let idx = items.firstIndex(where: { $0.id == item.id }) else { return false }
        let threshold = max(items.count - fetchDistance, 0)
        return idx >= threshold
    }
}
