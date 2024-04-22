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
        assert(cards.indices.contains(index), "Card index out of bound, entered \(index)")
        if (cards[index].faceUp) {
            return
        }

        if selectCount == nil {
            firstCardIndex = index
        } else if selectCount == 1 {
            selectCount! += 1
            if cards[firstCardIndex!] == cards[index] {
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
        assert(cardPair > 0, "Card pair needs to be greater than zero, but entered \(cardPair)")
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
