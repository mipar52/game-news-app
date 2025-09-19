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
    case blood
    var id: String { rawValue }

    var name: String {
        switch self {
        case .classic: "Classic"
        case .neon:    "Neon"
        case .blood:    "Blood"
        }
    }

    var palette: ThemePalette {
        switch self {
        case .classic:
            return .init(
                header: AppColors.Classic.appHeaderText,
                text: AppColors.Classic.appTextColor,
                card: AppColors.Classic.appCardBorderColor,
                background: AppColors.Classic.appBackground,
                accent: AppColors.Classic.appAccent
            )
        case .neon:
            return .init(
                header: AppColors.Neon.appHeaderText,
                text: AppColors.Neon.appTextColor,
                card: AppColors.Neon.appCardBorderColor,
                background: AppColors.Neon.appBackground,
                accent: AppColors.Neon.appAccent
            )
        case .blood:
            return .init(
                header: AppColors.Blood.appHeaderText,
                text: AppColors.Blood.appTextColor,
                card: AppColors.Blood.appHeaderText,
                background: AppColors.Blood.appBackground,
                accent: AppColors.Blood.appAccent
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
