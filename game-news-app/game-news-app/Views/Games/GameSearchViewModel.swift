//
//  GameSearchViewModel.swift
//  game-news-app
//
//  Created by Milan Parađina on 15.09.2025..
//

import Foundation

@MainActor
final class GameSearchViewModel: ObservableObject {
    
    @Published private(set) var state = LoadingState<GamePreview>.idle
    
    @Published var searchQuery: String = ""
    @Published private(set) var isLoadingMore = false
    
    private let service: GameServiceProvider
    private var searchTask: Task<Void, Never>?
    private var nextPageUrl: URL?
    private var filters = GameSearchFilters()
    var hasMore: Bool { nextPageUrl != nil }
    
    init(service: GameServiceProvider) {
        self.service = service
    }
    
    func debounceSearch() {
        searchTask?.cancel()
        
        let currentQuery = searchQuery.trimmingCharacters(in: .whitespacesAndNewlines)
        guard currentQuery.count >= 2 else {
            state = .idle
            nextPageUrl = nil
            return
        }
        
        state = .loading
        nextPageUrl = nil
        
        searchTask = Task {
            
            do {
                let page = try await service.searchGames(query: currentQuery, filters: filters, next: nil)
                self.nextPageUrl = page.next
                self.state = .loaded(page.results)
            } catch is CancellationError {
                
            } catch {
                self.state = .failed(Utils.humanizeError(with: error))
            }
        }
    }
    
    func submitSearch () {
        debounceSearch()
    }
    
    func setFilters(_ newFilters: GameSearchFilters) {
        filters = newFilters
        debounceSearch()
    }
    
    func loadMoreIfNeeded(currentItem: GamePreview?) {
        guard case .loaded(let gamePreviews) = state,
              let currentItem,
              hasReachedThreshold(currentItem, in: gamePreviews),
              !isLoadingMore,
              let url = nextPageUrl else { return }
        
        isLoadingMore = true
        Task {
            defer {
                self.isLoadingMore = false
            }
            
            do {
                let page = try await service.searchGames(query: searchQuery, filters: filters, next: url)
                self.nextPageUrl = page.next
                self.state = .loaded(gamePreviews + page.results)
            } catch  is CancellationError {
            } catch {
                self.state = .failed(Utils.humanizeError(with: error))
            }
        }
              
    }
    
    private func hasReachedThreshold(_ item: GamePreview, in items: [GamePreview], prefetchDistance: Int = 6) -> Bool {
        guard let itemId = items.firstIndex(where: {$0.id == item.id}) else {
            return false
        }
        
        let threshIndex = max(items.count - prefetchDistance, 0)
        return itemId >= threshIndex
    }
}
