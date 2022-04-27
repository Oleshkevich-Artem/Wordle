//
//  LetterEvaluation.swift
//  Wordle
//
//  Created by Artem Oleshkevich on 25.04.22.
//

import Foundation

//Enumeration describing the state of the letter cell.

enum LetterEvaluation {
    case notExist
    case wrongPlace
    case matched
}
