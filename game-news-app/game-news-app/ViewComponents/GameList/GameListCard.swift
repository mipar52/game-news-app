//
//  GameListCard.swift
//  game-news-app
//
//  Created by Milan Parađina on 12.09.2025..
//

import SwiftUI

struct GameListCard: View {
    @EnvironmentObject var theme: ThemeManager
    @EnvironmentObject var settings: SettingsStore

    let gamePreview: GamePreview

    private var m: CardMetrics { .forColumns(settings.numberOfColumns) }

    var body: some View {
        VStack(alignment: .leading, spacing: m.spacing) {

            // Image area scales height from width via aspectRatio
            ZStack(alignment: .bottomLeading) {
                // Fallback gradient while loading/error
                LinearGradient(
                    colors: [theme.theme.palette.background, theme.theme.palette.accent],
                    startPoint: .top, endPoint: .bottom
                )

                if let urlStr = gamePreview.backgroundImage,
                   let url = URL(string: urlStr) {
                    AsyncImage(url: url) { phase in
                        switch phase {
                        case .empty:
                            Color.clear
                                .redacted(reason: .placeholder)
                        case .success(let img):
                            img.resizable()
                                .scaledToFill()
                                .transition(.opacity)
                                .accessibilityHidden(true)
                        case .failure:
                            Color(.tertiarySystemFill)
                        @unknown default:
                            Color(.tertiarySystemFill)
                        }
                    }
                    .frame(maxWidth: UIScreen.main.bounds.width / CGFloat(settings.numberOfColumns))
                    .drawingGroup()
                    .overlay(
                        LinearGradient(
                            colors: [.black.opacity(0.45), .clear],
                            startPoint: .bottom, endPoint: .center
                        )
                    )
                }

                if let score = gamePreview.metacritic {
                    Text("\(score)")
                        .font(.system(size: m.subtitleFont, weight: .bold))
                        .padding(.horizontal, m.badgePadding)
                        .padding(.vertical, 2)
                        .background(scoreColor(score), in: Capsule())
                        .foregroundStyle(Color.white)
                        .padding(8)
                        .accessibilityLabel("Metacritic \(score)")
                }
            }
            .aspectRatio(16/9, contentMode: .fit)
            .clipShape(RoundedRectangle(cornerRadius: m.corner, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: m.corner, style: .continuous)
                    .strokeBorder(theme.theme.palette.card, lineWidth: 1.5)
            )
            .clipped()

            Text(gamePreview.name)
                .font(.system(size: m.titleFont, weight: .semibold))
                .foregroundStyle(theme.theme.palette.header)
                .scaledToFit()
                .lineLimit(2)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: .infinity, alignment: .leading)

            Text(metacriticSubtitle)
                .font(.system(size: m.subtitleFont, weight: .medium))
                .foregroundStyle(theme.theme.palette.text)
                .lineLimit(1)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(8)
        .contentShape(RoundedRectangle(cornerRadius: m.corner, style: .continuous))
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(gamePreview.name). \(a11yScoreText)")
    }

    private var metacriticSubtitle: String {
        if let s = gamePreview.metacritic { "Metacritic: \(s)" }
        else { "No Metacritic score yet" }
    }

    private var a11yScoreText: String {
        if let s = gamePreview.metacritic { "Metacritic \(s)" } else { "No score" }
    }

    private func scoreColor(_ s: Int) -> Color {
        switch s {
        case 90...: return .green
        case 80..<90: return .yellow
        case 60..<80: return .orange
        default: return .red
        }
    }
}

#Preview {
//    GameListCard(gamePreview: GamePreview(id: 0, slug: "elden_ring", name: "Elden Ring", metacritic: 83, backgroundImage: "elden_ring.jpg"), )
}
