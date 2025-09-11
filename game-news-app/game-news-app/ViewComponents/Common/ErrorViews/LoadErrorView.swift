//
//  LoadErrorView.swift
//  game-news-app
//
//  Created by Milan Parađina on 11.09.2025..
//

import SwiftUI

struct LoadErrorView: View {
    let title: String
    let errorText: String
    let buttonTitle: String
    let onButtonressed: () -> Void
    
    var body: some View {
        VStack(spacing: 12) {
            Text(title)
                .font(.appBoldFont(size: 24))
                .foregroundStyle(AppColors.appHeaderText)
            
            Text(errorText)
                .foregroundStyle(AppColors.appCellColor)
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
