//
//  GameListViewModel.swift
//  game-news-app
//
//  Created by Milan Parađina on 11.09.2025..
//

import Foundation

@MainActor
final class GameListViewModel: ObservableObject {
    
    @Published private(set) var state = LoadingState<GamePreview>.idle
    @Published private(set) var isLoadingMore = false
    
    private let gameService: GameServiceProvider
    private var loadTask: Task<Void, Error>?
    private var nextPageUrl: URL?
    
    let genre: String
    var hasMoreGamePreviews: Bool { nextPageUrl != nil }
    
    init(gameService: GameServiceProvider, genre: String) {
        self.gameService = gameService
        self.genre = genre
    }
    
    func getGamesFromGenre() {
        loadTask?.cancel()
        state = .loading
        nextPageUrl = nil
        isLoadingMore = false
        
        loadTask = Task { [weak self] in
            guard let self = self else { return }
            
            do {
                let page = try await self.gameService.getGamesPage(genre: genre, next: nextPageUrl)
                self.nextPageUrl = page.next
                self.state = .loaded(page.results)
//                let games = try await self.gameService.getGamesFromGenre(self.genre, forceRefresh: false)
//                state = .loaded(games)
            } catch is CancellationError {
                
            } catch {
                self.state = .failed(Utils.humanizeError(with: error))
            }
            
        }
    }
    
    func loadMoreIfNeeded(currentGamePreview: GamePreview?) {
        guard case .loaded(let gamePreviews) = state,
              let currentGamePreview,
              hasReachedTreashold(currentGamePreview, in: gamePreviews),
                !isLoadingMore,
                let url = nextPageUrl else { return }
        defer { self.isLoadingMore = false }
        isLoadingMore = true
        
        Task { [weak self] in
            guard let self = self else { return }
            do {
                let page = try await self.gameService.getGamesPage(genre: self.genre, next: url)
                self.nextPageUrl = page.next
                self.state = .loaded(gamePreviews + page.results)
            } catch is CancellationError {
                
            } catch {
                debugPrint("[GamePreviews] - loading more failed: \(error.localizedDescription)")
                debugPrint(Utils.humanizeError(with: error))
               // state = .failed(Utils.humanizeError(with: error))
            }
        }
    }
    
    private func hasReachedTreashold(_ item: GamePreview, in items: [GamePreview], fetchDistance: Int = 6) -> Bool {
        guard let itemId = items.firstIndex(where: { $0.id == item.id }) else { return false }
        let threshIndex = max(items.count - fetchDistance, 0)
        return itemId >= threshIndex
    }
    
//    func refresh() {
//        loadTask?.cancel()
//        loadTask? = Task {
//            do {
//                let games = try await gameService.getGamesFromGenre(genre, forceRefresh: true)
//                state = .loaded(games)
//            } catch is CancellationError {
//                
//            } catch {
//                self.state = .failed(Utils.humanizeError(with: error))
//            }
//        }
//    }
}
