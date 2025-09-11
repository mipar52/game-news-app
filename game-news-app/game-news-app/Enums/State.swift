//
//  State.swift
//  game-news-app
//
//  Created by Milan Parađina on 11.09.2025..
//
import Foundation

enum LoadingState: Equatable {
    case idle
    case loading
    case loaded([GameGenre])
    case failed(String)
}
