//
//  Card.swift
//  Concentration
//
//  Created by Mina Shoaib Rahman on 3/3/24.
//

import Foundation

struct Card {
    var faceUp = false
    var matched = false
    var id: Int
    
    static var uniqueId = 0
    
    static func getUniqueId() -> Int {
        uniqueId += 1
        return uniqueId
    }
    
    init(id: Int) {
        self.id = id
    }
}
