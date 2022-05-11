//
//  KeybordBox.swift
//  Wordle
//
//  Created by Oleshkevich Artem on 26.04.22.
//

import Foundation

struct KeyboardBox {
    var symbol: KeyboardSymbol
    var status: LetterEvaluation?
    
    init(symbol: KeyboardSymbol,
         status: LetterEvaluation? = nil) {
        self.symbol = symbol
        self.status = status
    }
}
