//
//  UILabelFactory.swift
//  game-news-app
//
//  Created by Milan Parađina on 30.04.2023..
//

import UIKit

struct UILabelFactory {
    
    static func build(text: String?, font: UIFont, backgroundColor: UIColor = .clear, textColor: UIColor = Colors.textColor, textAligment: NSTextAlignment = .center) -> UILabel {
        
        let label = UILabel()
        label.text = text
        label.font = font
        label.backgroundColor = backgroundColor
        label.textColor = textColor
        label.textAlignment = textAligment
        
        return label
    }
}
