//
//  Concentration.swift
//  Concentration
//
//  Created by 洋蔥胖 on 2019/4/19.
//  Copyright © 2019 ChrisYoung. All rights reserved.
//

import Foundation

class Concentration {
    
    var cards = [Card]()
    
    var indexOfOneAndOnlyFaceUpCard: Int?
    
    /*
     情境：
     (1)沒有卡片面朝上，選了一張卡，那就翻過來。
     (2)兩張卡片面朝上但不同emoji，當我再選一張卡時，就預要讓前兩張卡面朝下，開始新一輪配對。
     (3)有一張卡面朝上，然後選了另一張卡，現在要試著配對，看看是否匹配的。

     */
    func chooseCard(at index: Int) {
        
        
//
//            if cards[index].isFaceUp {
//                cards[index].isFaceUp = false
//            }else {
//                cards[index].isFaceUp = true
//            }
        
            if !cards[index].isMatched {
                if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                    //check if cards match
                    if cards[matchIndex].identifier == cards[index].identifier {
                        cards[matchIndex].isMatched = true
                        cards[index].isMatched = true
                    }
                    cards[index].isFaceUp = true
                    indexOfOneAndOnlyFaceUpCard = nil
                } else {
                    // (2)either no cards or cards are face up
                    for flipDownIndex in cards.indices {
                        cards[flipDownIndex].isFaceUp = false
                    }
                    cards[index].isFaceUp = true
                    indexOfOneAndOnlyFaceUpCard = index
                }
            }
        
        
    }
    
    //生成兩張相同卡片
    init(numberOfPairsOfCards: Int) {
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        
        //TODO: shuffle the cards
    }
}
