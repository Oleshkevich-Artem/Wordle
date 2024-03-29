//
//  KeybordManager.swift
//  Wordle
//
//  Created by Oleshkevich Artem on 26.04.22.
//

import Foundation

struct KeyboardManager {
    var keyboardSymbols: [[KeyboardBox]]
    
    init() {
        
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
}
