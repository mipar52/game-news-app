//
//  GameRatingsView.swift
//  game-news-app
//
//  Created by Milan Parađina on 13.09.2025..
//

import SwiftUI

struct GameRatingsView: View {
    @EnvironmentObject var theme: ThemeManager
    let ratings: [RatingItem]
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Ratings").font(.headline).padding(.horizontal).foregroundStyle(theme.theme.palette.header)
            VStack(spacing: 8) {
                ForEach(ratings, id: \.id) { r in
                    HStack {
                        Text(r.title.capitalized).frame(width: 110, alignment: .leading).foregroundStyle(theme.theme.palette.text)
                        GeometryReader { geo in
                            let width = max(4, geo.size.width * CGFloat(r.percent / 100.0))
                            RoundedRectangle(cornerRadius: 6).fill(theme.theme.palette.header)
                                .frame(width: width, height: 8, alignment: .leading)
                        }
                        .frame(height: 10)
                        Text("\(Int(r.percent))%").frame(width: 50, alignment: .trailing).foregroundStyle(theme.theme.palette.text)
                    }
                    .font(.caption)
                }
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
  //  GameRatingsView()
}
