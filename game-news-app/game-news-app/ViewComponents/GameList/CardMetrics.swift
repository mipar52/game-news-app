//
//  CardMetrics.swift
//  game-news-app
//
//  Created by Milan Parađina on 19.09.2025..
//

import Foundation

struct CardMetrics {
    let titleFont: CGFloat
    let subtitleFont: CGFloat
    let corner: CGFloat
    let spacing: CGFloat
    let badgePadding: CGFloat

    static func forColumns(_ n: Int) -> CardMetrics {
        // clamp 1...4 to keep sizes sensible on small phones
        let cols = max(1, min(n, 4))
        // scale between 1.0 (4 cols) and ~1.35 (1 col)
        let scale = 1.0 + (4.0 - Double(cols)) * 0.15
        return CardMetrics(
            titleFont: CGFloat(16 * scale / 1.2),           // ~22 @1 col, ~16 @4 cols
            subtitleFont: CGFloat(12 * scale / 1.2),        // ~16 @1 col, ~12 @4 cols
            corner: cols == 1 ? 14 : 12,
            spacing: 8,
            badgePadding: cols <= 2 ? 6 : 4
        )
    }
}
