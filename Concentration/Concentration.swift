//
//  Concentration.swift
//  Concentration
//
//  Created by Mina Shoaib Rahman on 3/3/24.
//

import Foundation

class Concentration {
    var cards = [Card]()
    var selectCount: Int?
    var firstCardIndex: Int?
    var secondCardIndex: Int?
    
    func selectCard(at index: Int) {
        if index == firstCardIndex {
            return
        }
        
        if selectCount == nil {
            selectFirstCard(at: index)
        } else if selectCount == 1 {
            selectCount! += 1
            cards[index].faceUp = true
            secondCardIndex = index
            if cards[firstCardIndex!].id == cards[index].id {
                cards[firstCardIndex!].matched = true
                cards[index].matched = true
            }
        } else {
            cards[firstCardIndex!].faceUp = false
            cards[secondCardIndex!].faceUp = false
            secondCardIndex = nil
            selectFirstCard(at: index)
        }
    }
    
    func selectFirstCard(at index: Int) {
        firstCardIndex = index
        cards[index].faceUp = true
        selectCount = 1
    }
    
    init(cardPair: Int) {
        for _ in 0 ..< cardPair {
            let card = Card(id: Card.getUniqueId())
            cards += [card, card]
        }
        shuffleCards()
    }
    
    func shuffleCards() {
        cards.shuffle()
    }
}
