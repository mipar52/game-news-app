//
//  SkeletonGrid.swift
//  game-news-app
//
//  Created by Milan Parađina on 11.09.2025..
//

import SwiftUI

struct SkeletonGrid: View {
    let columns: [GridItem]
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 12) {
                ForEach(0..<20) { _ in
                    ZStack {
                        Image(systemName: AppText.UIImages.logoViewImageDpad)
                            .foregroundStyle(AppColors.appHeaderText)
                            .font(.appBoldFont(size: 20))
                            .symbolEffect(.pulse, isActive: true)
                        
                        RoundedRectangle(cornerRadius: 14)
                            .fill(Color.gray.opacity(0.2))
                            .frame(height: 120)
                            .redacted(reason: .placeholder)
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
