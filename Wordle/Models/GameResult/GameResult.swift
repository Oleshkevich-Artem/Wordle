//
//  GameResult.swift
//  Wordle
//
//  Created by Oleshkevich Artem on 28.05.22.
//

import Foundation

struct GameResult: Codable {
    let userName: String
    let attemptsNumber: Int
    let time: Int
}
