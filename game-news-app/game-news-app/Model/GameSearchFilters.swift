//
//  GameSearchFilters.swift
//  game-news-app
//
//  Created by Milan Parađina on 15.09.2025..
//

import Foundation

struct GameSearchFilters: Sendable {
    var precise: Bool = false
    var exact: Bool = false            // search_exact
    var genres: [String] = []
    var platforms: [Int] = []
    var parentPlatforms: [Int] = []
    var stores: [Int] = []
    var metacritic: ClosedRange<Int>?
    var dates: (String, String)?
    var ordering: String?
    var pageSize: Int = 40
}
