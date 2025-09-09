//
//  SFSymbolButton.swift
//  game-news-app
//
//  Created by Milan Parađina on 09.09.2025..
//

import SwiftUI

struct SFSymbolButton: View {
    let btnText: String
    let sfSymbolName: String
    let symbolEffect: SymbolEffectOptions?
    
    var body: some View {
        HStack {
            Text(btnText)
                .font(.appSemiBoldFont(size: 16))
                .foregroundStyle(.white)
            Image(systemName: sfSymbolName)
                .font(.system(size: 28, weight: .semibold))
                .foregroundStyle(AppColors.appYellow)
                .symbolEffect(.bounce, isActive: true)
        }
    }
}

#Preview {
    SFSymbolButton(btnText: "Finish onboarding", sfSymbolName: "checkmark.circle", symbolEffect: nil)
}
