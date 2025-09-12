//
//  GameGenreViewModel.swift
//  game-news-app
//
//  Created by Milan Parađina on 11.09.2025..
//

import Foundation

@MainActor
final class GameGenreViewModel: ObservableObject {
    @Published private(set) var state: LoadingState<GameGenre> = .idle

    private let gameApiProvider: GameServiceProvider
    private var loadTask: Task<Void, Error>?
    
    init(gameApiProvider: GameServiceProvider) {
        self.gameApiProvider = gameApiProvider
    }
    
    func getGameGenres(forceRefresh: Bool = false) {
        loadTask?.cancel()
        loadTask = Task { [weak self] in
            guard let self = self else { return }
            do {
                let genres = try await self.gameApiProvider.getGameGenres(forceRefresh: forceRefresh)
                state = .loaded(genres)
            } catch is CancellationError {
                
            } catch {
                self.state = .failed(Utils.humanizeError(with: error))
            }
        }
    }
    
    func refresh() async {
        do {
            let genres = try await gameApiProvider.getGameGenres(forceRefresh: true)
            state = .loaded(genres)
        } catch is CancellationError {
            
        } catch {
            state = .failed(Utils.humanizeError(with: error))
        }
    }
}
