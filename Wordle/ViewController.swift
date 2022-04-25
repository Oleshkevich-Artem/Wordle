//
//  ViewController.swift
//  Wordle
//
//  Created by Artem Oleshkevich on 25.04.22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var letterBoxView: LetterBoxView!
    
    private let letterBox: LetterBox? = LetterBox(letter: "a", status: .notExist)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createLetterBoxView()
    }

    private func createLetterBoxView() {
        let letterBoxView = LetterBoxView()
        letterBoxView.updateLetterBox(letterBox: letterBox)
        
        view.addSubview(letterBoxView)
        
        letterBoxView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            letterBoxView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            letterBoxView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            letterBoxView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.3),
            letterBoxView.widthAnchor.constraint(equalTo: letterBoxView.heightAnchor)
        ])
    }

}

