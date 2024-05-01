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
            return cards.indices.filter { cards[$0].faceUp }.first
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
        cards[index].touchCount += 1
        if cards[index].faceUp {
            return
        }

        switch selectCount {
        case nil:
            selectCount = index
            cards[index].faceUp = true
            firstCardIndex = index
            break
        case 1:
            selectCount! += 1
            if cards[firstCardIndex!] == cards[index] {
                cards[firstCardIndex!].matched = true
                cards[index].matched = true
            }
            cards[index].faceUp = true
            break
        default:
            for index in cards.indices {
                cards[index].faceUp = false
            }
            firstCardIndex = index
        }
    }
    
    func getScore() -> Int {
        var score = 0
        for card in cards {
            if card.matched {
                if card.touchCount > 2 {
//                  ignore first try and matched case then for each unmatched cases add -1
                    for _ in 3...card.touchCount {
                        score -= 1
                    }
                }
//              for matched case
                score += 1
            } else {
                if card.touchCount > 1 {
//                  ignore first try then for each unmatched cases add -1
                    for _ in 1..<card.touchCount {
                        score -= 1
                    }
                }
            }
        }
        return score
    }
    
    init(cardPair: Int) {
        assert(cardPair > 0, "Card pair needs to be greater than zero, but entered \(cardPair)")
        
        for var card in cards {
            card.faceUp = false
            card.matched = false
        }
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
