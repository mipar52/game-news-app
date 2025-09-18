//
//  MainTabView.swift
//  game-news-app
//
//  Created by Milan Parađina on 13.09.2025..
//

import SwiftUI

struct MainTabView: View {
    @EnvironmentObject private var theme: ThemeManager
    @EnvironmentObject private var settings: SettingsStore

    var body: some View {
        
        TabView {
            Group {
                NavigationStack {
                    GameGenresView(viewModel: GameGenreViewModel(gameApiProvider: RawgIOApiClient()))
                }
                .tabItem {
                    Label("Home", systemImage: "gamecontroller")
                }
                    
                NavigationStack {
                    GameSearchView(viewModel: GameSearchViewModel(service: RawgIOApiClient(), settings: settings))
                }
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass.circle.fill")
                }

                NavigationStack {
                    SettingsView()
                }
                .tabItem {
                    Label("Settings", systemImage: "gear.circle")
                        .tint(theme.theme.palette.header)

                }
            }
            .tint(theme.theme.palette.header)
            
            .toolbarBackground(theme.theme.palette.header, for: .tabBar)
            .toolbarColorScheme(.dark, for: .tabBar)
            .toolbarBackground(.visible, for: .tabBar)

            .toolbarBackground(theme.theme.palette.header, for: .navigationBar)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .navigationBarTitleDisplayMode(.large)

            .navigationBarTitleTextColor(theme.theme.palette.header)
        }
    }
}

#Preview {
    MainTabView()
}

extension View {
    func navigationBarTitleTextColor(_ color: Color) -> some View {
        let uiColor = UIColor(color)
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: uiColor ]
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: uiColor ]
        return self
    }
}
