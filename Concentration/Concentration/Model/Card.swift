//
//  Card.swift
//  Concentration
//
//  Created by 洋蔥胖 on 2019/4/19.
//  Copyright © 2019 ChrisYoung. All rights reserved.
//

import Foundation

struct Card : Hashable {
    
    // 'Hashable.hashValue' is deprecated as a protocol requirement; conform type 'Card' to 'Hashable' by implementing 'hash(into:)' instead
    var hashValue: Int { return identifier }
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    var isFaceUp = false
    var isMatched = false
    private var identifier : Int
    
    private static var identifierFactory = 0
    
    private static func getUniqueIdentifier() -> Int {
        
        identifierFactory += 1
        
        return identifierFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}
