//
//  NetworkProvider.swift
//  game-news-app
//
//  Created by Milan Parađina on 11.09.2025..
//

import Foundation

protocol NetworkProvider {
    func data(for request: URLRequest) async throws -> Data
    func decode<T: Decodable>(_ type: T.Type, from data: Data) throws -> T
    func makeRequest(path: String, query: [URLQueryItem]) throws -> URLRequest
}
