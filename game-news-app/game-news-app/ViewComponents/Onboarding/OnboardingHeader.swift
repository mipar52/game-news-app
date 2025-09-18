//
//  OnboardingHeader.swift
//  game-news-app
//
//  Created by Milan Parađina on 09.09.2025..
//

import SwiftUI

struct OnboardingHeader: View {
    @EnvironmentObject var theme: ThemeManager
    var body: some View {
        VStack(spacing: 12) {
                Image(systemName: AppText.UIImages.controllerFill)
                    .font(.largeTitle)
                    .foregroundStyle(theme.theme.palette.header)

                Text("Welcome to Game News App!")
                    .foregroundStyle(theme.theme.palette.header)
                    .font(.appBoldFont(size: 20))
                    .scaledToFit()
                    .padding()
            
            Text("Before you dive in and start exploring, take a look at the quick onboarding section. It's a great way to get started!")
                .foregroundStyle(theme.theme.palette.text)
                .font(.appBoldFont(size: 16))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 8)
        }
    }
}

#Preview {
    OnboardingHeader()
}
