//
//  OnboardingButtons.swift
//  game-news-app
//
//  Created by Milan Parađina on 09.09.2025..
//

import SwiftUI

struct OnboardingButtons: View {
    @EnvironmentObject var theme: ThemeManager
    @Binding var selectedPage: Int
    @Binding var onboardingFinihsed: Bool
    
    let onboardingPagesCount: Int
    
    let onFinishonboarding: () -> Void
    let onBackPressed: () -> Void
    
    private var isLastPage: Bool {
        selectedPage == onboardingPagesCount - 1
    }
    
    var body: some View {
        VStack {
            Button {
                if selectedPage < onboardingPagesCount - 1 {
                    withAnimation(.snappy(duration: 0.25)) {
                        selectedPage += 1
                    }
                } else {
                    onboardingFinihsed.toggle()
                }
            } label: {
                if !isLastPage {
                    HStack {
                        SFSymbolButton(btnText: "Next", sfSymbolName: "arrow.forward.circle.fill", symbolEffect: nil)

                    }
                } else {
                    withAnimation(.easeIn(duration: 1)) {
                        SFSymbolButton(btnText: "Finish boarding", sfSymbolName: "checkmark.circle", symbolEffect: nil)
                            .padding(.horizontal, 10)  // inner paddings (for capsule to fit properly)
                            .background(theme.theme.palette.text, in: Capsule())

                    }
                }
            }
            .padding(.vertical, 10)
            .padding(.bottom, 15)
            
            Button {
                withAnimation(.spring) {
                    selectedPage = 0
                }
            } label: {
                SFSymbolButton(btnText: "Back", sfSymbolName: "arrow.backward.circle.fill", symbolEffect: nil)
            }
            .opacity(isLastPage ? 1 : 0)
            .allowsTightening(isLastPage)
            .accessibilityHidden(isLastPage)
        }
        .padding(.bottom, 32)
    }
}
    
    #Preview {
        @Previewable @State var selectedPage = 0
        @Previewable @State var onboardingPagesCount = 3
        @Previewable @State var onboardingFinihsed: Bool = false
        OnboardingButtons(selectedPage: $selectedPage, onboardingFinihsed: $onboardingFinihsed, onboardingPagesCount: onboardingPagesCount) {
            
        } onBackPressed: {
            
        }
    }
