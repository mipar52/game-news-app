//
//  LiquidGlassStyle.swift
//  game-news-app
//
//  Created by Milan Parađina on 19.09.2025..
//

import SwiftUI

struct LiquidGlassStyle: ViewModifier {
    let useGlass: Bool
    let solidColor: Color
    
    func body(content: Content) -> some View {
        if #available(iOS 26.0, *) {
            content
                .glassEffect()
        } else {
            content
                .toolbarBackground(solidColor, for: .tabBar)
                .toolbarBackground(.visible, for: .tabBar)
                .toolbarColorScheme(.dark, for: .tabBar)
            
                .toolbarBackground(solidColor, for: .navigationBar)
                .toolbarBackground(.visible, for: .navigationBar)
                .toolbarColorScheme(.dark, for: .navigationBar)
        }
    }
}
