//
//  Constants.swift
//  game-news-app
//
//  Created by Milan Parađina on 27.04.2023..
//

import Foundation

struct K {
    static let rawgApiKey = "d02fab6a726a49f7b2891018368571e7"
    static let isUserOnboarded = "isUserOnboarded"
    
    struct FirebaseEvents {
        static let userOnboardFinished = "userOnboardFinished"
        static let userOnboardReset = "userOnboardReset"
        static let enteredCategory = "enteredCategory"
        static let enteredGame = "enteredGame"
    }
}
