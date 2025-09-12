//
//  NetworkService.swift
//  game-news-app
//
//  Created by Milan Parađina on 10.09.2025..
//

import Foundation

actor RawgIOApiClient: GameServiceProvider, NetworkProvider {
    
    nonisolated let gameBaseUrl: String
    private let apiKey: String
    private let session: URLSession
    private let decoder: JSONDecoder
    
    private var genresCache: [GameGenre]?
    private var gamesCache: [Int: Game] = [:]
    
    init(session: URLSession? = nil, decoder: JSONDecoder? = nil) {
        self.gameBaseUrl = AppConstants.baseUrl
        self.apiKey = AppConstants.apiKey

        let cfg = URLSessionConfiguration.ephemeral
        cfg.timeoutIntervalForRequest = 15
        cfg.waitsForConnectivity = true
        self.session = session ?? URLSession(configuration: cfg)

        let dec = decoder ?? JSONDecoder()
        dec.keyDecodingStrategy = .convertFromSnakeCase
        dec.dateDecodingStrategy = .iso8601
        self.decoder = dec
    }
    
    func getGameGenres(forceRefresh: Bool = false) async throws -> [GameGenre]{
        if !forceRefresh, let cached = genresCache { return  cached }
        let path = "\(AppConstants.genresEndpoint)"
        let request = try makeRequest(path: path)
        let data = try await self.data(for: request)
        let payload = try decode(GameGenreResults.self, from: data)
        genresCache = payload.gameGenres
        return payload.gameGenres
    }
    
    func getGamesFromGenre(_ genre: String, forceRefresh: Bool = false) async throws -> [GamePreview] {
        let path = AppConstants.gameListEndpoint
        let request = try makeRequest(path: path, query: [URLQueryItem(name: "genre", value: genre)])
        let data = try await self.data(for: request)
        let payload = try decode(GameListResult.self, from: data)
        return payload.games
    }
    
    func getGameById(_ id: Int) async throws -> Game {
        return try Game.init(id: 0, name: "elden ring", image: "elden-ring.jpg")
    }
    
    func data(for request: URLRequest) async throws -> Data {
        do {
            let (data, response) = try await session.data(for: request)
            
            guard let http = response as? HTTPURLResponse else {
                throw NetworkError.transport(underlying: URLError(.badServerResponse))
            }
            guard (200..<300).contains(http.statusCode) else {
                let bodyPreview = String(data: data.prefix(512), encoding: .utf8)
                throw NetworkError.badStatus(code: http.statusCode, bodyPreview: bodyPreview)
            }
            
            return data
        } catch {
            if (error as? URLError)?.code == .cancelled || Task.isCancelled {
                throw NetworkError.cancelled
            }
            
            throw NetworkError.transport(underlying: error)
        }
    }
    
    nonisolated func decode<T: Decodable>(_ type: T.Type, from data: Data) throws -> T {
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            throw NetworkError.decoding(underlying: error)
        }
    }
    
    nonisolated func makeRequest(path: String, query: [URLQueryItem] = []) throws -> URLRequest {
        guard let gameBaseUrl = URL(string: gameBaseUrl) else {
            throw NetworkError.invalidURL("\(gameBaseUrl)")
        }
        let fullEndpointUrl = gameBaseUrl.appending(path: path)
        debugPrint("Making request to: \(fullEndpointUrl.absoluteString)")
        
        var components = URLComponents(
            url: fullEndpointUrl,
            resolvingAgainstBaseURL: false)
        
        var items = query
        items.append(URLQueryItem(name: "key", value: apiKey))
        components?.queryItems = items.isEmpty ? nil : items
        
        guard let url = components?.url else { throw NetworkError.invalidURL("\(gameBaseUrl)\(path)")}
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.GET.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        return request
    }
}
