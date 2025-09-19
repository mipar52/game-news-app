//
//  ThemeBarModifiers.swift
//  game-news-app
//
//  Created by Milan Parađina on 18.09.2025..
//

import Foundation
import SwiftUI

struct ThemedBarsModifier: ViewModifier {
    let background: AnyShapeStyle
    let scheme: ColorScheme
    let tint: Color

    func body(content: Content) -> some View {
        content
            .tint(tint)
            // NAV BAR
            .toolbarBackground(background, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarColorScheme(scheme, for: .navigationBar)
            // TAB BAR
            .toolbarBackground(background, for: .tabBar)
            .toolbarBackground(.visible, for: .tabBar)
            .toolbarColorScheme(scheme, for: .tabBar)
    }
}

extension View {
    func themedBars(
        background: some ShapeStyle,
        scheme: ColorScheme = .dark,
        tint: Color
    ) -> some View {
        modifier(ThemedBarsModifier(
            background: AnyShapeStyle(background),
            scheme: scheme,
            tint: tint
        ))
    }
}
