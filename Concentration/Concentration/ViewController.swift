//
//  ViewController.swift
//  Concentration
//
//  Created by 洋蔥胖 on 2019/4/17.
//  Copyright © 2019 ChrisYoung. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var game = Concentration(numberOfPairsOfCards: numberOfPairsOfCards)
    
    var numberOfPairsOfCards: Int {
        return (cardButtons.count + 1) / 2
    }
    
    private(set) var flipCount = 0 {
        didSet{
            updateFlipCountLabel()
        }
    }
    
    private func updateFlipCountLabel() {
        let attributes: [NSAttributedString.Key:Any] = [
            .strokeWidth : 5.0,
            .strokeColor : #colorLiteral(red: 1, green: 0.5781051517, blue: 0, alpha: 1)
            
        ]
        let attributedString = NSAttributedString(string: "Flips: \(flipCount)", attributes: attributes)
        flipCountLabel.attributedText = attributedString
    }
    
    @IBOutlet private weak var flipCountLabel: UILabel!
    
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    
    
    @IBAction private func touchCard(_ sender: UIButton) {
        
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
    
    private func updateViewFromModel() {
        
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
    
    //    private var emojiChoices = ["👻", "🎃", "🐶", "🐯", "🐳", "🍔", "🍱", "🍧", "🔥"]
    private var emojiChoices = "👻🎃🐶🐯🐳🍔🍱🍧🔥"
    
    // Type 'Card' does not conform to protocol 'Hashable'
    private var emoji = [Card : String]()
    
    private func emoji(for card: Card) -> String {
        
        if emoji[card] == nil, emojiChoices.count > 0 {
            
            //Cs193p P5 string 55:00
            // randomStringIndex =從emojiChoices這個字串”👻🎃🐶🐯🐳🍔🍱🍧🔥"第一個 startIndex，再隨機亂數取其中的字符character
            let randomStringIndex = emojiChoices.index(emojiChoices.startIndex, offsetBy: emojiChoices.count.arc4random)
            
            // 隨機到哪個 就remove掉emojiChoices的那個 再賦值給 var emoji = [Int : String]()
            emoji[card] = String(emojiChoices.remove(at: randomStringIndex))
            
        }
        
        return emoji[card] ?? "?"
    }
    
    
}

extension Int {
    var arc4random: Int {
        if self > 0 {
            return Int(arc4random_uniform(UInt32(self)))
        } else if self < 0 {
            return -Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return 0
        }
        
    }
}
