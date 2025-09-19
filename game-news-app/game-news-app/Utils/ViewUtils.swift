//
//  ViewUtils.swift
//  game-news-app
//
//  Created by Milan Parađina on 12.09.2025..
//

import Foundation
import SwiftUI

struct ViewUtils {
    @ViewBuilder
    static func getImage(with symbolName: String) -> some View {
        Image(systemName: symbolName)
            .font(.appBoldFont(size: 40))
            //.foregroundStyle(style)
            .symbolEffect(.pulse, isActive: true)
    }
}
