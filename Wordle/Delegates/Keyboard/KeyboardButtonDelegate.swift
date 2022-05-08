//
//  KeyboardButtonDelegate.swift
//  Wordle
//
//  Created by Oleshkevich Artem on 30.04.22.
//

import Foundation

protocol KeyboardButtonDelegate {
    func handleButtonTap(_ symbol: KeyboardSymbol)
}
