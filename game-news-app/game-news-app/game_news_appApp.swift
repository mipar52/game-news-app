//
//  game_news_appApp.swift
//  game-news-app
//
//  Created by Milan Parađina on 03.09.2025..
//

import SwiftUI

@main
struct game_news_appApp: App {
    @StateObject private var themeManager = ThemeManager()
    @StateObject private var settings = SettingsStore()

    var body: some Scene {
        WindowGroup {
            OnboardingView()
                .environmentObject(themeManager)
                .environmentObject(settings)
        }
    }
}
