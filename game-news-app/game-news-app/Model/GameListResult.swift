//
//  GameListResult.swift
//  game-news-app
//
//  Created by Milan Parađina on 11.09.2025..
//

import Foundation

struct GameListResult: Decodable {
    let games: [GamePreview]
    
    enum CodingKeys: String, CodingKey {
        case games = "results"
    }
}
