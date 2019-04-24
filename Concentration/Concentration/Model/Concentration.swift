//
//  Concentration.swift
//  Concentration
//
//  Created by 洋蔥胖 on 2019/4/19.
//  Copyright © 2019 ChrisYoung. All rights reserved.
//

import Foundation

class Concentration {
    
    private(set) var cards = [Card]()
    
    private var indexOfOneAndOnlyFaceUpCard: Int?{
        get {
            var foundIndex : Int?
            for index in cards.indices {
                if cards[index].isFaceUp {
                    if foundIndex == nil {
                        foundIndex = index //first card
                    } else {
                        return nil // turn second card so return nil
                    }
                }
            }
            return foundIndex
        }
        set{
            for index in cards.indices {
                cards[index].isFaceUp = (index == newValue)
            }
        }
    }
    
    /*
     
     var indexOfOneAndOnlyFaceUpCard: Int? {
     get {
     // look at all the cards and see if you find only one that's face up.
     // if so, return it , else return nil.
     }
     set {
     // turn all the cards face down except the card at index newValue.
     }
     
     */
    
    /*
     情境：
     (1)沒有卡片面朝上，選了一張卡，那就翻過來。
     (2)兩張卡片面朝上但不同emoji，當我再選一張卡時，就預要讓前兩張卡面朝下，開始新一輪配對。
     (3)有一張卡面朝上，然後選了另一張卡，現在要試著配對，看看是否匹配的。
     
     */
    func chooseCard(at index: Int) {
        // assertion，斷言，通過聲明一個斷言來確保某個必要的條件是滿足的，以便繼續執行接下來的代碼。 index = -1 minus one no in the cards
        assert(cards.indices.contains(index), "Concentration.chooseCard(at:\(index)):chosen index no in the cards")
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                //check if cards match
                if cards[matchIndex].identifier == cards[index].identifier {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                }
                cards[index].isFaceUp = true
            } else {
                // (2)either no cards or cards are face up
                indexOfOneAndOnlyFaceUpCard = index
            }
        }
    }
    
    //生成兩張相同卡片
    init(numberOfPairsOfCards: Int) {
        
        assert(numberOfPairsOfCards > 0 , "Concentration.init(\(numberOfPairsOfCards)): you must have at least one pair of cards ")
        
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        
        //TODO: shuffle the cards
    }
}
