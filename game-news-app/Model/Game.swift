//
//  Game.swift
//  game-news-app
//
//  Created by Milan Parađina on 28.04.2023..
//

import Foundation

struct Game: Decodable {
    let name_original: String
    let metacritic: Int?
    let released: String
    let background_image: URL
    let background_image_additional: URL
    let website: String?
    let rating: Double
    let playtime: Int
    let reddit_name: String
    let developers: [Developers]
    let ratings: [Ratings]
    let stores: [Stores]
}

struct MetacriticPlatforms: Decodable {
    let metascore: Int
    let url: URL
    let platform: Platform
}

struct Stores: Decodable {
    let store: Store

}

struct Store: Decodable {
    let name: String
    let domain: String
}

struct Developers: Decodable {
    let name: String
    let image_background: URL
}
