//
//  PlayersTableViewController.swift
//  Score Keeper
//
//  Created by David Granger on 4/10/23.
//

import UIKit

var players: [Player] = []

class PlayersTableViewController: UITableViewController, PlayerCellDelegate {

    var orderChanged = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let checkCount = Player.loadPlayers() {
            if checkCount.count == 0 {
                players = Player.loadSamplePlayers()
            } else {
                players = checkCount
            }
        } else {
            players = Player.loadSamplePlayers()
        }
        
        navigationItem.leftBarButtonItem = editButtonItem
        
        updatePlayerOrder()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return players.count
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updatePlayerOrder()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerIdentifier", for: indexPath) as! PlayerTableViewCell
        
        let player = players[indexPath.row]
        cell.playerNameLBL.text = player.playerName
        cell.playerScoreLBL.text = String(player.playerScore)
        cell.delegate = self
        return cell
    }
    
    
    
    func stepperTapped(sender: PlayerTableViewCell) {
        
        if let indexPath = tableView.indexPath(for: sender) {
            var player = players[indexPath.row]
            player.playerScore += Int(sender.scoreStepperOutlet.value)
            
            if sender.scoreStepperOutlet.value > 0 {
                sender.scoreStepperOutlet.value -= 1
            } else {
                sender.scoreStepperOutlet.value += 1
            }
            players[indexPath.row] = player
            Player.savePlayers(players)
            updatePlayerOrder()
        }
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if orderChanged {
            cell.alpha = 0
            cell.transform = CGAffineTransform(translationX: 0, y: cell.contentView.frame.height)
         
                UIView.animate(
                    withDuration: 0.2,
                    delay: 0.2 * Double(indexPath.row),
                    usingSpringWithDamping: 2,
                    initialSpringVelocity: 0.005,
                    options: [.curveEaseInOut],
                    animations: {
                        cell.alpha = 1
                        cell.transform = CGAffineTransform(translationX: 0, y: 0)
                })
        }
    }
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            players.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    @IBSegueAction func EditExistingPlayer(_ coder: NSCoder, sender: Any?) -> NewPlayerViewController? {
        let newPlayerVC = NewPlayerViewController(coder: coder)
        
        guard let cell = sender as? UITableViewCell,
              let indexPath = tableView.indexPath(for: cell) else {
            return newPlayerVC
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        newPlayerVC?.player = players[indexPath.row]
        
        return newPlayerVC
    }
    
    func updatePlayerOrder() {
        let previousPlayers = players
        players.sort(by: <)
        orderChanged = previousPlayers != players
        tableView.reloadData()
    }
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
