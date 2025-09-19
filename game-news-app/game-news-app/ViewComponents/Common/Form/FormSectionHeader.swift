//
//  FormSectionHeader.swift
//  game-news-app
//
//  Created by Milan Parađina on 18.09.2025..
//

import SwiftUI

struct FormSectionHeader: View {
    @EnvironmentObject var theme: ThemeManager
    let text: String
    var body: some View {
        Text(text)
            .font(.appBoldFont(size: 15))
            .multilineTextAlignment(.leading)
            .foregroundStyle(theme.theme.palette.header)
            .padding(.vertical, 6)
            .frame(maxWidth: .infinity, alignment: .leading)
          //  .background(theme.theme.palette.card.opacity(0.25))
    }
}

#Preview {
   // FormSectionHeader()
}
