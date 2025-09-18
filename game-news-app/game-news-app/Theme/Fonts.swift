//
//  Fonts.swift
//  game-news-app
//
//  Created by Milan Parađina on 04.09.2025..
//

import Foundation
import SwiftUI

extension Font {
    static func appRegularFont(size: CGFloat?) -> Font {
        return Font.custom("AvenirNext-Regular", size: size ?? 16)
    }
    static func appBoldFont(size: CGFloat?) -> Font {
        return Font.custom("AvenirNext-Bold", size: size ?? 16)
    }
    static func appSemiBoldFont(size: CGFloat?) -> Font {
        return Font.custom("AvenirNext-SemiBold", size: size ?? 16)
    }
}
