//
//  ThemeShower.swift
//  game-news-app
//
//  Created by Milan Parađina on 17.09.2025..
//

import SwiftUI

struct ThemeShower: View {
    let theme: AppTheme
    let selected: Bool
    let action: () -> Void
    @EnvironmentObject private var tm: ThemeManager

    var body: some View {
        let c = theme.palette
        Button(action: action) {
            VStack(spacing: 6) {
                ZStack {
                    c.header
                    Text("App heading text")
                        .font(.appBoldFont(size: 10))
                        .foregroundStyle(c.text)
                        .padding(.vertical, 6)
                }
                .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))

                ZStack {
                    c.card
                    Text("App regular text")
                        .font(.appSemiBoldFont(size: 10))
                        .foregroundStyle(c.text)
                        .padding(.vertical, 6)
                }
                .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))

                ZStack {
                    c.background
                    Text("Background")
                        .font(.appSemiBoldFont(size: 10))
                        .foregroundStyle(c.text)
                        .padding(.vertical, 6)
                }
                .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
            }
            .padding(6)
            .background(
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(tm.theme == theme ? c.accent.opacity(0.12) : Color.clear)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .stroke(tm.theme == theme ? c.accent : Color.secondary.opacity(0.3), lineWidth: tm.theme == theme ? 2 : 1)
            )
        }
        .buttonStyle(.plain)
        .accessibilityLabel("\(theme.name) theme")
        .accessibilityAddTraits(selected ? .isSelected : [])
    }
}

#Preview {
    //ThemeShower()
}
