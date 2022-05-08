//
//  GameManager.swift
//  Wordle
//
//  Created by Oleshkevich Artem on 30.04.22.
//

import Foundation

struct GameManager {
    private var currentLetterIndexInRow: Int = 0
    private var currentAttemptIndex: Int = 0
    
    private var lettersNumber: Int
    private var attemtsNumber: Int
    
    var gameField: [[LetterBox?]]
    
    private let resultWord: String
    
    init(lettersNumber: Int = 5, attemptsNumber: Int = 6) {
        let row: [LetterBox?] = Array(repeating: nil, count: lettersNumber)
        
        self.gameField = Array(repeating: row, count: attemptsNumber)
        
        self.lettersNumber = lettersNumber
        self.attemtsNumber = attemptsNumber
        
        self.resultWord = "world"
    }
    
    mutating func handleKeyboardSymbolEnter(_ symbol: KeyboardSymbol) {
        switch symbol {
        case .enter:
            checkWord()
        case .delete:
            deleteLastLetter()
        case .character(let letter):
            addLetter(letter)
        }
    }
    
    private mutating func checkWord() {
        if currentLetterIndexInRow < lettersNumber || currentAttemptIndex >= attemtsNumber {
            return
        }
        
        guard let currentWord = getCurrentWord() else {
            return
        }
        
        let resultWordArray = Array(resultWord)
        
        for (index, letter) in currentWord.enumerated() {
            if letter == resultWordArray[index] {
                gameField[currentAttemptIndex][index]?.status = .matched
                
                continue
            }
            
            if resultWord.contains(letter) {
                gameField[currentAttemptIndex][index]?.status = .wrongPlace
                
                continue
            }
            
            gameField[currentAttemptIndex][index]?.status = .notExist
        }
        
        if currentWord == resultWord {
            handleWin()
            
            return
        }
        
        currentAttemptIndex += 1
        currentLetterIndexInRow = 0
        
        if currentAttemptIndex == attemtsNumber {
            handleLose()
        }
    }
    
    private func getCurrentWord() -> String? {
        let wordRow = gameField[currentAttemptIndex]
        
        var word = ""
        
        for letterBox in wordRow {
            guard let letter = letterBox?.letter else {
                return nil
            }
            
            word += letter
        }
        return word
    }
    
    private mutating func deleteLastLetter() {
        let previousLetterIndex = currentLetterIndexInRow - 1
        
        if previousLetterIndex < 0 {
            return
        }
        
        gameField[currentAttemptIndex][previousLetterIndex] = nil
        
        currentLetterIndexInRow = previousLetterIndex
    }
    
    private mutating func addLetter(_ letter: String) {
        if currentLetterIndexInRow >= lettersNumber {
            return
        }
        gameField[currentAttemptIndex][currentLetterIndexInRow] = LetterBox(letter: letter, status: nil)
        
        currentLetterIndexInRow += 1
    }
    
    private func handleWin() {
        print("Win")
    }
    
    private func handleLose() {
        print("Lose")
    }
}
   
