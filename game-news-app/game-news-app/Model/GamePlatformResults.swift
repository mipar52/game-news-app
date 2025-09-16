//
//  GamePlatformResults.swift
//  game-news-app
//
//  Created by Milan Parađina on 16.09.2025..
//

import Foundation

struct GamePlatformResults: Decodable {
    let platformCount: Int
    let next: String?
    let previous: String?
    let gamePlatforms: [Platform]
    
    enum CodingKeys: String, CodingKey {
        case platformCount = "count"
        case next
        case previous
        case gamePlatforms = "results"
    }
}
