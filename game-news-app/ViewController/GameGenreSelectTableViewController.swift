//
//  GameGenreSelectTableViewController.swift
//  game-news-app
//
//  Created by Milan Parađina on 28.04.2023..
//

import UIKit

class GameGenreSelectTableViewController: UITableViewController {
    var gameGanres: [Results?]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Select your category"
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if let gameGanres = gameGanres {
            return gameGanres.count
        } else {
            return 1
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "gameGanresCell")
        
        if let gameGanres = gameGanres {
            let ganre = gameGanres[indexPath.row]
            cell.textLabel?.text = ganre!.name
            cell.textLabel?.font = Fonts.bold(ofSite: 30)
//            TODO: download game category image -> https://stackoverflow.com/questions/24231680/loading-downloading-image-from-url-on-swift
            if let url = URL(string: "\(ganre!.image_background)" ) {
                let task = URLSession.shared.dataTask(with: url) { data, response, error in
                    guard let data = data, error == nil else { return }
                    
                    DispatchQueue.main.async { /// execute on main thread
                        cell.imageView?.image = UIImage(data: data)
                        //tableView.reloadData()
                    }
                }
                
                task.resume()
            }
            cell.detailTextLabel?.text = "Games in the category: \(ganre!.games.count)"
            cell.detailTextLabel?.font = Fonts.semibold(ofSite: 15)
            cell.backgroundColor = Colors.orangeish
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120.0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let gameListVC = GameListTableViewController()
        gameListVC.gameList = gameGanres?[indexPath.row]?.games
        navigationController?.pushViewController(gameListVC, animated: true)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
