//
//  GameSpecificSearchViewModel.swift
//  game-news-app
//
//  Created by Milan Parađina on 16.09.2025..
//

import Foundation

@MainActor
final class GameSpecificSearchViewModel: ObservableObject {
    
    @Published private(set) var gamePlatformState: LoadingState<Platform> = .idle
    @Published private(set) var gameGenreState: LoadingState<GameGenre> = .idle
    @Published private(set) var resultsState: LoadingState<GamePreview> = .idle
    @Published private(set) var isLoadingMore = false

    @Published var gameFilter: GameSearchFilters = .default
    
    let service: GameServiceProvider
    private var nextPageUrl: URL?
    
    init(service: GameServiceProvider) {
        self.service = service
    }
    
    func loadReferenceData() {
        gameGenreState = .loading
        gamePlatformState = .loading
        
        Task {
            do {
                let genres = try await self.service.getGameGenres(forceRefresh: false)
                self.gameGenreState = .loaded(genres)
    
                let platforms = try await self.service.getGamePlatforms(forceRefresh: false)
                self.gamePlatformState = .loaded(platforms)
            } catch is CancellationError {
                
            } catch {
                gameGenreState = .failed(Utils.humanizeError(with: error))
            }
        }
    }
    
    func setSelectedGenres(slugs: Set<String>) {
        gameFilter.genres = Array(slugs).sorted()
    }

    func setSelectedPlatforms(ids: Set<Int>) {
        gameFilter.platforms = Array(ids).sorted()
    }

    func updateDates(from: Date, to: Date) {
        gameFilter.dateRange = from <= to ? (from, to) : nil
    }
    
    
    func performAdvancedSearch(query: String = "") {
        resultsState = .loading
        nextPageUrl = nil

        Task {
            do {
                let page = try await service.searchGames(query: query, filters: gameFilter, next: nil)
                self.nextPageUrl = page.next
                self.resultsState = .loaded(page.results)
            } catch is CancellationError {
                // ignore
            } catch {
                print("[AdvancedSearch] load-more failed:", Utils.humanizeError(with: error))
                self.resultsState = .failed(Utils.humanizeError(with: error))
            }
        }
    }

    func loadMoreIfNeeded(current: GamePreview?) {
        guard case .loaded(let items) = resultsState,
              let current,
              reachedThreshold(current, in: items),
              !isLoadingMore,
              let url = nextPageUrl else { return }

        isLoadingMore = true
        Task {
            defer { self.isLoadingMore = false }
            do {
                let page = try await service.searchGames(query: "", filters: gameFilter, next: url)
                self.nextPageUrl = page.next
             //   debugPrint(page.results)
                self.resultsState = .loaded(items + page.results)
            } catch is CancellationError {
                // keep items; optionally toast
            } catch {
                print("[AdvancedSearch] load-more failed:", Utils.humanizeError(with: error))
                
            }
        }
    }

    private func reachedThreshold(_ item: GamePreview, in items: [GamePreview], prefetch: Int = 6) -> Bool {
        guard let idx = items.firstIndex(where: { $0.id == item.id }) else { return false }
        return idx >= max(items.count - prefetch, 0)
    }
    

}
