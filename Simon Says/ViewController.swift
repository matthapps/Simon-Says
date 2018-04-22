//
//  ViewController.swift
//  Simon Says
//
//  Created by Admin on 4/21/18.
//  Copyright © 2018 Matthew Heinrichs. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var colorButtons: [CircularButton]!
    @IBOutlet weak var actionButton: UIButton!
    @IBOutlet var playerLabels: [UILabel]!
    @IBOutlet var scoreLabels: [UILabel]!
    
    var currentPlayer = 0
    var scores = [0,0]
    
    var sequenceIndex = 0
    var colorSequence = [Int]()
    var colorsToTap = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colorButtons = colorButtons.sorted() {
            $0.tag < $1.tag
        }
        playerLabels = playerLabels.sorted() {
            $0.tag < $1.tag
        }
        scoreLabels = scoreLabels.sorted() {
            $0.tag < $1.tag
        }
        
        creatNewGame()
    }
    
    func creatNewGame() {
        colorSequence.removeAll()
        
        actionButton.setTitle("Start Game", for: .normal)
        actionButton.isEnabled = true
        for button in colorButtons {
            button.alpha = 0.5
            button.isEnabled = false
        }
    }
    
    func addNewColor() {
        colorSequence.append(Int(arc4random_uniform(4)))
    }
    
    func playSenquence() {
        if sequenceIndex < colorSequence.count {
            flash(button: colorButtons[colorSequence[sequenceIndex]])
            sequenceIndex += 1
        } else {
            colorsToTap = colorSequence
            view.isUserInteractionEnabled = true
            actionButton.setTitle("Tap the Circles", for: .normal)
            for button in colorButtons {
                button.isEnabled = true
            }
        }
    }
    
    func flash(button: CircularButton) {
        UIView.animate(withDuration: 0.5, animations: {
            button.alpha = 1.0
            button.alpha = 0.5
        }) { (bool) in
            self.playSenquence()
        }
    }
    
    @IBAction func colorButtonHandler(_ sender: CircularButton) {
        
        print("Button \(sender.tag) tapped")
    }
    
    @IBAction func actionButtonHandler(_ sender: UIButton) {
        
        sequenceIndex = 0
        actionButton.setTitle("Memorize", for: .normal)
        actionButton.isEnabled = false
        view.isUserInteractionEnabled = false
        addNewColor()
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)){
            self.playSenquence()
        }
        
    }
    

}

