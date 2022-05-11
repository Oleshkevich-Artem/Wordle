//
//  KeybordManager.swift
//  Wordle
//
//  Created by Oleshkevich Artem on 26.04.22.
//

import Foundation

struct KeyboardManager {
    private let resultWord: String
    private var enteredStrings: [String] = []
    private let lettersCount: Int
    
    var keyboardSymbols: [[KeyboardBox]]
    
    init(resultWord: String = "swift") {
        self.resultWord = resultWord
        self.lettersCount = resultWord.count
        
        let letters = [
            ["q", "w", "e", "r", "t", "y", "u", "i", "o", "p"],
            ["a", "s", "d", "f", "g", "h", "j", "k", "l"],
            ["z", "x", "c", "v", "b", "n", "m"]
        ]
        
        self.keyboardSymbols = letters
            .enumerated().map { index, row in
                let symbolsRow = row.map { character in
                    KeyboardBox(symbol: .character(character))
                }
                
                if index == letters.count - 1 {
                    return [KeyboardBox(symbol: .enter)] + symbolsRow + [KeyboardBox(symbol: .delete)]
                }
                
                return symbolsRow
            }
    }
    
    mutating func handleButtonTap(_ symbol: KeyboardSymbol) {
        switch symbol {
        case .enter:
            checkWord()
        case .delete:
            deleteLastLetter()
        case .character(let string):
            addLetter(string)
        }
    }
    
    private mutating func checkWord() {
        let resultWordArray = Array(resultWord)
        for (index, letter) in self.enteredStrings.enumerated() {
            
            if letter == String(resultWordArray[index]) {
                
                for (rowIndex, keyboardBoxRow) in self.keyboardSymbols.enumerated() {
                    
                    for (boxIndex, keyboardBox) in keyboardBoxRow.enumerated() {
                        
                        if self.keyboardSymbols[rowIndex][boxIndex].symbol == .character(letter) {
                            self.keyboardSymbols[rowIndex][boxIndex].status = .matched
                            
                            continue
                        }
                    }
                }
            }
            
            else if letter != String(resultWordArray[index]) && String(resultWordArray).contains(letter) {
                
                for (rowIndex, keyboardBoxRow) in self.keyboardSymbols.enumerated() {
                    
                    for (boxIndex, keyboardBox) in keyboardBoxRow.enumerated() {
                        if self.keyboardSymbols[rowIndex][boxIndex].status == .matched {
                        }
                        else {
                            if self.keyboardSymbols[rowIndex][boxIndex].symbol == .character(letter) {
                            self.keyboardSymbols[rowIndex][boxIndex].status = .wrongPlace
                            
                            continue
                            }
                        }
                    }
                }
            }
            
            else if letter != String(resultWordArray[index]) {
                
                for (rowIndex, keyboardBoxRow) in self.keyboardSymbols.enumerated() {
                    
                    for (boxIndex, keyboardBox) in keyboardBoxRow.enumerated() {
                        
                        if self.keyboardSymbols[rowIndex][boxIndex].symbol == .character(letter) {
                            
                            self.keyboardSymbols[rowIndex][boxIndex].status = .notExist
                            continue
                        }
                    }
                }
            }
        }
        self.enteredStrings.removeAll()
    }
    
    private mutating func deleteLastLetter() {
        if self.enteredStrings.isEmpty == false {
            self.enteredStrings.removeLast()
        }
    }
    
    private mutating func addLetter(_ letter: String) {
        if enteredStrings.count <= resultWord.count - 1 {
            self.enteredStrings.append(letter)
        }
    }
}
