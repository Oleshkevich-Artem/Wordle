//
//  KeybordSymbol.swift
//  Wordle
//
//  Created by Oleshkevich Artem on 26.04.22.
//

import Foundation
import UIKit

//Enumeration containing keyboard button options: character, enter, delete.

enum KeyboardSymbol: Equatable {
    case enter
    case delete
    case character(String)
}
