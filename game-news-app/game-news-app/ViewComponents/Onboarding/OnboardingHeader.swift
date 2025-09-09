//
//  OnboardingHeader.swift
//  game-news-app
//
//  Created by Milan Parađina on 09.09.2025..
//

import SwiftUI

struct OnboardingHeader: View {
    var body: some View {
        VStack(spacing: 12) {
                Image(systemName: AppText.UIImages.controllerFill)
                    .font(.largeTitle)
                    .foregroundStyle(AppColors.appYellow)

                Text("Welcome to Game News App!")
                    .foregroundStyle(AppColors.appYellow)
                    .font(.appBoldFont(size: 20))
                    .scaledToFit()
                    .padding()
            
            Text("Before you dive in and start exploring, take a look at the quick onboarding section. It's a great way to get started!")
                .foregroundStyle(.white)
                .font(.appBoldFont(size: 16))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 8)
        }
    }
}

#Preview {
    OnboardingHeader()
}
