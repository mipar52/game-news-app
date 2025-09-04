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
        .init(id: 1, title: AppText.UIStrings.onboardingTitleTwo, description: AppText.UIStrings.onboardingTextTwo, image: AppText.UIImages.logoViewImageGameController),
        .init(id: 2, title: AppText.UIStrings.onboardingTitleFour, description: AppText.UIStrings.onboardingTextFour, image: AppText.UIImages.logoViewImageGameController),
        .init(id: 3, title: AppText.UIStrings.onboardingTitleFive, description: AppText.UIStrings.onboardingTextFive, image: AppText.UIImages.logoViewImageGameController),
        .init(id: 4, title: AppText.UIStrings.onboardingTitleOne, description: AppText.UIStrings.onboardingTextOne, image: AppText.UIImages.logoViewImageGameController),
        .init(id: 5, title: AppText.UIStrings.onboardingTitleOne, description: AppText.UIStrings.onboardingTextOne, image: AppText.UIImages.logoViewImageGameController)
    ]
    
    @State private var selectedPage: Int? = 0
    private var selectedIndex: Int {
        onboardingPages.firstIndex(where: { $0.id == selectedPage }) ?? 0
    }
    
    var body: some View {
        
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.appBackground, .appCellColor]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            
            VStack {
                VStack {
                    Image(systemName: AppText.UIImages.controllerFill)
                        .font(.largeTitle)
                        .foregroundStyle(.white)
                    Text("Welcome to Game News App!")
                        .foregroundStyle(.white)
                        .font(.appBoldFont(size: 20))
                        .scaledToFit()
                        .padding()
                }
                .padding(.vertical, 32)

                
                Text("Before you dive in and start exploring, take a look at the quick onboarding section. It's a great way to get started!")
                    .foregroundStyle(.white)
                    .font(.appBoldFont(size: 16))
                    .multilineTextAlignment(.center)
                    .padding()
                
                ScrollView(.horizontal) {
                    LazyHStack(spacing: 16) {
                        ForEach(onboardingPages) { page in
                            OnboardingCard(page: page)
                                .id(page)
                        }
                    }
                    .scrollTargetLayout()
                }
                .contentMargins(.horizontal, 16, for: .scrollContent)
                .scrollIndicators(.hidden)
                .safeAreaPadding(.horizontal, 16)
                .scrollTargetBehavior(.paging)
                .scrollPosition(id: $selectedPage)
                .frame(height: 250)
                
                ZStack {
                    HStack {
                        ForEach(onboardingPages.indices, id: \.self) { pageIndex in
                            Circle()
                                .fill(pageIndex == selectedPage ? Color.white : Color.white.opacity(0.3))
                                .frame(width: 8, height: 8)
                                .onTapGesture {
                                    withAnimation(.spring()) {
                                        selectedPage = pageIndex
                                    }
                                }
                        }
                    }
                    .padding()
                }
                .background(.ultraThinMaterial, in:RoundedRectangle(cornerRadius: 16))
                .contentShape(Rectangle())
                
                Spacer()
                Button {
                    if selectedIndex < onboardingPages.count - 1 {
                        selectedPage = onboardingPages[selectedIndex].id
                        withAnimation(.snappy(duration: 0.25)) {
                            selectedPage! += 1
                        }
                    }
                } label: {
                    if selectedPage! < onboardingPages.count - 1 {
                        HStack {
                            Text("Next")
                                .font(.appSemiBoldFont(size: 16))
                                .foregroundStyle(.white)
                            Image(systemName: "arrow.forward.circle.fill")
                                .font(.system(size: 28, weight: .semibold))
                                .foregroundStyle(.white)
                                .symbolEffect(.bounce, isActive: true)
                        }
                    } else {
                        withAnimation(.easeIn(duration: 0.5)) {
                            Text("Finish boarding")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundStyle(.white)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 8)
                                .background(.white.opacity(0.15), in: Capsule())
                        }

                    }
                }
                .padding(.bottom, 30)
                
                if selectedPage! == onboardingPages.last!.id {
                    Button {
                        withAnimation(.spring) {
                            selectedPage! = 0
                        }
                    } label: {
                        HStack {
                            Image(systemName: "arrow.backward.circle.fill")
                                .font(.system(size: 28, weight: .semibold))
                                .foregroundStyle(.white)
                                .symbolEffect(.pulse, isActive: true)
                            Text("Back")
                                .font(.appSemiBoldFont(size: 16))
                                .foregroundStyle(.white)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    OnboardingView()
}
