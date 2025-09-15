//
//  MainTabView.swift
//  game-news-app
//
//  Created by Milan Parađina on 13.09.2025..
//

import SwiftUI

struct MainTabView: View {
    var body: some View {
        TabView {
            
            Tab {
                GameGenresView(viewModel: GameGenreViewModel(gameApiProvider: RawgIOApiClient()))
            } label: {
                TabLabelView(uiImageString: "gamecontroller", labelString: "Home")
            }
            Tab {
                GameSearchView()
            } label: {
                TabLabelView(uiImageString: "magnifyingglass.circle.fill", labelString: "Search")
            }
            
            Tab {
                
            } label: {
                TabLabelView(uiImageString: "gear.circle", labelString: "Settings")
            }
        }
    }
}

#Preview {
    MainTabView()
}
