//
//  PlayerTableViewCell.swift
//  Score Keeper
//
//  Created by David Granger on 4/10/23.
//

import UIKit

protocol PlayerCellDelegate {
    func stepperTapped(sender: PlayerTableViewCell)
}

class PlayerTableViewCell: UITableViewCell {
    
    @IBOutlet weak var scoreStepperOutlet: UIStepper!
    
    var delegate: PlayerCellDelegate?
    
    @IBAction func scoreStepper(_ sender: UIStepper) {
        delegate?.stepperTapped(sender: self)
    }
    
    @IBOutlet weak var playerScoreLBL: UILabel!
    @IBOutlet weak var playerNameLBL: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
