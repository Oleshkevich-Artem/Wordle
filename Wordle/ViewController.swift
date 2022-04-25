//
//  ViewController.swift
//  Wordle
//
//  Created by Artem Oleshkevich on 25.04.22.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var keybordContainer: KeybordView!
    
    private let keyboardManager = KeyboardManager()
    
    private let letterBox: LetterBox? = LetterBox(letter: "a", status: .matched)
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        keybordContainer.updateKeyboardSymbols(keyboardManager.keyboardSymbols)
    }
}
    


