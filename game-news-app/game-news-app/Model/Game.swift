//
//  Game.swift
//  game-news-app
//
//  Created by Milan Parađina on 12.09.2025..
//

struct Game {
    let id: Int
    let name: String
    let image: String?
}

struct Platform: Decodable, Equatable {
    let id: Int
    let name: String
    let slug: String
}

struct Store: Decodable, Equatable {
    let id: Int
    let name: String
    let slug: String
}
