//
//  GameGenreSelectTableViewController.swift
//  game-news-app
//
//  Created by Milan Parađina on 28.04.2023..
//

import UIKit
import Kingfisher

class GameGenreSelectTableViewController: UITableViewController {
    var gameGanres: [Results?]?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBarItem()
       // setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView = UITableView(frame: .zero, style: .insetGrouped)
        self.tableView.separatorStyle = .singleLine
        setupUI()
    }
    
    private func setupUI() {
        self.title = "Select your category"
        view.backgroundColor = Colors.headerText
        self.tableView.backgroundColor = Colors.backgroundColor
        self.tableView.separatorStyle = .singleLine
        self.tableView.rowHeight = UITableView.automaticDimension
        self.title = "Select your category"
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        if let gameGanres = gameGanres {
            return gameGanres.count
        } else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = Colors.backgroundColor
        return view
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "gameGanresCell")
            cell.textLabel?.text = Text.UIStrings.loadingData
        cell.backgroundColor = Colors.headerText
        //    cell.imageView?.image = UIImage(systemName: Text.UIImages.controllerFill)
        //    cell.imageView?.tintColor = Colors.headerText

        if let gameGanres = gameGanres,
           let games = gameGanres[indexPath.section]?.games {
           let ganre = gameGanres[indexPath.section]
            cell.imageView?.kf.setImage(with: ganre?.image_background, placeholder: UIImage(systemName: Text.UIImages.controllerFill))
            cell.imageView?.tintColor = Colors.backgroundColor
            cell.textLabel?.text = gameGanres[indexPath.section]?.name
            cell.textLabel?.font = Fonts.bold(ofSite: 20)
            cell.textLabel?.textColor = Colors.backgroundColor
            cell.textLabel?.adjustsFontSizeToFitWidth = true
            cell.detailTextLabel?.text = "Games like \(games.first!.name)"
            cell.detailTextLabel?.font = Fonts.regular(ofSite: 10)
            cell.detailTextLabel?.textColor = Colors.backgroundColor
            cell.detailTextLabel?.adjustsFontSizeToFitWidth = true
        }
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let manager = NetworkManager()
        let titleView = UIImageView()
        Task {
            let gameListVC = GameListTableViewController()
            do {
                let games = gameGanres?[indexPath.section]?.games
                titleView.kf.setImage(with: gameGanres![indexPath.section]?.image_background)
                for game in games! {
                    let obtainedGame = try await manager.getGamebyId(id: game.id)
                    gameListVC.gameList.append(obtainedGame!)
                }
            } catch {
                print(error)
            }
            
            gameListVC.titleImageView = titleView
            gameListVC.gameGenreTitle = gameGanres![indexPath.section]!.name
            navigationController?.pushViewController(gameListVC, animated: true)
        }
    }
    
    func setupBarItem() {
        let image = UIImage(systemName: Text.UIImages.restartArrow)?.withTintColor(Colors.buttonColor, renderingMode: .automatic)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: image,style: .plain, target: self, action: #selector(restartFlow))
        self.navigationItem.leftBarButtonItem?.tintColor = Colors.headerText
    }

    @objc func restartFlow() {
        dismiss(animated: true)
    }
}
