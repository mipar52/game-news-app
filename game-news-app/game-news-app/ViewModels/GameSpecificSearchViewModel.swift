//
//  GameSpecificSearchViewModel.swift
//  game-news-app
//
//  Created by Milan Parađina on 16.09.2025..
//

import Foundation

@MainActor
final class GameSpecificSearchViewModel: ObservableObject {
    
    @Published var gamePlatformState: LoadingState<Platform> = .idle
    @Published var gameGenreState: LoadingState<GameGenre> = .idle
    
    let service: GameServiceProvider
    
    init(service: GameServiceProvider) {
        self.service = service
    }
    
    func getAllGenres() {
        gameGenreState = .loading
        Task {
            do {
                let genres = try await self.service.getGameGenres(forceRefresh: false)
                gameGenreState = .loaded(genres)
                print(genres)
            } catch is CancellationError {
                
            } catch {
                gameGenreState = .failed(Utils.humanizeError(with: error))
            }
        }
    }
    
    func getAllPlatforms() {
        Task {
            gamePlatformState = .loading
            do {
                let platforms = try await self.service.getGamePlatforms(forceRefresh: false)
                gamePlatformState = .loaded(platforms)
                print(platforms)
                
            } catch is CancellationError {
                
            } catch {
                gamePlatformState = .failed(Utils.humanizeError(with: error))
            }
        }
    }
}
