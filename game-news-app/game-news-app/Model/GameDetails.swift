//
//  Game.swift
//  game-news-app
//
//  Created by Milan Parađina on 12.09.2025..
//

import Foundation

struct GameDetail: Decodable, Identifiable, Sendable {
    let id: Int
    let slug: String
    let name: String
    let released: String?
    let backgroundImage: URL?
    let rating: Double?
    let ratingTop: Int?
    let ratings: [RatingItem]
    let ratingsCount: Int?
    let metacritic: Int?
    let playtime: Int?
    let platforms: [PlatformEntry]
    let parentPlatforms: [ParentPlatformRef]
    let genres: [NamedRef]
    let stores: [StoreEntry]
    let shortScreenshots: [ShortScreenshot]?
}

struct RatingItem: Decodable, Sendable {
    let id: Int
    let title: String
    let count: Int
    let percent: Double
}

struct PlatformEntry: Decodable, Sendable {
    let platform: Platform
    let releasedAt: String?
    let requirementsEn: Requirements?
}

struct Platform: Decodable, Sendable {
    let id: Int
    let name: String
    let slug: String
}

struct Requirements: Decodable, Sendable {
    let minimum: String?
    let recommended: String?
}

struct ParentPlatformRef: Decodable, Sendable { let platform: NamedRef }

struct StoreEntry: Decodable, Sendable { let id: Int; let store: Store }
struct Store: Decodable, Sendable {
    let id: Int
    let name: String
    let slug: String
    let domain: String?
}

struct ShortScreenshot: Decodable, Sendable { let id: Int; let image: URL }
struct NamedRef: Decodable, Sendable { let id: Int; let name: String; let slug: String }
