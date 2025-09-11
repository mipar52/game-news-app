//
//  GameServiceProvider.swift
//  game-news-app
//
//  Created by Milan Parađina on 10.09.2025..
//

protocol GameServiceProvider {
    var gameBaseUrl: String { get }
    func getGameGenres(forceRefresh: Bool) async throws -> [GameGenre]
    func getGameById(_ id: Int) async throws -> Game
}
