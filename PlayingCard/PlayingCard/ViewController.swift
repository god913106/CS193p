//
//  ViewController.swift
//  PlayingCard
//
//  Created by 洋蔥胖 on 2019/5/1.
//  Copyright © 2019 ChrisYoung. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
     var deck = PlayingCardDeck()
    
    @IBOutlet weak var playingCardView: PlayingCardView! {
        didSet {
            setupGestureRecognizers()
        }
    }
    
    ///
    /// Setup gesture recognizers on the playing card:
    ///   - Swipe: Go to next card in the deck
    ///   - Pinch: Zoom the card's face
    ///
    /// Note: Tap gesture recognizer (to flip the card) was added
    /// using interface builder.
    ///
    private func setupGestureRecognizers() {
        // Swipe gesture recognizer to go to next card
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(nextCard))
        swipe.direction = [.left, .right]
        playingCardView.addGestureRecognizer(swipe)
        
        // Pinch gesture recognizer to zoom the card's face
        let pinch = UIPinchGestureRecognizer(
            target: playingCardView,
            action: #selector(playingCardView.adjustFaceCardScale(gestureRecognizer:))
        )
        playingCardView.addGestureRecognizer(pinch)
    }
    


    
    @IBAction func flipCard(_ sender: UITapGestureRecognizer) {
        switch sender.state {
        case .ended:
            playingCardView.isFaceUp = !playingCardView.isFaceUp
        default:
            break
        }
    }
    
    
    @objc func nextCard() {
        if let card = deck.draw() {
            playingCardView.rank = card.rank.order
            playingCardView.suit = card.suit.rawValue
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
    }
    
    
    
}

