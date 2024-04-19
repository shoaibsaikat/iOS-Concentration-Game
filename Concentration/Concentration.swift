//
//  Concentration.swift
//  Concentration
//
//  Created by Mina Shoaib Rahman on 3/3/24.
//

import Foundation

class Concentration {
    private(set) var cards = [Card]()
    private var selectCount: Int?
    private var firstCardIndex: Int? {
        get {
            for index in cards.indices {
                if (cards[index].faceUp) {
                    return index
                }
            }
            return nil
        }
        set {
            if newValue != nil {
                cards[newValue!].faceUp = true
            }
            selectCount = 1
        }
    }
    
    func selectCard(at index: Int) {
        if (cards[index].faceUp) {
            return
        }

        if selectCount == nil {
            firstCardIndex = index
        } else if selectCount == 1 {
            selectCount! += 1
            if cards[firstCardIndex!].id == cards[index].id {
                cards[firstCardIndex!].matched = true
                cards[index].matched = true
            }
            cards[index].faceUp = true
        } else {
            for index in cards.indices {
                cards[index].faceUp = false
            }
            firstCardIndex = index
        }
    }
    
    init(cardPair: Int) {
        for _ in 0 ..< cardPair {
            let card = Card(id: Card.getUniqueId())
            cards += [card, card]
        }
        shuffleCards()
    }
    
    private func shuffleCards() {
        cards.shuffle()
    }
}
