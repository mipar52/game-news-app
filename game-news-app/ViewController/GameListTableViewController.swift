//
//  GameListTableViewController.swift
//  game-news-app
//
//  Created by Milan Parađina on 28.04.2023..
//

import UIKit

class GameListTableViewController: UITableViewController {
    
    var gameList: [Games]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.secondary
        setupBarItem()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let gameList = gameList {
            return gameList.count
        } else {
            return 0
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "gameListCell")
        if let gameList = gameList {
            cell.textLabel?.text = gameList[indexPath.row].name
            cell.accessoryType = .disclosureIndicator
            cell.detailTextLabel?.text = "\(gameList[indexPath.row].id)"
            cell.backgroundColor = Colors.primary
        } else {
            cell.textLabel?.text = "No games to show!"
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let gameDetailVC = GameDetailTableViewController()
        Task {
            let manager = NetworkManager()
            do {
                let id = gameList![indexPath.row].id
                gameDetailVC.game = try await manager.getGamebyId(id: id)
                navigationController?.pushViewController(gameDetailVC, animated: true)
            } catch {
                print(error)
            }
        }
    }
    
    func setupBarItem() {
        let image = UIImage(systemName: "slider.horizontal.3")?.withTintColor(Colors.secondary, renderingMode: .automatic)
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: image,style: .plain, target: self, action: #selector(sortSettings))
        self.navigationItem.rightBarButtonItem?.tintColor = Colors.redish
    }

    @objc func sortSettings() {
        dismiss(animated: true)
    }
}
