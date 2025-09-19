//
//  String+Extension.swift
//  game-news-app
//
//  Created by Milan Parađina on 13.09.2025..
//

import UIKit

extension String {
    var htmlToAttributedString: AttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            let ns = try NSAttributedString(
                data: data,
                options: [.documentType: NSAttributedString.DocumentType.html,
                          .characterEncoding: String.Encoding.utf8.rawValue],
                documentAttributes: nil
            )
            return AttributedString(ns)
        } catch { return nil }
    }

    var htmlStripped: String {
        htmlToAttributedString.map(String.init) ?? self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression)
    }
}
