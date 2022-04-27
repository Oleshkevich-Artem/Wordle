//
//  KeybordBox.swift
//  Wordle
//
//  Created by Oleshkevich Artem on 26.04.22.
//

import Foundation

//Structure describing the keyboard key.

struct KeyboardBox {
    let symbol: KeyboardSymbol
    let status: LetterEvaluation?
    
    init(symbol: KeyboardSymbol,
         status: LetterEvaluation? = nil) {
        self.symbol = symbol
        self.status = status
    }
}
