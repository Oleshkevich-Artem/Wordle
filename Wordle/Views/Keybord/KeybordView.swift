//
//  KeybordView.swift
//  Wordle
//
//  Created by Oleshkevich Artem on 26.04.22.
//

import UIKit

class KeybordView: UIStackView {
    var keyboardSymbols: [[KeyboardBox]]
    var delegate: KeyboardButtonDelegate?
    
    private var keyboardBoxViews: [[KeybordBoxView]]?
    
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
        self.spacing = 8
        
        createKeyboard()
    }
    
    private func createKeyboard() {
        self.keyboardBoxViews = []
        
        for row in keyboardSymbols {
            let stackView = UIStackView()
            stackView.axis = .horizontal
            stackView.alignment = .fill
            stackView.distribution = .fill
            stackView.spacing = 5
            
            self.addArrangedSubview(stackView)
            
            var keyboardBoxRow = [KeybordBoxView]()
            
            for box in row {
                let keyboardBoxView = KeybordBoxView(keyboardBox: box)
                keyboardBoxView.delegate = delegate
                
                stackView.addArrangedSubview(keyboardBoxView)
                
                keyboardBoxRow.append(keyboardBoxView)
            }
            
            self.keyboardBoxViews?.append(keyboardBoxRow)
        }
    }
    
    func updateKeyboardSymbols(_ keyboardSymbols: [[KeyboardBox]]) {
        self.keyboardSymbols = keyboardSymbols
        
        if keyboardBoxViews == nil || keyboardBoxViews?.isEmpty == true {
            createKeyboard()
        }
        
        guard let keyboardViews = keyboardBoxViews else {
            return
        }

        for (rowIndex, row) in keyboardSymbols.enumerated() {
            for (letterIndex, keyboardBox) in row.enumerated() {
                keyboardViews[rowIndex][letterIndex].updateView(keyboardBox: keyboardBox)
            }
        }
    }
}
