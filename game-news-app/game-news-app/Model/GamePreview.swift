//
//  Game.swift
//  game-news-app
//
//  Created by Milan Parađina on 11.09.2025..
//

import Foundation

struct GamePreview: Decodable, Equatable {
    let id: Int
    let slug: String
    let name: String
    let metacritic: Int?
    let backgroundImage: String?
//    let stores: [Store]
//    let released: String
//    let backgroundImage: String
}
