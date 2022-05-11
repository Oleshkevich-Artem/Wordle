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
    
    private var gameManager = GameManager()
    private var keyboardManager = KeyboardManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gameFieldView.updateGameField(gameManager.gameField)
        
        keyboardContainer.delegate = self
        keyboardContainer.updateKeyboardSymbols(keyboardManager.keyboardSymbols)
    }
}

extension GameViewController: KeyboardButtonDelegate {    
    func handleButtonTap(_ symbol: KeyboardSymbol) {
        gameManager.handleKeyboardSymbolEnter(symbol)
        keyboardManager.handleButtonTap(symbol)
        gameFieldView.updateGameField(gameManager.gameField)
        keyboardContainer.updateKeyboardSymbols(keyboardManager.keyboardSymbols)
    }
}
