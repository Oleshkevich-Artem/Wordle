//
//  LetterBoxView.swift
//  Wordle
//
//  Created by Artem Oleshkevich on 25.04.22.
//

import UIKit

class LetterBoxView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var letterLabel: UILabel!
    
    private var letterBox: LetterBox?
    
    init(letterBox: LetterBox?) {
        self.letterBox = letterBox
        
        super.init(frame: .zero)
        
        setUpView()
    }
    
    override init(frame: CGRect) { // When created from code
        super.init(frame: frame)
        
        setUpView()
    }
    
    required init?(coder: NSCoder) { // When created from storyboard/xib
        super.init(coder: coder)
        
        setUpView()
    }
    
    // MARK: - Initial View Setup
    
    private func setUpView() {
        createXib()
        contentView.setBorder()
        
        updateView(letterBox: letterBox)
    }
    
    private func createXib() {
        Bundle.main.loadNibNamed("LetterBoxView", owner: self, options: nil)
        
        addSubview(contentView)
        
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    // MARK: - View Update
    
    func updateLetterBox(letterBox: LetterBox?) {
        self.letterBox = letterBox
        
        updateView(letterBox: letterBox)
    }
    
    private func updateView(letterBox: LetterBox?) {
        updateLabel(letter: letterBox?.letter)
        updateBackground(status: letterBox?.status)
    }
    
    private func updateLabel(letter: String?) {
        letterLabel.text = letter?.uppercased()
    }
    
    private func updateBackground(status: LetterEvaluation?) {
        contentView.backgroundColor = status?.backgroundColor ?? .clear
    }
}

extension LetterEvaluation {
    var backgroundColor: UIColor {
        switch self {
        case .notExist:
            return .gray
            
        case .wrongPlace:
            return .yellow
            
        case .matched:
            return .green
        }
    }
}

extension Optional where Wrapped == LetterEvaluation {
    var backgroundColor: UIColor {
        self?.backgroundColor ?? .clear
    }
}
