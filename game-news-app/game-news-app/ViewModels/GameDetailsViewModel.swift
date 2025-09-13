//
//  GameDetailsViewModel.swift
//  game-news-app
//
//  Created by Milan Parađina on 13.09.2025..
//

import Foundation
@MainActor
final class GameDetailsViewModel: ObservableObject {
    
    @Published var gameDetailsState: LoadingState<GameDetail> = .idle
    
    let gamePreview: GamePreview
    private let gameService: GameServiceProvider
    
    var currentTask: Task<Void, Never>?
    
    init(gamePreview: GamePreview, gameService: GameServiceProvider) {
        self.gamePreview = gamePreview
        self.gameService = gameService
    }
    
    func getGameDetails() {
        currentTask?.cancel()
        gameDetailsState = .loading
        
        currentTask = Task {
            do {
                let gameDetails = try await gameService.getGameBySlug(gamePreview.slug)
                gameDetailsState = .loadedSingle(gameDetails)
            } catch is CancellationError {
                
            } catch {
                debugPrint(Utils.humanizeError(with: error))
                gameDetailsState = .failed(Utils.humanizeError(with: error))
            }
        }
    }
}
