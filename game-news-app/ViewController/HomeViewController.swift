//
//  ViewController.swift
//  game-news-app
//
//  Created by Milan Parađina on 27.04.2023..
//

import UIKit

class ViewController: UIViewController {
    let manager = NetworkManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.primary
        setupUI()
//        Task {
//            let manager = NetworkManager()
//            do {
//                try await manager.getGamebyId()
//            } catch {
//                print(error.localizedDescription)
//            }
//        }
    }
    
    func setupUI() {
        lazy var startButton = {
           let button = UIButton()
            button.setTitle(Text.UIStrings.homeScreenButtonText, for: .normal)
            button.titleLabel?.font = Fonts.bold(ofSite: 24)
            button.backgroundColor = Colors.buttonColor
            button.setTitleColor(.white, for: .normal)
            button.frame = CGRect(x: 100, y: 100, width: 300, height: 50)
            button.addTarget(self, action: #selector(didTapStartButton), for: .touchUpInside)
            return button
        }()
        view.addSubview(startButton)
    }
    
    @objc func didTapStartButton() {
        
        let rootVC = GameGenreSelectTableViewController()
        Task {
            do {
                rootVC.gameGanres = try await manager.getGamesGenres().sorted(by: {$0!.name < $1!.name})
            } catch {
                print(error)
            }
            let navigationVC = UINavigationController(rootViewController: rootVC)
            navigationVC.navigationBar.prefersLargeTitles = true
            //rootVC.title = rootVC.gameResults?.results[0].genres[0].name
            navigationVC.modalPresentationStyle = .fullScreen
            present(navigationVC, animated: true)
        }
    }

}
