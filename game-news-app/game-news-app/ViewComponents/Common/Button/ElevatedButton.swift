//
//  ElevatedButton.swift
//  game-news-app
//
//  Created by Milan Parađina on 18.09.2025..
//

import SwiftUI

struct ElevatedButtonModifier: ViewModifier {
    let bg: Color, fg: Color
    var corner: CGFloat = 14
    func body(content: Content) -> some View {
        content
            .font(.headline)
            .foregroundStyle(fg)
            .padding(.vertical, 14)
            .frame(maxWidth: .infinity)
            .background(RoundedRectangle(cornerRadius: corner, style: .continuous).fill(bg))
            .shadow(color: bg.opacity(0.35), radius: 12, x: 0, y: 8)
            .shadow(color: .black.opacity(0.08), radius: 2, x: 0, y: 1)
            .contentShape(RoundedRectangle(cornerRadius: corner, style: .continuous))
    }
}
extension View {
    func elevatedButton(bg: Color, fg: Color, corner: CGFloat = 14) -> some View {
        modifier(ElevatedButtonModifier(bg: bg, fg: fg, corner: corner))
    }
}
