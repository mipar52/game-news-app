//
//  LoadErrorView.swift
//  game-news-app
//
//  Created by Milan Parađina on 11.09.2025..
//

import SwiftUI

struct LoadErrorView: View {
    @EnvironmentObject var theme: ThemeManager
    let title: String
    let errorText: String
    let buttonTitle: String
    let onButtonressed: () -> Void
    
    var body: some View {
        VStack(spacing: 12) {
            Text(title)
                .font(.appBoldFont(size: 24))
                .foregroundStyle(theme.theme.palette.header)
            
            Text(errorText)
                .foregroundStyle(theme.theme.palette.text)
                .multilineTextAlignment(.center)
            Button(buttonTitle) { onButtonressed() }
                .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}

#Preview {
    LoadErrorView(title: "Couldn't get games", errorText: "Check your internet connection", buttonTitle: "Try again", onButtonressed: {
        debugPrint("Pressed")
    })
}
