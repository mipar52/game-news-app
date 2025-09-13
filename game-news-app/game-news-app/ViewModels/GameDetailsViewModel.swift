//
//  GameDetailsViewModel.swift
//  game-news-app
//
//  Created by Milan Parađina on 13.09.2025..
//

import Foundation
@MainActor
final class GameDetailsViewModel: ObservableObject {
    private let slug: String
    private let gameService: GameServiceProvider
    
    init(slug: String, gameService: GameServiceProvider) {
        self.slug = slug
        self.gameService = gameService
    }
    
    func getGameDetails() {
        Task {
            do {
                debugPrint(try await gameService.getGameBySlug(slug))
            } catch is CancellationError {
                
            } catch {
                debugPrint("[GameDetailsVM] - \(Utils.humanizeError(with: error))")
            }
        }
    }
}
