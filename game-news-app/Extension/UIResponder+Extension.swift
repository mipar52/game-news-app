//
//  UIResponder.swift
//  game-news-app
//
//  Created by Milan Parađina on 01.05.2023..
//

import UIKit

extension UIResponder {
    var parentViewController: UIViewController? {
        return next as? UIViewController ?? next?.parentViewController
    }
}
