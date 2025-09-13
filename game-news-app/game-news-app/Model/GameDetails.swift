//
//  Game.swift
//  game-news-app
//
//  Created by Milan Parađina on 12.09.2025..
//

import Foundation

struct GameDetail: Decodable, Identifiable, Equatable, Sendable {
    let id: Int
    let slug: String
    let name: String
    let nameOriginal: String?
    let description: String?    //html?
    let descriptionRaw: String?
    let released: String?
    let backgroundImage: URL?
    let backgroundImageAdditional: URL?
    let website: URL?
    let rating: Double?
    let ratingTop: Int?
    let ratings: [RatingItem]
    let ratingsCount: Int?
    let metacritic: Int?
    let playtime: Int?

    let parentPlatforms: [ParentPlatformRef]
    let platforms: [PlatformEntry]
    let genres: [NamedRef]
    let stores: [StoreEntry]

    let publishers: [NamedRef]
    let developers: [NamedRef]
    let esrbRating: ESRBRating?
    
    let redditUrl: URL?
    let redditName: String?
    let redditDescription: String?
    let redditLogo: String?
    let redditCount: Int?
    let twitchCount: Int?
    let youtubeCount: Int?

    let screenshotsCount: Int?
}

struct RatingItem: Decodable, Equatable, Sendable {
    let id: Int
    let title: String
    let count: Int
    let percent: Double
}

struct PlatformEntry: Decodable, Sendable, Equatable {
    let platform: Platform
    let releasedAt: String?
    let requirementsEn: Requirements?
}

struct Platform: Decodable, Equatable, Sendable {
    let id: Int
    let name: String
    let slug: String
}

struct Requirements: Decodable, Equatable, Sendable {
    let minimum: String?
    let recommended: String?
}

struct ParentPlatformRef: Decodable, Equatable, Sendable { let platform: NamedRef }

struct StoreEntry: Decodable, Equatable, Sendable { let id: Int; let store: Store }
struct Store: Decodable, Sendable, Equatable {
    let id: Int
    let name: String
    let slug: String
    let domain: String?
}

struct NamedRef: Decodable, Equatable, Sendable { let id: Int; let name: String; let slug: String }

struct ESRBRating: Decodable, Equatable, Sendable {
    let id: Int
    let name: String
    let slug: String
}
