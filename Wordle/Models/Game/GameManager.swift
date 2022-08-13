//
//  GameManager.swift
//  Wordle
//
//  Created by Oleshkevich Artem on 30.04.22.
//

import Foundation
import UIKit

struct GameManager {
    var currentLetterIndexInRow: Int = 0
    var currentAttemptIndex: Int = 0
    
    private var lettersNumber: Int
    private var attemptsNumber: Int
    
    private var resultWord: String! {
        didSet {
            print(resultWord)
        }
    }
    
    var gameField: [[LetterBox?]]
    var delegate: GameDelegate?
    
    var keyboardManager = KeyboardManager()
    
    init(attemptsNumber: Int = 6, letterNumber: Int = 5) {
        self.lettersNumber = letterNumber
        self.attemptsNumber = attemptsNumber
        
        let row: [LetterBox?] = Array(repeating: nil, count: lettersNumber)
        
        self.gameField = Array(repeating: row, count: attemptsNumber)
        self.resultWord = getRandomWordFromTxtFile()
        print(resultWord!)
        self.keyboardManager = KeyboardManager()
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
        if currentLetterIndexInRow < lettersNumber || currentAttemptIndex >= attemptsNumber {
            return
        }
        
        guard let currentWord = getCurrentWord() else {
            return
        }
        
        let resultWordArray = Array(resultWord)
        
        for (index, letter) in currentWord.enumerated() {
            if letter == resultWordArray[index] {
                gameField[currentAttemptIndex][index]?.status = .matched
                for (rowIndex, keyboardBoxRow) in keyboardManager.keyboardSymbols.enumerated() {
                    for (boxIndex, _) in keyboardBoxRow.enumerated() {
                        if keyboardManager.keyboardSymbols[rowIndex][boxIndex].symbol == .character(String(letter)) {
                            keyboardManager.keyboardSymbols[rowIndex][boxIndex].status = .matched
                        }
                    }
                }
                
                continue
            }
            
            if resultWord.contains(letter) {
                gameField[currentAttemptIndex][index]?.status = .wrongPlace
                for (rowIndex, keyboardBoxRow) in keyboardManager.keyboardSymbols.enumerated() {
                    for (boxIndex, _) in keyboardBoxRow.enumerated() {
                        if keyboardManager.keyboardSymbols[rowIndex][boxIndex].symbol == .character(String(letter)) {
                            keyboardManager.keyboardSymbols[rowIndex][boxIndex].status = .wrongPlace
                        }
                    }
                }
                continue
            }
            
            gameField[currentAttemptIndex][index]?.status = .notExist
            for (rowIndex, keyboardBoxRow) in keyboardManager.keyboardSymbols.enumerated() {
                for (boxIndex, _) in keyboardBoxRow.enumerated() {
                    if keyboardManager.keyboardSymbols[rowIndex][boxIndex].symbol == .character(String(letter)) {
                        keyboardManager.keyboardSymbols[rowIndex][boxIndex].status = .notExist
                    }
                }
            }
        }
        
        if currentWord == resultWord {
            handleWin()
            
            return
        }
        
        currentAttemptIndex += 1
        currentLetterIndexInRow = 0
        
        if currentAttemptIndex == attemptsNumber {
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
    
    mutating func handleWin() {
        delegate?.handleWin()
    }
    
    mutating func handleLose() {
        delegate?.handleLose()
    }
    
    private func getRandomWordFromTxtFile() -> String {
        guard let path = Bundle.main.path(forResource: "AllowedWords", ofType: "txt"),
              let allowedWordsArray = try? String(contentsOfFile: path, encoding: String.Encoding.utf8).split(separator: "\n") else { return "wordle"}
        
        guard let randomWord = Array(allowedWordsArray).map(String.init).randomElement() else { return "wordle" }
        return randomWord
    }
    
    func saveData(userName: String) {
        let gameResult = GameResult(userName: userName,
                                    attemptsNumber: currentAttemptIndex,
                                    time: 568)
        
        UserDefaultsService.shared.saveGameResult(gameResult)
        
        let gameResults = UserDefaultsService.shared.getGameResults()
        print(gameResults)
    }
    
    mutating func restart() {
        let row: [LetterBox?] = Array(repeating: nil, count: lettersNumber)
        
        self.gameField = Array(repeating: row,
                               count: attemptsNumber)
        
        currentAttemptIndex = 0
        currentLetterIndexInRow = 0
        
        self.keyboardManager = KeyboardManager()
        
        self.resultWord = getRandomWordFromTxtFile()
    }
}
