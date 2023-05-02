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
        setupNavController()
    }
    
    private func setupUI() {
        self.title = "Select your category"
        navigationController?.navigationBar.barTintColor = Colors.headerText
//        navigationController?.navigationBar.tintColor = Colors.headerText
//        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: Colors.headerText]
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
        cell.backgroundColor = Colors.backgroundColor
        cell.layer.masksToBounds = true
        cell.layer.cornerRadius = 5
        cell.layer.borderWidth = 2
        //    cell.imageView?.image = UIImage(systemName: Text.UIImages.controllerFill)
        //    cell.imageView?.tintColor = Colors.headerText
        cell.layer.borderColor = Colors.textColor.cgColor

        if let gameGanres = gameGanres,
           let games = gameGanres[indexPath.section]?.games {
           let ganre = gameGanres[indexPath.section]
            cell.imageView?.kf.setImage(with: ganre?.image_background, placeholder: UIImage(systemName: Text.UIImages.controllerFill))
            cell.imageView?.tintColor = Colors.backgroundColor
            cell.textLabel?.text = gameGanres[indexPath.section]?.name
            cell.textLabel?.font = Fonts.bold(ofSite: 20)
            cell.textLabel?.textColor = Colors.headerText
            cell.textLabel?.adjustsFontSizeToFitWidth = true
            cell.detailTextLabel?.text = "\(games.first!.name) & more"
            cell.detailTextLabel?.font = Fonts.semibold(ofSite: 15)
            cell.detailTextLabel?.textColor = Colors.textColor
            cell.detailTextLabel?.adjustsFontSizeToFitWidth = true
            
            cell.imageView?.snp.makeConstraints { make in
                make.height.equalTo(100)
                make.width.equalTo(130)
                make.topMargin.equalTo(cell.snp.topMargin).offset(5)
                make.bottomMargin.equalTo(cell.snp.bottomMargin).offset(10)
               // make.leftMargin.equalTo(cell.snp.leftMargin)
            }
            
            cell.imageView?.addRoundedCorners(corners: [.layerMaxXMaxYCorner, .layerMaxXMinYCorner], radius: 8.0)
            cell.layer.masksToBounds = true
            cell.layer.cornerRadius = 5
        }
        
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        UIAlertFactory.buildSpinner(message: Text.Alert.games, vc: self)
        let titleView = UIImageView()
        Task {
            let gameListVC = GameListTableViewController()
            do {
                let games = gameGanres?[indexPath.section]?.games
                titleView.kf.setImage(with: gameGanres![indexPath.section]?.image_background)
                for game in games! {
                    let obtainedGame = try await NetworkManager.sharedInstance.getGamebyId(id: game.id)
                    if let obtainedGame = obtainedGame {
                        gameListVC.gameList.append(obtainedGame)
                    } else {
                        UIAlertFactory.buildErrorAlert(message: Text.Alert.errorMessage, vc: self)
                    }
                }
            } catch {
                UIAlertFactory.buildErrorAlert(message: Text.Alert.errorMessage, vc: self)
                print(error)
            }
            
            gameListVC.titleImageView = titleView
            gameListVC.gameGenreTitle = gameGanres![indexPath.section]!.name
            self.dismiss(animated: true) { [weak self] in
                self?.navigationController?.pushViewController(gameListVC, animated: true)
            }
        }
    }
    
    func setupBarItem() {
        let image = UIImage(systemName: Text.UIImages.restartArrow)?.withTintColor(Colors.buttonColor, renderingMode: .automatic)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: image,style: .plain, target: self, action: #selector(restartFlow))
        self.navigationItem.leftBarButtonItem?.tintColor = Colors.headerText
    }
    private func setupNavController() {
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [.foregroundColor: Colors.textColor]
        appearance.largeTitleTextAttributes = [.foregroundColor: Colors.headerText]

        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.tintColor = Colors.headerText
        
        //navigationItem.leftBarButtonItem. = appearance
    }

    @objc func restartFlow() {
        UIAlertFactory.buildTwoActionAlert(title: Text.Alert.exitTitle, message: Text.Alert.exitMessage, actionTitle: Text.Alert.yes, vc: self) { _ in
            self.dismiss(animated: true)
        }
        
    }
}
