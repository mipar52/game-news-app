//
//  UIButton.swift
//  game-news-app
//
//  Created by Milan Parađina on 02.05.2023..
//

import UIKit

struct UIButtonFactory {
    
    static func build(color: UIColor, text: String) -> UIButton {
        let button = UIButton(type: .custom)
        button.backgroundColor = color
        button.tintColor = .white
        button.addCornerRadius(radius: 8.0)
        let text = NSMutableAttributedString(string: text, attributes: [.font: Fonts.bold(ofSite: 20),.foregroundColor: UIColor.white])
        
        button.setAttributedTitle(text, for: .normal)
        return button
    }
}
