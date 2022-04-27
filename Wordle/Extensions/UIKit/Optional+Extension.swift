//
//  Optional+Extension.swift
//  Wordle
//
//  Created by Oleshkevich Artem on 27.04.22.
//

import Foundation
import UIKit

extension Optional where Wrapped == LetterEvaluation {
    var backgroundColor: UIColor {
        self?.backgroundColor ?? .clear
    }
}
