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
    
    private let gameService: GameServiceProvider
    let genre: String
    
    private var loadTask: Task<Void, Error>?
    
    init(gameService: GameServiceProvider, genre: String) {
        self.gameService = gameService
        self.genre = genre
    }
    
    func getGamesFromGenre() {
        loadTask?.cancel()
        
        loadTask = Task { [weak self] in
            guard let self = self else { return }
            
            do {
                let games = try await self.gameService.getGamesFromGenre(self.genre, forceRefresh: false)
                state = .loaded(games)
            } catch is CancellationError {
                
            } catch {
                self.state = .failed(Utils.humanizeError(with: error))
            }
            
        }
    }
    
    func refresh() {
        loadTask?.cancel()
        loadTask? = Task {
            do {
                let games = try await gameService.getGamesFromGenre(genre, forceRefresh: true)
                state = .loaded(games)
            } catch is CancellationError {
                
            } catch {
                self.state = .failed(Utils.humanizeError(with: error))
            }
        }
    }
}
