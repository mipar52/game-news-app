//
//  FirebaseManager.swift
//  game-news-app
//
//  Created by Milan Parađina on 04.05.2023..
//

import Foundation
import FirebaseAnalytics

class FirebaseManager {
    
    static let sharedInstance = FirebaseManager()
    private init() {}
    
    func logFBevent(eventTitle: String) {
        Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
          AnalyticsParameterItemID: "id-\(eventTitle)",
          AnalyticsParameterItemName: eventTitle,
          AnalyticsParameterContentType: "cont",
        ])
    }
}
