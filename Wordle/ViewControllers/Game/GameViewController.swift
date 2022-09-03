//
//  ViewController.swift
//  Wordle
//
//  Created by Artem Oleshkevich on 25.04.22.
//

import UIKit

class GameViewController: UIViewController {
    @IBOutlet weak var gameFieldView: GameField!
    @IBOutlet weak var keyboardContainer: KeybordView!
    
    var gameManager = GameManager()
    private var keyboardManager = KeyboardManager()
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gameFieldView.updateGameField(gameManager.gameField)
        gameManager.delegate = self
        
        keyboardContainer.delegate = self
        keyboardContainer.updateKeyboardSymbols(keyboardManager.keyboardSymbols)
    }
}

extension GameViewController: KeyboardButtonDelegate {    
    func handleButtonTap(_ symbol: KeyboardSymbol) {
        gameManager.handleKeyboardSymbolEnter(symbol)
        gameFieldView.updateGameField(gameManager.gameField)
        keyboardContainer.updateKeyboardSymbols(gameManager.keyboardManager.keyboardSymbols)
    }
}

extension GameViewController: GameDelegate {
    func handleWin() {
        showWinAlert(title: "Win!", message: "Congratulations!")
    }
    
    func handleLose() {
        showLoseAlert(title: "Lose!", message: "Don't worry!")
    }
    
    private func showLoseAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
       
        let changeSettingsAction = UIAlertAction(title: "Change settings",
                                          style: .default) { _ in
            self.navigationController?.popViewController(animated: true)
        }
        
        let goBackToMenuAction = UIAlertAction(title: "Main menu",
                                               style: .destructive) { _ in
            self.navigationController?.popToRootViewController(animated: true)
        }
        
        let restartAction = UIAlertAction(title: "Restart",
                                               style: .cancel) {_ in
            self.handleRestartGameAfterLose()
        }
        
        alertController.addAction(restartAction)
        alertController.addAction(goBackToMenuAction)
        alertController.addAction(changeSettingsAction)
        
        present(alertController, animated: true)
    }
    
    private func showWinAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        alertController.addTextField()
        
        let changeSettingsAction = UIAlertAction(title: "Change settings",
                                          style: .default) { _ in
            
            let userName = alertController.textFields?.first?.text ?? "Player"
            self.handleRestartGameAfterWin(userName: userName)
            
            self.navigationController?.popViewController(animated: true)
            
        }
        
        let goBackToMenuAction = UIAlertAction(title: "Main menu",
                                               style: .destructive) { _ in
            
            let userName = alertController.textFields?.first?.text ?? "Player"
            self.handleRestartGameAfterWin(userName: userName)
            
            self.navigationController?.popToRootViewController(animated: true)
        }
        
        let restartAction = UIAlertAction(title: "Restart",
                                               style: .cancel) {_ in
            let userName = alertController.textFields?.first?.text ?? "Player"
            
            self.handleRestartGameAfterWin(userName: userName)
        }
        
        alertController.addAction(restartAction)
        alertController.addAction(goBackToMenuAction)
        alertController.addAction(changeSettingsAction)
        
        present(alertController, animated: true)
    }
    
    private func handleRestartGameAfterWin(userName: String) {
        gameManager.saveData(userName: userName)
        
        gameManager.restart()
        gameFieldView.updateGameField(gameManager.gameField)
        
        keyboardManager = KeyboardManager()
        keyboardContainer.updateKeyboardSymbols(keyboardManager.keyboardSymbols)
    }
    
    private func handleRestartGameAfterLose() {
        gameManager.restart()
        gameFieldView.updateGameField(gameManager.gameField)
        
        keyboardManager = KeyboardManager()
        keyboardContainer.updateKeyboardSymbols(keyboardManager.keyboardSymbols)
    }
}

