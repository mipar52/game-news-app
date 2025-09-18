//
//  GameLoadingProgressView.swift
//  game-news-app
//
//  Created by Milan Parađina on 18.09.2025..
//

import SwiftUI

struct GameLoadingProgressView: View {
    @EnvironmentObject var theme: ThemeManager
    let text: String
    let onPress: () -> Void
    
    var body: some View {
        VStack {
            ProgressView()
                .padding(.vertical, 16)
            Text(text)
                .font(.appSemiBoldFont(size: 14))
                .foregroundStyle(theme.theme.palette.header)
        }
        .frame(maxWidth: .infinity)
        .task {
            onPress()
        }
    }
}

#Preview {
    GameLoadingProgressView(text: "Hang tight...") {
        print("hello")
    }
}
