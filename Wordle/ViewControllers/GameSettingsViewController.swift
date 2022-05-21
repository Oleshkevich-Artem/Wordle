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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.tintColor = .white
        attemptsNumberLabel.layer.cornerRadius = attemptsNumberLabel.frame.height / 2
        attemptsNumberLabel.clipsToBounds = true
        attemptsNumberLabel.text = "6"
        
        plusAttemptButton.layer.cornerRadius = plusAttemptButton.frame.height / 2
        minusAttemptButton.layer.cornerRadius = minusAttemptButton.frame.height / 2
    }
   
    @IBAction func playAction(_ sender: Any) {
        guard let gameViewController = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "GameViewController") as? GameViewController else { return }
        
        if let attemptsNumberText = attemptsNumberLabel.text {
            if let intAttempts = Int(attemptsNumberText) {
                gameViewController.gameManager = GameManager(attemptsNumber: intAttempts)
            }
        }
        
        gameViewController.modalTransitionStyle = .crossDissolve
        gameViewController.modalPresentationStyle = .fullScreen
        
        self.navigationController?.present(gameViewController, animated: true)
    }
    
    @IBAction func minusOneAtteptAction(_ sender: Any) {
        if let attemptsNumberText = attemptsNumberLabel.text {
            if var intAttempts = Int(attemptsNumberText) {
                if intAttempts == 3 { return }
                else {
                    intAttempts -= 1
                    attemptsNumberLabel.text = String(intAttempts)
                }
            }
        }
    }
    
    @IBAction func plusOneAttemptAction(_ sender: Any) {
        if var attemptsNumberText = attemptsNumberLabel.text {
            if var intAttempts = Int(attemptsNumberText) {
                if intAttempts == 8 { return }
                else {
                    intAttempts += 1
                    attemptsNumberLabel.text = String(intAttempts)
                }
            }
        }
    }
}
