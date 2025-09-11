//
//  GameGenreViewModel.swift
//  game-news-app
//
//  Created by Milan Parađina on 11.09.2025..
//

import Foundation

@MainActor
final class GameGenreViewModel: ObservableObject {
    @Published private(set) var state: LoadingState = .idle

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
                self.state = .failed(self.humanizeError(with: error))
            }
        }
    }
    
    func refresh() async {
        do {
            let genres = try await gameApiProvider.getGameGenres(forceRefresh: true)
            state = .loaded(genres)
        } catch is CancellationError {
            
        } catch {
            state = .failed(self.humanizeError(with: error))
        }
    }
    
    private func humanizeError(with gameError: Error) -> String {
        if let networkError = gameError as? NetworkError {
            switch networkError {
            case .invalidURL(let s): return "Invalid URL: \(s)"
            case .badStatus(let code, let body): return "Server error (\(code)). \(body ?? "")"
            case .decoding(let underlying): return "Decoding error: \(underlying.localizedDescription)"
            case .transport(let underlying): return "Network error: \(underlying.localizedDescription)"
            case .cancelled: return "Cancelled"
        }
        }
        return gameError.localizedDescription
    }
}
