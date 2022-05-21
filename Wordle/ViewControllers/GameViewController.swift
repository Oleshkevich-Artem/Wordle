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
    
    var gameManager = GameManager(attemptsNumber: 6)
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
        showAlert(title: "Win!", message: "Congratulations!")
    }
    
    func handleLose() {
        showAlert(title: "Lose :(", message: "Don't worry!")
    }
    
    private func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        
        let restartAction = UIAlertAction(title: "Restart",
                                          style: .default) { _ in
            self.restartGame()
        }
        
        let goBackToMenuAction = UIAlertAction(title: "Go back",
                                               style: .cancel) { _ in
            self.navigationController?.popViewController(animated: true)
        }
        
        alertController.addAction(restartAction)
        alertController.addAction(goBackToMenuAction)
        
        present(alertController, animated: true)
    }
    
    private func restartGame() {
        gameManager.restart()
        keyboardManager = KeyboardManager()
        keyboardContainer.updateKeyboardSymbols(keyboardManager.keyboardSymbols)
        gameFieldView.updateGameField(gameManager.gameField)
    }
}

