//
//  Concentration.swift
//  Concentration
//
//  Created by Mina Shoaib Rahman on 3/3/24.
//

import Foundation

class Concentration {
    var cards = [Card]()
    
    func selectCard(at index: Int) {
        cards[index].faceUp = !cards[index].faceUp
    }
    
    init(cardPair: Int) {
        for _ in 0 ..< cardPair {
            let card = Card(id: Card.getUniqueId())
            cards += [card, card]
        }
    }
    
    func shuffleCards() {
        cards.shuffle()
    }
}
