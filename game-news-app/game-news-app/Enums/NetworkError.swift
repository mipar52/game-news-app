//
//  NetworkError.swift
//  game-news-app
//
//  Created by Milan Parađina on 10.09.2025..
//

import Foundation

enum NetworkError: Error, Sendable {
    case invalidURL(String)
    case badStatus(code: Int, bodyPreview: String?)
    case decoding(underlying: Error)
    case transport(underlying: Error)
    case cancelled
}
