//
//  Utils.swift
//  game-news-app
//
//  Created by Milan Parađina on 12.09.2025..
//

import Foundation

struct Utils {
    static func humanizeError(with gameError: Error) -> String {
        if let networkError = gameError as? NetworkError {
            switch networkError {
            case .invalidURL(let s): return "Invalid URL: \(s)"
            case .badStatus(let code, let body): return "Server error (\(code)). \(body ?? "")"
            case .decoding(let underlying): return "Decoding error: \(underlying)"
            case .transport(let underlying): return "Network error: \(underlying.localizedDescription)"
            case .cancelled: return "Cancelled"
            }
        }
        return gameError.localizedDescription
    }
}
