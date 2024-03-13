//
//  ViewController.swift
//  Concentration
//
//  Created by Mina Shoaib Rahman on 7/1/24.
//

import UIKit

class ViewController: UIViewController {
    
    lazy var game = Concentration(cardPair: (cardButtons.count + 1) / 2)
    
    var countTouch = 0 {
        didSet {
            countLabel.text = "Flip: \(countTouch)"
        }
    }
    
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBOutlet weak var countLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func touchCard(_ sender: UIButton) {
        if let index = cardButtons.lastIndex(of: sender) {
            game.selectCard(at: index)
            updateCard();
        } else {
            print("card index is not set")
        }
    }
    
    func updateCard() {
        countTouch += 1
        for index in cardButtons.indices {
            let card = game.cards[index]
            let button = cardButtons[index]
            if card.faceUp {
                button.backgroundColor = UIColor.white
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
            } else {
                button.backgroundColor = UIColor.orange
                button.setTitle("", for: UIControl.State.normal)

            }
        }
    }
    
    var emojis = [ "🥁", "🎳", "🥎", "🍇", "🦋", "🌘", "🚚" ]
    
    var emoji = [Int: String]()
    
    func emoji(for card: Card) -> String {
        if emoji[card.id] == nil, emojis.count > 0 {
            let randomIndex = Int(arc4random_uniform(UInt32(emojis.count)))
            emoji[card.id] = emojis.remove(at: randomIndex)
        }
        return emoji[card.id] ?? "?"
    }
}

