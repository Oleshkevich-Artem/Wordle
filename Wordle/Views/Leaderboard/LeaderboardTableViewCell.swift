//
//  LeaderboardTableViewCell.swift
//  Wordle
//
//  Created by Oleshkevich Artem on 29.05.22.
//

import UIKit

class LeaderboardTableViewCell: UITableViewCell {
    
    static let id = "LeaderboardTableViewCell"
    

    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func updateData(gameResult: GameResult) {
        self.usernameLabel.text = gameResult.userName
        self.scoreLabel.text = String(gameResult.attemptsNumber)
    }
    
}
