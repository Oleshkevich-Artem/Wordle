//
//  LettersView.swift
//  Wordle
//
//  Created by Oleshkevich Artem on 30.04.22.
//

import UIKit

class GameField: UIStackView {
    var gameField: [[LetterBox?]]
    
    private var letterBoxViews: [[LetterBoxView]]?
    
    init(gameField: [[LetterBox?]]) {
        self.gameField = gameField
        
        super.init(frame: .zero)
        
        self.setUpView()
    }
    
    required init(coder: NSCoder) {
        self.gameField = []
        
        super.init(coder: coder)
        
        self.setUpView()
    }
    
    private func setUpView() {
        self.axis = .vertical
        self.alignment = .fill
        self.distribution = .fillEqually
        self.spacing = 10
        
        createField()
    }
    
    private func createField() {
        self.letterBoxViews = []
        
        for row in gameField {
            let stackView = UIStackView()
            stackView.axis = .horizontal
            stackView.alignment = .fill
            stackView.distribution = .fill
            stackView.spacing = 10
            
            self.addArrangedSubview(stackView)
            
            var letterBoxRow = [LetterBoxView]()
            
            for letter in row {
                let letterBoxView = LetterBoxView(letterBox: letter)
                
                letterBoxView.translatesAutoresizingMaskIntoConstraints = false
                
                NSLayoutConstraint.activate([
                    letterBoxView.widthAnchor.constraint(equalTo: letterBoxView.heightAnchor)
                ])
                
                stackView.addArrangedSubview(letterBoxView)
                
                letterBoxRow.append(letterBoxView)
            }
            
            self.letterBoxViews?.append(letterBoxRow)
        }
    }
    
    func updateGameField(_ gameField: [[LetterBox?]]) {
        self.gameField = gameField
        
        if letterBoxViews == nil || letterBoxViews?.isEmpty == true {
            createField()
        }
        
        guard let letterBoxViews = letterBoxViews else {
            return
        }

        for (rowIndex, row) in gameField.enumerated() {
            for (letterIndex, letterBox) in row.enumerated() {
                letterBoxViews[rowIndex][letterIndex].updateLetterBox(letterBox: letterBox)
            }
        }
    }
}

