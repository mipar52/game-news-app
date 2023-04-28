//
//  ViewController.swift
//  game-news-app
//
//  Created by Milan Parađina on 27.04.2023..
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        Task {
            let manager = NetworkManager()
            do {
                try await manager.getGamebyId()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
