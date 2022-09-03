//
//  FameModeViewController.swift
//  Wordle
//
//  Created by Oleshkevich Artem on 16.05.22.
//

import UIKit

class GameSettingsViewController: UIViewController {
    @IBOutlet weak var playButton: UIButton!

    @IBOutlet weak var attemptsNumberLabel: UILabel!
    @IBOutlet weak var plusAttemptButton: UIButton!
    @IBOutlet weak var minusAttemptButton: UIButton!
    
    private var attemptsNumber: Int = 6
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        attemptsNumberLabel.layer.cornerRadius = attemptsNumberLabel.frame.height / 2
        attemptsNumberLabel.clipsToBounds = true
        attemptsNumberLabel.text = String(attemptsNumber)
        
        plusAttemptButton.layer.cornerRadius = plusAttemptButton.frame.height / 2
        minusAttemptButton.layer.cornerRadius = minusAttemptButton.frame.height / 2
        playButton.layer.cornerRadius = 40
    }
   
    @IBAction func playAction(_ sender: Any) {
        guard let gameViewController = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "GameViewController") as? GameViewController else { return }
        
        gameViewController.gameManager = GameManager(attemptsNumber: attemptsNumber)
        
        gameViewController.modalTransitionStyle = .crossDissolve
        gameViewController.modalPresentationStyle = .fullScreen
        
        self.navigationController?.pushViewController(gameViewController, animated: true)
    }
    
    @IBAction func minusOneAtteptAction(_ sender: Any) {
        if attemptsNumber == 3 {
            return
        }
        attemptsNumber -= 1
        attemptsNumberLabel.text = String(attemptsNumber)
    }
    
    @IBAction func plusOneAttemptAction(_ sender: Any) {
        if attemptsNumber == 7 {
            return
        }
        attemptsNumber += 1
        attemptsNumberLabel.text = String(attemptsNumber)
    }
}
