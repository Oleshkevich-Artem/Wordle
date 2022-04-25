//
//  KeybordView.swift
//  Wordle
//
//  Created by Oleshkevich Artem on 26.04.22.
//

import UIKit

class KeybordView: UIStackView {
    var keyboardSymbols: [[KeyboardBox]]
    
    init(keyboardSymbols: [[KeyboardBox]]) {
        self.keyboardSymbols = keyboardSymbols
        
        super.init(frame: .zero)
        
        self.setUpView()
    }
    
    required init(coder: NSCoder) {
        self.keyboardSymbols = []
        
        super.init(coder: coder)
        
        self.setUpView()
    }
    
    private func setUpView() {
        self.axis = .vertical
        self.alignment = .center
        self.distribution = .fillEqually
        self.spacing = 5
        
        createKeyboard()
    }
    
    private func createKeyboard() {
        for row in keyboardSymbols {
            let stackView = UIStackView()
            stackView.axis = .horizontal
            stackView.alignment = .fill
            stackView.distribution = .fill
            stackView.spacing = 5
            
            self.addArrangedSubview(stackView)
            
            for box in row {
                let keyboardBoxView = KeybordBoxView(keyboardBox: box)
                
                stackView.addArrangedSubview(keyboardBoxView)
            }
        }
    }
    
    func updateKeyboardSymbols(_ keyboardSymbols: [[KeyboardBox]]) {
        self.keyboardSymbols = keyboardSymbols
        
        self.createKeyboard()
    }
}
