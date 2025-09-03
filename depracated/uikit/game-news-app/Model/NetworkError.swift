//
//  NetworkError.swift
//  game-news-app
//
//  Created by Milan Parađina on 27.04.2023..
//

import Foundation

enum NetworkError: Error {
case badUrl(value: String)
case badRequest
case serverError
case unknown
case decode(value: String)
}
