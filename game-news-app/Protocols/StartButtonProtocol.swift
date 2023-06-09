//
//  StartButtonProtocol.swift
//  game-news-app
//
//  Created by Milan Parađina on 02.05.2023..
//

import UIKit

protocol StartButtonDelegate {
   func startButtonPressed(_ sender:UIButton)
}

protocol WebsiteLabelDelegate {
    func labelPressed(link: String)
}

protocol StoreButtonDelegate {
    func storeButtonPressed(link: String)
}
