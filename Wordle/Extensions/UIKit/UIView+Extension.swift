//
//  UIView+Extension.swift
//  Wordle
//
//  Created by Oleshkevich Artem on 26.04.22.
//

import Foundation
import UIKit

//Extension for setting the stroke UIView.

extension UIView {
    func setBorder(color: UIColor = .gray) {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = 2
    }
}
