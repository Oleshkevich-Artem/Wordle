//
//  MainMenuViewController.swift
//  Wordle
//
//  Created by Oleshkevich Artem on 14.05.22.
//

import UIKit

class MainMenuViewController: UIViewController {

    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var leadersButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = .white
        
        let frames = [settingsButton, leadersButton, playButton]
        for frame in frames {
            frame?.layer.cornerRadius = 40
        }
    }
    
    @IBAction func gameSettings(_ sender: Any) {
        guard let gameSettingsViewController = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: "GameSettingsViewController") as? GameSettingsViewController else { return }
        
        gameSettingsViewController.modalTransitionStyle = .crossDissolve
        gameSettingsViewController.modalPresentationStyle = .fullScreen
        
        self.navigationController?.pushViewController(gameSettingsViewController, animated: true)
    }
    
    @IBAction func leadersBoard(_ sender: Any) {
        guard let leadersboardViewController = UIStoryboard(name: "Main", bundle: nil)
                .instantiateViewController(withIdentifier: "LeadersboardViewController") as? LeadersboardViewController else { return }
        
        leadersboardViewController.modalTransitionStyle = .crossDissolve
        leadersboardViewController.modalPresentationStyle = .fullScreen
        
        self.navigationController?.pushViewController(leadersboardViewController, animated: true)
    }
    
    @IBAction func settingsBoard(_ sender: Any) {
        guard let settingsBoardViewController = UIStoryboard(name: "Main", bundle: nil)
                .instantiateViewController(withIdentifier: "SettingsboardViewController") as? SettingsboardViewController else { return }
        
        settingsBoardViewController.modalTransitionStyle = .crossDissolve
        settingsBoardViewController.modalPresentationStyle = .fullScreen
        
        self.navigationController?.pushViewController(settingsBoardViewController, animated: true)
    }
}
