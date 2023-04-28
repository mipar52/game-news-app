//
//  GameList.swift
//  game-news-app
//
//  Created by Milan Parađina on 27.04.2023..
//

import Foundation

struct GameList: Decodable {
    let results: [Result]
}

struct Result: Decodable {
    let name: String
    let playtime: Int
    let platforms: [Platforms]
    let released: String
    let rating: Double
    let rating_top: Double
    let ratings: [Ratings]
    let genres: [Genres]
}

struct Platforms: Decodable {
    let platform: Platform
}
struct Platform: Decodable {
    let name: String
}

struct Genres: Decodable {
    let name: String
}

struct Ratings: Decodable {
    let title: String
    let count: Int
    let percent: Double
}
