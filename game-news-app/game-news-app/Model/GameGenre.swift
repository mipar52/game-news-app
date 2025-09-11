//
//  GameGenre.swift
//  game-news-app
//
//  Created by Milan Parađina on 11.09.2025..
//

import Foundation

struct GameGenre: Decodable, Equatable {
    let id: Int
    let name: String
    let slug: String
    let gamesCount: Int
    let imageBackground: String?
    let games: [Game]?
    
//    enum CodingKeys: String, CodingKey {
//        case gameGenreId = "id"
//        case name
//        case slug
//        case gamesCount = "games_count"
//        case imageBackgroundUrl = "image_background"
//        case games
//    }
}
