//
//  SkeletonGrid.swift
//  game-news-app
//
//  Created by Milan Parađina on 11.09.2025..
//

import SwiftUI

struct SkeletonGrid: View {
    @EnvironmentObject var theme: ThemeManager
    let columns: [GridItem]
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 12) {
                ForEach(0..<20) { _ in
                    ZStack {
                        RoundedRectangle(cornerRadius: 14)
                            .fill(theme.theme.palette.card)
                            .frame(height: 120)
                            .redacted(reason: .placeholder)
                        
                        Image(systemName: AppText.UIImages.logoViewImageDpad)
                            .foregroundStyle(theme.theme.palette.header)
                            .tint(theme.theme.palette.header)
                            .font(.appBoldFont(size: 30))
                            .symbolEffect(.pulse, isActive: true)
                    }

                }
            }
            .padding(.horizontal)
            .padding(.top, 8)
        }
    }
}

#Preview {

    SkeletonGrid(columns: [GridItem(.adaptive(minimum: 140, maximum: 12))])
}
