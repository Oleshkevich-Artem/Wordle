//
//  LetterBox.swift
//  Wordle
//
//  Created by Artem Oleshkevich on 25.04.22.
//

import Foundation

//The structure describing the letter cell.

struct LetterBox {
    let letter: String
    let status: LetterEvaluation?
}
