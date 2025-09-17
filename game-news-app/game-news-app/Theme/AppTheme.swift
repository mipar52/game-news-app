//
//  AppTheme.swift
//  game-news-app
//
//  Created by Milan Parađina on 18.09.2025..
//

import Foundation
import SwiftUI

enum AppTheme: String, CaseIterable, Identifiable, Codable {
    case classic
    case neon
    case mono
    var id: String { rawValue }

    var name: String {
        switch self {
        case .classic: "Classic"
        case .neon:    "Neon"
        case .mono:    "Mono"
        }
    }

    var palette: ThemePalette {
        switch self {
        case .classic:
            return .init(
                header: Color(red: 0.18, green: 0.42, blue: 0.88),
                text: Color.primary,
                card: Color(.secondarySystemBackground),
                background: Color(.systemBackground),
                accent: Color(red: 0.99, green: 0.58, blue: 0.20)
            )
        case .neon:
            return .init(
                header: Color.pink,
                text: Color.white,
                card: Color.black.opacity(0.85),
                background: Color.black,
                accent: Color.cyan
            )
        case .mono:
            return .init(
                header: Color.gray,
                text: Color(.label),
                card: Color(.secondarySystemBackground),
                background: Color(.systemBackground),
                accent: Color.gray.opacity(0.6)
            )
        }
    }
}

struct ThemePalette {
    let header: Color
    let text: Color
    let card: Color
    let background: Color
    let accent: Color
}
