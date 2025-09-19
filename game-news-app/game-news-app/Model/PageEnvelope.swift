//
//  PageEnvelope.swift
//  game-news-app
//
//  Created by Milan Parađina on 13.09.2025..
//

import Foundation

struct PageEnvelope<T: Decodable>: Decodable {
    let count: Int
    let next: URL?
    let previous: URL?
    let results: [T]
}
