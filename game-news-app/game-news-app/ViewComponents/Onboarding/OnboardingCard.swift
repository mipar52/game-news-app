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
    @EnvironmentObject var theme: ThemeManager
    var body: some View {
        ZStack {
            LinearGradient(colors: [theme.theme.palette.background, theme.theme.palette.header, theme.theme.palette.background], startPoint: .topLeading, endPoint: .bottomTrailing)
                .clipShape(RoundedRectangle(cornerRadius: 16))

            VStack(spacing: 8) {
                
                HStack {
                    Image(systemName: page.image)
                        .font(.system(size: 40, weight: .semibold))
                        .foregroundStyle(theme.theme.palette.header)
                    Text(page.title)
                        .font(.appBoldFont(size: 20))
                        .foregroundStyle(.white)
                }
                Text(page.description)
                    .font(.appSemiBoldFont(size: 16))
                    .foregroundStyle(theme.theme.palette.text)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 12)
            }
            .padding()
        }
        .frame(height: 250)
       // .containerRelativeFrame(.horizontal, count: 1, span: 1, spacing: 20)
        .id(page.id)
    }
}

#Preview {
    OnboardingCard(page: OnboardingPage(id: 0, title: "page one", description: "welcome to page one", image: "gamecontroller.circle.fill"))
}
