//
//  OnboardingPageControl.swift
//  game-news-app
//
//  Created by Milan Parađina on 09.09.2025..
//

import SwiftUI

struct OnboardingPageControl: View {
    @Binding var selectedPage: Int
    @State var onboardingPages: [OnboardingPage]
        
    var body: some View {
        TabView(selection: $selectedPage) {
            ForEach(0..<onboardingPages.count, id: \.self) { currentPage in
                OnboardingCard(page: onboardingPages[currentPage])
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                    .id(currentPage)
            }
        }
        .padding(.horizontal, 20)
        .tabViewStyle(.page)
        .indexViewStyle(.page(backgroundDisplayMode: .always))
        .frame(height: 300)
    }
}

#Preview {
    @Previewable @State var selectedPage: Int = 0
    @Previewable @State var onboardingPages: [OnboardingPage] = [
        .init(id: 0, title: AppText.UIStrings.onboardingTitleOne, description: AppText.UIStrings.onboardingTextOne, image: AppText.UIImages.logoViewImageGameController),
        .init(id: 1, title: AppText.UIStrings.onboardingTitleTwo, description: AppText.UIStrings.onboardingTextTwo, image: AppText.UIImages.logoViewImageGameController),
        .init(id: 2, title: AppText.UIStrings.onboardingTitleFour, description: AppText.UIStrings.onboardingTextFour, image: AppText.UIImages.logoViewImageGameController),
        .init(id: 3, title: AppText.UIStrings.onboardingTitleFive, description: AppText.UIStrings.onboardingTextFive, image: AppText.UIImages.logoViewImageGameController),
        .init(id: 4, title: AppText.UIStrings.onboardingTitleOne, description: AppText.UIStrings.onboardingTextOne, image: AppText.UIImages.logoViewImageGameController),
        .init(id: 5, title: AppText.UIStrings.onboardingTitleOne, description: AppText.UIStrings.onboardingTextOne, image: AppText.UIImages.logoViewImageGameController)
    ]
    
    OnboardingPageControl(selectedPage: $selectedPage, onboardingPages: onboardingPages)
}
