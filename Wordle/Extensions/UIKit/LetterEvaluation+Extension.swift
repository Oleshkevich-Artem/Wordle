//
//  LetterEvaluation+Extension.swift
//  Wordle
//
//  Created by Oleshkevich Artem on 27.04.22.
//

import Foundation
import UIKit

extension LetterEvaluation {
    var backgroundColor: UIColor {
        switch self {
        case .notExist:
            return .gray
            
        case .wrongPlace:
            return .orange
            
        case .matched:
            return .green
        }
    }
}
