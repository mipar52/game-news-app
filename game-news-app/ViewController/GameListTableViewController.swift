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
        //titleImageView.contentMode = .scaleAspectFill
        view.backgroundColor = Colors.backgroundColor
        titleImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 50))
        navigationItem.titleView = titleImageView
        setupBarItem()
      //  setupUI()
    }

    // MARK: - Table view data source

    override func viewWillAppear(_ animated: Bool) {
        self.tableView = UITableView(frame: .zero, style: .insetGrouped)
        self.tableView.separatorStyle = .singleLine
        setupUI()
    }
    
    private func setupUI() {
        self.title = gameGenreTitle
        view.backgroundColor = Colors.backgroundColor
        self.tableView.backgroundColor = Colors.backgroundColor
        self.tableView.separatorStyle = .singleLine
        self.tableView.rowHeight = UITableView.automaticDimension
        tableView.reloadData()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
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
        
        cell.imageView?.kf.setImage(with: game.background_image, placeholder: UIImage(systemName: Text.UIImages.controllerFill))
         cell.imageView?.tintColor = Colors.headerText
        cell.textLabel?.text = game.name_original
         cell.textLabel?.font = Fonts.bold(ofSite: 20)
         cell.textLabel?.textColor = Colors.headerText
        cell.textLabel?.adjustsFontSizeToFitWidth = true
        cell.detailTextLabel?.text = "Metacritic score: \(game.metacritic)"
         cell.detailTextLabel?.font = Fonts.regular(ofSite: 10)
         cell.detailTextLabel?.textColor = Colors.textColor
        cell.detailTextLabel?.adjustsFontSizeToFitWidth = true


        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let gameDetailVC = GameDetailViewController()
        gameDetailVC.game = gameList[indexPath.section]
        navigationController?.pushViewController(gameDetailVC, animated: true)
    }
    
    func setupBarItem() {
        let image = UIImage(systemName: Text.UIImages.sortSlider)?.withTintColor(Colors.buttonColor, renderingMode: .automatic)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: image,style: .plain, target: self, action: #selector(sortSettings))
        self.navigationItem.rightBarButtonItem?.tintColor = Colors.redish
    }

    @objc func sortSettings() {
        dismiss(animated: true)
    }
}
