//
//  Colors.swift
//  game-news-app
//
//  Created by Milan Parađina on 03.09.2025..
//

import Foundation
import SwiftUI

extension Color {
    /// Theme: https://coolors.co/palette/000000-14213d-8eb8e5-fca311-e5e5e5-ffffff
    struct Classic {
        static let appBackground = Color(red: 0.08, green: 0.13, blue: 0.24)
        static let appHeaderText = Color(red: 0.99 , green: 0.64 , blue: 0.07 )
        static let appTextColor = Color(red: 0.90 , green: 0.90 , blue: 0.90 )
        static let appButtonColor = Color.white
        static let appCellColor = Color(red: 0.00, green: 0.21 , blue: 0.40 )
        static let appCellDetailColor = Color(red: 0.55 , green: 0.60 , blue: 0.68 )
    }
    /// Theme: https://coolors.co/palette/250902-38040e-640d14-800e13-ad2831
    struct Blood {
        static let appBackground = Color(red: 37 / 255, green: 9 / 255, blue: 2 / 255)
        static let appHeaderText = Color(red: 54 / 255 , green: 4 / 255 , blue: 14 / 255 )
        static let appTextColor = Color(red: 100 / 255 , green:  13 / 255, blue: 20 / 255 )
        static let appButtonColor = Color.white
        static let appCellColor = Color(red: 128 / 255, green: 14 / 255, blue: 19 / 255 )
        static let appCellDetailColor = Color(red: 173 / 255 , green: 40 / 255, blue: 49 / 255)
    }
    /// Theme: https://coolors.co/palette/363537-ef2d56-ed7d3a-8cd867-2fbf71
    struct Neon {
        static let appBackground = Color(red: 54 / 53, green: 53 / 255, blue: 55 / 255)
        static let appHeaderText = Color(red: 239 / 255 , green: 45 / 255 , blue: 68 / 255 )
        static let appTextColor = Color(red: 237 / 255 , green:  125 / 255, blue: 58 / 255 )
        static let appButtonColor = Color.white
        static let appCellColor = Color(red: 140 / 255, green: 216 / 255, blue: 103 / 255 )
        static let appCellDetailColor = Color(red: 47 / 255 , green: 191 / 255, blue: 113 / 255)
    }

}

enum AppColors {
    /// Theme: https://coolors.co/palette/000000-14213d-8eb8e5-fca311-e5e5e5-ffffff
    struct Classic {
        static let appBackground = Color(red: 20 / 255, green: 33 / 255, blue: 61 / 255)
        static let appHeaderText = Color(red: 252 / 255 , green: 163 / 255 , blue: 17 / 255)
        static let appTextColor = Color(red: 1, green: 1, blue: 1)
        static let appSubTextColor = Color(red: 229 / 255 , green: 229 / 255, blue: 229 / 255)
        static let appCardBorderColor = Color(red: 142 / 255 , green: 184 / 255, blue: 229 / 255)
        static let appAccent = Color(red: 0 / 255, green: 0 / 255, blue: 0 / 255)
    }
    /// Theme: https://coolors.co/palette/250902-38040e-640d14-800e13-ad2831
    struct Blood {
        static let appBackground = Color(red: 102 / 255, green: 7 / 255, blue: 8 / 255)
        static let appHeaderText = Color(red: 177 / 255 , green: 167 / 255 , blue: 166 / 255 )
        static let appTextColor = Color(red: 255 / 255 , green:  255 / 255, blue: 255 / 255 )
        static let appSubTextColor = Color(red: 245 / 255 , green: 243 / 255, blue: 244 / 255)
        static let appCardBorderColor = Color(red: 11 / 255 , green: 9 / 255, blue: 10 / 255)
        static let appAccent = Color(red: 177 / 255, green: 167 / 255, blue: 166 / 255)
    }
    /// Theme: https://coolors.co/palette/363537-ef2d56-ed7d3a-8cd867-2fbf71
    struct Neon {
        static let appBackground = Color(red: 95 / 255, green: 180 / 255, blue: 156 / 255)
        static let appHeaderText = Color(red: 104 / 255 , green: 45 / 255 , blue: 99 / 255 )
        static let appTextColor = Color(red: 255 / 255 , green:  255 / 255, blue: 255 / 255 )
        static let appSubTextColor = Color(red: 222 / 255 , green: 239 / 255, blue: 183 / 255)
        static let appCardBorderColor = Color(red: 65 / 255 , green: 66 / 255, blue: 136 / 255)
        static let appAccent = Color(red: 177 / 255, green: 167 / 255, blue: 166 / 255)
    }
}
