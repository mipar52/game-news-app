//
//  OnboardingView.swift
//  game-news-app
//
//  Created by Milan Parađina on 03.09.2025..
//

import SwiftUI

struct OnboardingView: View {
    
    @State private var onboardingPages: [OnboardingPage] = [
        .init(id: 0, title: AppText.UIStrings.onboardingTitleOne, description: AppText.UIStrings.onboardingTextOne, image: AppText.UIImages.logoViewImageGameController),
        .init(id: 1, title: AppText.UIStrings.onboardingTitleTwo, description: AppText.UIStrings.onboardingTextTwo, image: AppText.UIImages.onboardingImageTwo),
        .init(id: 2, title: AppText.UIStrings.oboardingTitleThree, description: AppText.UIStrings.onboardingTextThree, image: AppText.UIImages.onboardingImageThree),
        .init(id: 3, title: AppText.UIStrings.onboardingTitleFour, description: AppText.UIStrings.onboardingTextFour, image: AppText.UIImages.onboardingImageFour),
        .init(id: 4, title: AppText.UIStrings.onboardingTitleFive, description: AppText.UIStrings.onboardingTextFive, image: AppText.UIImages.onboardingImageFive),
        .init(id: 5, title: AppText.UIStrings.onboardingTitleOne, description: AppText.UIStrings.onboardingTextOne, image: AppText.UIImages.logoViewImageGameController)
    ]
    
    @State private var selectedPage: Int = 0
    @State private var onboardingFinished: Bool = false
    
    var body: some View {
        
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.appBackground, .appCellColor]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            
            VStack(spacing: 24) {
                OnboardingHeader()
                    .padding(.top, 30)
                Spacer()
                
                OnboardingPageControl(
                    selectedPage: $selectedPage,
                    onboardingPages: onboardingPages)
                
                Spacer()
                
                OnboardingButtons(selectedPage: $selectedPage, onboardingFinihsed: $onboardingFinished, onboardingPagesCount: onboardingPages.count) {
                    print("Finished onboarding")
                } onBackPressed: {
                    withAnimation(.spring) {
                        selectedPage = 0
                    }
                }
            }
        }
        .fullScreenCover(isPresented: $onboardingFinished) {
            MainTabView()
        }
    }
}


#Preview {
    OnboardingView()
}
