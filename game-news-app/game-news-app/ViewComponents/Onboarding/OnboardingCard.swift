//
//  OnboardingCard.swift
//  game-news-app
//
//  Created by Milan Parađina on 03.09.2025..
//

import SwiftUI

struct OnboardingCard: View {
    let page: OnboardingPage
    @State private var isActive: Bool = false
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.appBackground, .appRed], startPoint: .topLeading, endPoint: .bottomTrailing)
                .clipShape(RoundedRectangle(cornerRadius: 16))

            VStack(spacing: 8) {
                
                HStack {
                    Image(systemName: page.image)
                        .font(.system(size: 40, weight: .semibold))
                        .foregroundStyle(.black.opacity(0.8))
                    Text(page.title)
                        .font(.system(size: 20, weight: .bold))
                        .foregroundStyle(.white)
                }
                Text(page.description)
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundStyle(.white.opacity(0.9))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 12)
            }
            .padding()
        }
        .frame(height: 250)
        .containerRelativeFrame(.horizontal, count: 1, span: 1, spacing: 20)
        .id(page.id)
    }
}

#Preview {
    OnboardingCard(page: OnboardingPage(id: 0, title: "page one", description: "welcome to page one", image: "gamecontroller.circle.fill"))
}
