//
//  GameGenres.swift
//  game-news-app
//
//  Created by Milan Parađina on 28.04.2023..
//

import Foundation

struct GameGenre: Decodable {
    let results: [Results]
}

struct Results: Decodable {
    let name: String
    let image_background: URL
    let games: [Games]
}

struct Games: Decodable {
    let name: String
    let id: Int
}
