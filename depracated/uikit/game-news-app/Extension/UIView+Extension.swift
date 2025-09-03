//
//  UIView+Extension.swift
//  game-news-app
//
//  Created by Milan Parađina on 30.04.2023..
//

import UIKit

extension UIView {
    func addShadow(off:CGSize, color: UIColor, radius: CGFloat, opacity:Float) {
        layer.cornerRadius = radius
        layer.masksToBounds = true
        layer.shadowOffset = off
        layer.shadowColor = color.cgColor
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
        let backgroundCGColor = backgroundColor?.cgColor
        backgroundColor = nil
        layer.backgroundColor = backgroundCGColor
    }
    
    func addCornerRadius(radius: CGFloat) {
        layer.masksToBounds = false
        layer.cornerRadius = radius
    }
    
    func addRoundedCorners(corners: CACornerMask, radius: CGFloat) {
        layer.cornerRadius = radius
        layer.maskedCorners = [corners]
    }
    
        func pinTo(_ view: UIView) {
            translatesAutoresizingMaskIntoConstraints = false
            heightAnchor.constraint(equalToConstant: 50).isActive = true
            leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -12).isActive = true
        }

    
}
