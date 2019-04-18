//
//  ViewController.swift
//  Concentration
//
//  Created by 洋蔥胖 on 2019/4/17.
//  Copyright © 2019 ChrisYoung. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var flipCount = 0 {
        didSet{
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    
    @IBOutlet var cardButtons: [UIButton]!
    var emojiChoices = ["👻", "🎃", "👻", "🎃"]
    
    @IBAction func touchCard(_ sender: UIButton) {
        
        flipCount += 1
        
        
        //原 cardButtons.index(of: sender)!
        if let cardNumber = cardButtons.firstIndex(of: sender){
            
            flipCard(withEmoji: emojiChoices[cardNumber], on: sender)
        }else {
            print("chosen card card was not in cardButtons")
        }
        
       
    }
  
    
    func flipCard(withEmoji emoji: String, on button: UIButton) {
        if button.currentTitle == emoji {
            button.setTitle("", for: .normal)
            button.backgroundColor = #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
        }else {
            button.setTitle(emoji, for: .normal)
            button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

