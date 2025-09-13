//
//  GameDetailsView.swift
//  game-news-app
//
//  Created by Milan Parađina on 13.09.2025..
//

import SwiftUI

struct GameDetailsView: View {
    @ObservedObject var viewModel: GameDetailsViewModel
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .task {
                viewModel.getGameDetails()
            }
    }
}

#Preview {
    GameDetailsView(viewModel: GameDetailsViewModel(slug: "elden-ring", gameService: RawgIOApiClient()))
}
