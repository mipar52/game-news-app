//
//  GameListTableViewController.swift
//  game-news-app
//
//  Created by Milan Parađina on 28.04.2023..
//

import UIKit
import Kingfisher

class GameListTableViewController: UITableViewController {
    var gameGenreTitle = String()
    var gameList: [Game] = []
    var titleImageView: UIImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBarItem()
    }

    // MARK: - Table view data source

    override func viewWillAppear(_ animated: Bool) {
        self.tableView = UITableView(frame: .zero, style: .insetGrouped)
        self.tableView.separatorStyle = .singleLine
        setupUI()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return gameList.count
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "gameListCell")
        let game = gameList[indexPath.section]
        
        cell.textLabel?.text = Text.UIStrings.loadingData
        cell.backgroundColor = Colors.backgroundColor
        
        cell.layer.masksToBounds = true
        cell.layer.cornerRadius = 5
        cell.layer.borderWidth = 2
        cell.layer.borderColor = Colors.textColor.cgColor
        
        cell.imageView?.kf.setImage(with: game.background_image, placeholder: UIImage(systemName: Text.UIImages.controllerFill))
        
        cell.imageView?.tintColor = Colors.backgroundColor
        cell.textLabel?.text = game.name_original
        cell.textLabel?.font = Fonts.bold(ofSite: 15)
        cell.textLabel?.textColor = Colors.headerText
        cell.textLabel?.adjustsFontSizeToFitWidth = true
        
        if let metacritic = game.metacritic {
            cell.detailTextLabel?.text = "Metacritic score: \(metacritic)"
        } else {
            cell.detailTextLabel?.text = "Game does not have metacritic score"
        }
        
        cell.detailTextLabel?.font = Fonts.semibold(ofSite: 13)
        cell.detailTextLabel?.textColor = Colors.textColor
        cell.detailTextLabel?.adjustsFontSizeToFitWidth = true
        cell.imageView?.snp.makeConstraints { make in
            make.height.equalTo(100)
            make.width.equalTo(110)
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
        }
        
        cell.imageView?.addRoundedCorners(corners: [.layerMaxXMaxYCorner, .layerMaxXMinYCorner], radius: 8.0)
        cell.layer.masksToBounds = true
        cell.layer.cornerRadius = 5

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let gameDetailVC = GameDetailViewController()
        gameDetailVC.game = gameList[indexPath.section]
        navigationController?.pushViewController(gameDetailVC, animated: true)
    }
}

extension GameListTableViewController {
    
    private func setupUI() {
        self.title = gameGenreTitle
        self.tableView.backgroundColor = Colors.backgroundColor
        self.tableView.separatorStyle = .singleLine
        self.tableView.rowHeight = UITableView.automaticDimension
        
        view.backgroundColor = Colors.backgroundColor
        titleImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 50))
        navigationItem.titleView = titleImageView

        tableView.reloadData()
    }
    
    private func setupBarItem() {

        let sortOne = UIAction(title: Text.UIStrings.sortOne, image: UIImage(systemName: Text.UIImages.a)) { [unowned self] action in
                self.gameList = self.gameList.sorted(by: {$0.name_original < $1.name_original})
                self.tableView.reloadData()
            }
        
        let sortTwo = UIAction(title: Text.UIStrings.sortTwo, image: UIImage(systemName: Text.UIImages.z)) { [unowned self] action in
                self.gameList = self.gameList.sorted(by: {$1.name_original < $0.name_original})
                self.tableView.reloadData()
            }

        let sortThree = UIAction(title: Text.UIStrings.sortThree, image: UIImage(systemName: Text.UIImages.starGood) ) { [unowned self] action in
            self.gameList = self.gameList.sorted(by: { $0.rating > $1.rating })
                self.tableView.reloadData()
            }
        
        let sortFour = UIAction(title: Text.UIStrings.sortFour, image: UIImage(systemName: Text.UIImages.starBad)) { [unowned self] action in
            self.gameList = self.gameList.sorted(by: { $0.rating < $1.rating })
                self.tableView.reloadData()
            }
            
            let elements = [sortOne, sortTwo, sortThree, sortFour]
            elements.forEach { action in
            action.image?.withTintColor(Colors.headerText)
        }
        
        let menu = UIMenu(title: Text.UIStrings.sortGames, image: nil, identifier: nil, options: [], children: elements)
        let image = UIImage(systemName: Text.UIImages.sortSlider)?.withTintColor(Colors.buttonColor, renderingMode: .automatic)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "", image: image, primaryAction: nil, menu: menu)
        self.navigationItem.rightBarButtonItem?.tintColor = Colors.headerText
    }

}
