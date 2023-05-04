//
//  GameGenreSelectTableViewController.swift
//  game-news-app
//
//  Created by Milan Parađina on 28.04.2023..
//

import UIKit
import Kingfisher

class GameGenreSelectTableViewController: UITableViewController {
    
    var gameGanres: [Results] = []
    let userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBarItem()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView = UITableView(frame: .zero, style: .insetGrouped)
        self.tableView.separatorStyle = .singleLine
        setupUI()
        setupNavController()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return gameGanres.count
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
            cell.layer.borderColor = Colors.textColor.cgColor

            let ganre = gameGanres[indexPath.section]
            cell.imageView?.kf.setImage(with: ganre.image_background, placeholder: UIImage(systemName: Text.UIImages.controllerFill))
            cell.imageView?.tintColor = Colors.backgroundColor
            cell.textLabel?.text = ganre.name
            cell.textLabel?.font = Fonts.bold(ofSite: 20)
            cell.textLabel?.textColor = Colors.headerText
            cell.textLabel?.adjustsFontSizeToFitWidth = true
        
            if let name = ganre.games.first?.name {
                cell.detailTextLabel?.text = "\(String(describing: name)) & more"
                cell.detailTextLabel?.font = Fonts.semibold(ofSite: 10)
                cell.detailTextLabel?.textColor = Colors.textColor
                cell.detailTextLabel?.adjustsFontSizeToFitWidth = true
            }
            
            cell.imageView?.snp.makeConstraints { make in
                make.height.equalTo(100)
                make.width.equalTo(130)
                make.left.lessThanOrEqualToSuperview()
            }
            
            cell.textLabel?.snp.makeConstraints { make in
                make.left.equalTo(cell.imageView!.snp.right).offset(16)
                make.top.equalTo(cell.snp.topMargin).offset(8)
                make.right.equalTo(cell.snp.rightMargin).offset(-2)
            }
            
            cell.detailTextLabel?.snp.makeConstraints { make in
                make.left.equalTo(cell.imageView!.snp.right).offset(16)
                make.top.equalTo(cell.textLabel!.snp.bottom).offset(5)
                make.right.equalTo(cell.snp.rightMargin).offset(-2)
            }
            
            cell.imageView?.addRoundedCorners(corners: [.layerMaxXMaxYCorner, .layerMaxXMinYCorner], radius: 8.0)
            cell.layer.masksToBounds = true
            cell.layer.cornerRadius = 5
            
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.getGames(indexPath.section)
    }
}

extension GameGenreSelectTableViewController {
    
    private func setupBarItem() {
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
    }
    
    private func setupUI() {
        navigationController?.navigationBar.barTintColor = Colors.headerText
        view.backgroundColor = Colors.headerText
        self.tableView.backgroundColor = Colors.backgroundColor
        self.tableView.separatorStyle = .singleLine
        self.tableView.rowHeight = UITableView.automaticDimension
        self.title = "Select your category"
        tableView.reloadData()
    }


}

extension GameGenreSelectTableViewController {
    func getGames(_ gameGanreIndex: Int) {
        UIAlertFactory.buildSpinner(message: Text.Alert.games, vc: self)
        Task {
            do {
                let titleView = UIImageView()
                let gameListVC = GameListTableViewController()
                let games = self.gameGanres[gameGanreIndex].games
                titleView.kf.setImage(with: gameGanres[gameGanreIndex].image_background)
                
                for game in games {
                    let obtainedGame = try await NetworkManager.sharedInstance.getGamebyId(id: game.id)
                    switch obtainedGame {
                    case .success(let success):
                        if let obtainedGame = success {
                            gameListVC.gameList.append(obtainedGame)
                        }
                    case .failure(let failure):
                        self.dismiss(animated: true) { [unowned self] in
                            UIAlertFactory.buildErrorAlert(message: Text.Alert.errorMessage, vc: self)
                        }
                        print(failure.localizedDescription)
                        break
                    }
                }
                gameListVC.titleImageView = titleView
                gameListVC.gameGenreTitle = gameGanres[gameGanreIndex].name
                FirebaseManager.sharedInstance.logFBevent(eventTitle: K.FirebaseEvents.enteredCategory + ":\(gameGanres[gameGanreIndex].name)")
                self.dismiss(animated: true) { [weak self] in
                    self?.navigationController?.pushViewController(gameListVC, animated: true)
                }
            } catch {
                UIAlertFactory.buildErrorAlert(message: Text.Alert.errorMessage, vc: self)
                print(error)
            }
        }
    }
    
    @objc func restartFlow() {
        UIAlertFactory.buildTwoActionAlert(title: Text.Alert.exitTitle, message: Text.Alert.exitMessage, actionTitle: Text.Alert.yes, vc: self) { [weak self] _ in
            self?.userDefaults.set(false, forKey: K.isUserOnboarded)
            FirebaseManager.sharedInstance.logFBevent(eventTitle: K.FirebaseEvents.userOnboardReset)
            self?.dismiss(animated: true)
        }
        
    }

}
