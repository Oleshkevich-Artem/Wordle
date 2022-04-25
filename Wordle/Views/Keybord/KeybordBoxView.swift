//
//  KeybordBoxView.swift
//  Wordle
//
//  Created by Oleshkevich Artem on 26.04.22.
//

import UIKit

class KeybordBoxView: UIButton {
    private var keyboardBox: KeyboardBox!
    
    init(keyboardBox: KeyboardBox) {
        self.keyboardBox = keyboardBox
        
        super.init(frame: .zero)
        
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setUpView()
    }
    
    // MARK: - Initial View Setup
    
    private func setUpView() {
        updateView(keyboardBox: keyboardBox)
        
        setTitleFont()
        setCornerRadius()
        addConstrains()
        
        addButtonTapAction()
    }
    
    private func setTitleFont() {
        self.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .bold)
    }
    
    private func setCornerRadius() {
        self.layer.cornerRadius = 4
    }
    
    private func addConstrains() {
        self.translatesAutoresizingMaskIntoConstraints = false

        let multiplier = keyboardBox.symbol == .delete || keyboardBox.symbol == .enter ? 0.75 : 0.5

        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: multiplier)
        ])
    }
    
    // MARK: - Manipulation
    
    private func addButtonTapAction() {
        self.addTarget(self, action: #selector(handleButtonTap), for: .touchUpInside)
    }
    
    @objc private func handleButtonTap() {
        print(keyboardBox.symbol)
    }
    
    // MARK: - View Update
    
    func updateKeyboardBox(keyboardBox: KeyboardBox) {
        self.keyboardBox = keyboardBox
        
        updateView(keyboardBox: keyboardBox)
    }
    
    private func updateView(keyboardBox: KeyboardBox) {
        updateLabel(symbol: keyboardBox.symbol)
        updateBackground(status: keyboardBox.status)
    }
    
    private func updateLabel(symbol: KeyboardSymbol) {
        switch symbol {
        case .character(let character):
            updateTitle(with: character.uppercased())
            
        case .delete:
            updateTitle(with: "<-")
            
        case .enter:
            updateTitle(with: "ENTER")
        }
    }
    
    private func updateTitle(with text: String) {
        setTitle(text, for: .normal)
    }
    
    private func updateBackground(status: LetterEvaluation?) {
        self.backgroundColor = status?.backgroundColor ?? .gray
    }
}
