//
//  ViewController.swift
//  Concentration
//
//  Created by 洋蔥胖 on 2019/4/17.
//  Copyright © 2019 ChrisYoung. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    lazy var game = Concentration(numberOfPairsOfCards: (cardButtons.count + 1) / 2)
    
    var flipCount = 0 {
        didSet{
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    @IBOutlet weak var flipCountLabel: UILabel!
    
    
    @IBOutlet var cardButtons: [UIButton]!
    
    
    
    @IBAction func touchCard(_ sender: UIButton) {
        
        flipCount += 1
        
        
        //原 cardButtons.index(of: sender)!
        if let cardNumber = cardButtons.firstIndex(of: sender){
    
//            flipCard(withEmoji: emojiChoices[cardNumber], on: sender)
            game.chooseCard(at: cardNumber)
            // so now, we have to update our view from the model, our view is now a little bit out of sync with the model, because when we choose this card, that could have caused the game to change, so we need a method like updateViewFromModel or something like that, some kind of func down here.
            updateViewFromModel()
        }else {
            print("chosen card card was not in cardButtons")
        }
        
       
    }
  
    func updateViewFromModel() {
        
        // 0..<cardButtons.count = cardButtons.indices  數組所有索引組成的可數區間
        for index in cardButtons.indices {
            let button = cardButtons[index]
            let card = game.cards[index]
            
            if card.isFaceUp {
                button.setTitle(emoji(for: card), for: .normal)
                button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            }else {
                button.setTitle("", for: .normal)
                button.backgroundColor = card.isMatched ? #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 0) : #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
            }
        }
        
    }
    
    var emojiChoices = ["👻", "🎃", "🐶", "🐯", "🐳", "🍔", "🍱", "🍧", "🔥"]
    
    var emoji = [Int : String]()
    
    func emoji(for card: Card) -> String {
        
        if emoji[card.identifier] == nil, emojiChoices.count > 0 {
 
                let randomIndex = Int(arc4random_uniform(UInt32(emojiChoices.count)))
                // 隨機到哪個 就remove掉emojiChoices的那個 再賦值給 var emoji = [Int : String]()
                emoji[card.identifier] = emojiChoices.remove(at: randomIndex)
            
        }
        
        return emoji[card.identifier] ?? "?"
    }

 
}

