//
//  Int+Extension.swift
//  game-news-app
//
//  Created by Milan Parađina on 13.09.2025..
//

import Foundation

extension Int {
    var compact: String { formatted(.number.notation(.compactName)) } // e.g. 6.9K
}
