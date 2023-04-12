//
//  NewPlayerViewController.swift
//  Score Keeper
//
//  Created by David Granger on 4/10/23.
//

import UIKit


class NewPlayerViewController: UIViewController, UITextFieldDelegate {
    
    var playerScore: Int = 0
    var player: Player?
    
    @IBAction func SavePlayerBTN(_ sender: UIButton) {
        if let player = player {
            var counter = 0
            for object in players {
                if player.id == object.id {
                    players.remove(at: counter)
                }
                counter += 1
            }
            players.append(Player(playerName: playerNameTXT.text ?? "", playerScore: playerScore))
        } else {
            players.append(Player(playerName: playerNameTXT.text ?? "", playerScore: playerScore))
        }
        navigationController?.popViewController(animated: true)
    }
    
    @IBOutlet weak var ScoreLBL: UILabel!
    @IBOutlet weak var playerNameTXT: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ScoreLBL.text = "0"
        playerNameTXT.delegate = self
        if let player = player {
            playerNameTXT.text = player.playerName
            ScoreLBL.text = String(describing: player.playerScore)
            stepperOutlet.value = Double(player.playerScore)
            playerScore = player.playerScore
        }
        // Do any additional setup after loading the view.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        playerNameTXT.resignFirstResponder()
        return true
    }
    
    @IBOutlet weak var stepperOutlet: UIStepper!
    @IBAction func stepperChanged(_ sender: Any) {
        playerScore = Int(stepperOutlet.value)
        ScoreLBL.text = String(describing: playerScore)
    }
}
