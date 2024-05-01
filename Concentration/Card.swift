//
//  Card.swift
//  Concentration
//
//  Created by Mina Shoaib Rahman on 3/3/24.
//

import Foundation

struct Card: Hashable {
    var faceUp = false
    var matched = false
    var touchCount = 0
    private var id: Int
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.id == rhs.id
    }
    
    private static var uniqueId = 0
    
    static func getUniqueId() -> Int {
        uniqueId += 1
        return uniqueId
    }
    
    init(id: Int) {
        self.id = id
    }
}
