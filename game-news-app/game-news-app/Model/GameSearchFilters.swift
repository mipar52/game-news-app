//
//  GameSearchFilters.swift
//  game-news-app
//
//  Created by Milan Parađina on 15.09.2025..
//

import Foundation

struct GameSearchFilters: Sendable, Equatable {
    static func == (lhs: GameSearchFilters, rhs: GameSearchFilters) -> Bool {
        lhs.exact == rhs.exact
    }
    
    var precise = false              // search_precise
    var exact = false                // search_exact

    var genres: [String] = []        // slugs: ["action","indie"]
    var platforms: [Int] = []        // ids: [4,5,7]
    var parentPlatforms: [Int] = []  // ids: [1,2,3]
    var stores: [Int] = []

    var metacritic: ClosedRange<Int>?   // e.g. 70...100
    var dateRange: (Date, Date)?        // UI picks dates; service formats as "YYYY-MM-DD,YYYY-MM-DD"
    var ordering: Ordering?             // "-released", "rating", etc.
    var pageSize = 40

    enum Ordering: String, CaseIterable, Identifiable {
        case name, released, added, created, updated, rating, metacritic
        case nameDesc = "-name", releasedDesc = "-released", addedDesc = "-added",
             createdDesc = "-created", updatedDesc = "-updated", ratingDesc = "-rating", metacriticDesc = "-metacritic"
        var id: String { rawValue }
        var label: String {
            switch self {
            case .name: "Name ↑"; case .nameDesc: "Name ↓"
            case .released: "Released ↑"; case .releasedDesc: "Released ↓"
            case .added: "Added ↑"; case .addedDesc: "Added ↓"
            case .created: "Created ↑"; case .createdDesc: "Created ↓"
            case .updated: "Updated ↑"; case .updatedDesc: "Updated ↓"
            case .rating: "Rating ↑"; case .ratingDesc: "Rating ↓"
            case .metacritic: "Metacritic ↑"; case .metacriticDesc: "Metacritic ↓"
            }
        }
    }

    var activeCount: Int {
        [precise, exact].filter { $0 }.count
        + (genres.isEmpty ? 0 : 1)
        + (platforms.isEmpty ? 0 : 1)
        + (parentPlatforms.isEmpty ? 0 : 1)
        + (stores.isEmpty ? 0 : 1)
        + (metacritic == nil ? 0 : 1)
        + (dateRange == nil ? 0 : 1)
        + (ordering == nil ? 0 : 1)
    }

    static let `default` = GameSearchFilters()
}

