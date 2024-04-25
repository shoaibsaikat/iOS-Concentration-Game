//
//  ViewController.swift
//  Concentration
//
//  Created by Mina Shoaib Rahman on 7/1/24.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var game = Concentration(cardPair: cardPairs)
    
    private var cardPairs: Int {
        return (cardButtons.count + 1) / 2
    }
    
    private var countTouch = 0 {
        didSet {
            generateAttributedLabel()
        }
    }
    
    func generateAttributedLabel() {
        let attributes: [NSAttributedString.Key: Any] = [
            .strokeWidth: 5,
            .strokeColor: UIColor.orange
        ]
        countLabel.attributedText = NSAttributedString(string: "Flip: \(countTouch)", attributes: attributes)

    }
    
    @IBAction func newGameButton(_ sender: UIButton) {
        game = Concentration(cardPair: cardPairs)
        emojis = [ "🥁", "🎳", "🥎", "🍇", "🦋", "🌘", "🚚" ]
        emoji = [Card: String]()
        updateCard()
        countTouch = 0
    }
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    @IBOutlet private weak var countLabel: UILabel! {
        didSet {
            generateAttributedLabel()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction private func touchCard(_ sender: UIButton) {
        if let index = cardButtons.lastIndex(of: sender) {
            game.selectCard(at: index)
            updateCard();
        } else {
            print("card index is not set")
        }
    }
    
    private func updateCard() {
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
            if card.matched {
                button.backgroundColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0)
                button.setTitle("", for: UIControl.State.normal)
            }
        }
    }
    
    private var emojis = [ "🥁", "🎳", "🥎", "🍇", "🦋", "🌘", "🚚" ]
    
    private var emoji = [Card: String]()
    
    private func emoji(for card: Card) -> String {
        if emoji[card] == nil, emojis.count > 0 {
            emoji[card] = emojis.remove(at: emojis.count.arc4random)
        }
        return emoji[card] ?? "?"
    }
}

extension Int {
    var arc4random: Int {
        if (abs(self) > 0) {
            return Int(arc4random_uniform(UInt32(abs(self))))
        } else {
            return self
        }
    }
}
