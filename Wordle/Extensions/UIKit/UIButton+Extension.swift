//
//  File.swift
//  Wordle
//
//  Created by Oleshkevich Artem on 8.05.22.
//

import Foundation
import UIKit

extension UIButton {
    func setImageWithColor(image: UIImage?, color: UIColor) {
        let newImage = image?.withRenderingMode(.alwaysTemplate)
        self.tintColor = color
        self.setImage(newImage, for: .normal)
    }
}
