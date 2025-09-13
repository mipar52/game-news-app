//
//  GameServiceProvider.swift
//  game-news-app
//
//  Created by Milan Parađina on 10.09.2025..
//

import Foundation

protocol GameServiceProvider {
    var gameBaseUrl: String { get }
    func getGameGenres(forceRefresh: Bool) async throws -> [GameGenre]
    func getGamesFromGenre(_ genre: String, forceRefresh: Bool) async throws -> [GamePreview]
    func getGamesPage(genre: String, next: URL?) async throws -> PageEnvelope<GamePreview>
    func getGameById(_ id: Int) async throws -> GameDetail
    func getGameBySlug(_ slug: String) async throws -> GameDetail
}
