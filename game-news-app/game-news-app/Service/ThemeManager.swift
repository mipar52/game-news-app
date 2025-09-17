//
//  ThemeManager.swift
//  game-news-app
//
//  Created by Milan Parađina on 18.09.2025..
//

import Foundation
import SwiftUI

final class ThemeManager: ObservableObject {
    @AppStorage("selectedTheme") private var storedThemeRaw: String = AppTheme.classic.rawValue
    @Published private(set) var theme: AppTheme = .classic

    init() {
        theme = AppTheme(rawValue: storedThemeRaw) ?? .classic
    }

    func setTheme(_ newTheme: AppTheme) {
        theme = newTheme
        storedThemeRaw = newTheme.rawValue
    }

    var colors: ThemePalette { theme.palette }
}
