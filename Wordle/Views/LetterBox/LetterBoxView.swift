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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setUpView()
    }
    
    // MARK: - Initial View Setup
    
    private func setUpView() {
        createXib()
        createBorder()
        
        updateView(letterBox: letterBox)
    }
    
    private func createXib() {
        Bundle.main.loadNibNamed("LetterBoxView", owner: self, options: nil)
        
        addSubview(contentView)
        
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
    private func createBorder() {
        contentView.layer.borderColor = UIColor.gray.cgColor
        contentView.layer.borderWidth = 2
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
        switch status {
        case .notExist:
            contentView.backgroundColor = .gray
            
        case .wrongPlace:
            contentView.backgroundColor = .yellow
            
        case .matched:
            contentView.backgroundColor = .green
            
        default:
            contentView.backgroundColor = .clear
        }
    }
}
