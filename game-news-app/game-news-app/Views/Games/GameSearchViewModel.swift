//
//  GameSearchViewModel.swift
//  game-news-app
//
//  Created by Milan Parađina on 15.09.2025..
//

import Foundation
import Combine

@MainActor
final class GameSearchViewModel: ObservableObject {
    
    @Published private(set) var state = LoadingState<GamePreview>.idle
    
    @Published var searchQuery: String = ""
    @Published private(set) var isLoadingMore = false
    
    private let service: GameServiceProvider
    private var searchTask: Task<Void, Never>?
    private var nextPageUrl: URL?
    private var filters = GameSearchFilters()
    private var cancellables: Set<AnyCancellable> = []
    var hasMore: Bool { nextPageUrl != nil }
    
    init(service: GameServiceProvider) {
        self.service = service
        self.bindSearchQuery()
    }
    
    private func bindSearchQuery() {
        $searchQuery
            .map {$0.trimmingCharacters(in: .whitespacesAndNewlines)}
            .filter({ [weak self] query in
                if query.isEmpty && query.count < 2 {
                    self?.state = .idle
                    return false
                }
                return true
            })
            .removeDuplicates()
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .sink { [weak self] query in
                guard let self = self else { return }
                self.debounceSearch(with: query)
            }
            .store(in: &cancellables)
    }
    
    func debounceSearch(with query: String) {
        searchTask?.cancel()
        
        state = .loading
        nextPageUrl = nil
        
        searchTask = Task {
            
            do {
                let page = try await service.searchGames(query: query, filters: filters, next: nil)
                self.nextPageUrl = page.next
                self.state = .loaded(page.results)
            } catch is CancellationError {
                
            } catch {
                self.state = .failed(Utils.humanizeError(with: error))
            }
        }
    }
    
//    func submitSearch () {
//        debounceSearch()
//    }
//    
//    func setFilters(_ newFilters: GameSearchFilters) {
//        filters = newFilters
//        debounceSearch()
//    }
    
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
