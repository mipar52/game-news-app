//
//  GameGenreResults.swift
//  game-news-app
//
//  Created by Milan Parađina on 11.09.2025..
//

import Foundation

struct GameGenreResults: Decodable {
    let genreCount: Int
    let next: String?
    let previous: String?
    let gameGenres: [GameGenre]
    
    enum CodingKeys: String, CodingKey {
        case genreCount = "count"
        case next
        case previous
        case gameGenres = "results"
    }
}
