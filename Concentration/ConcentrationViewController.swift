//
//  ViewController.swift
//  Concentration
//
//  Created by Mina Shoaib Rahman on 7/1/24.
//

import UIKit

class ConcentrationViewController: UIViewController {
    
    struct GameData {
        enum Theme: Int {
            case face       = 0
            case animal     = 1
            case vehicle    = 2
            case food       = 3
            case fruit      = 4
            case sport      = 5
            case misc       = 6
        }
        static var emojiBank = [
            ["🤩", "😍", "😇", "🤓", "😜", "🥵", "🤬", "🥶", "🤯"],
            ["🐶", "🐮", "🐔", "🐻", "🐋", "🐆", "🦚", "🦢", "🐪"],
            ["🚗", "🚑", "🚌", "🚅", "🚁", "🚤", "🚀", "🛩", "🚜"],
            ["🍰", "🍤", "🍩", "🍪", "🥛", "🍫", "🍗", "🍔", "🌮"],
            ["🍎", "🍒", "🥭", "🍉", "🍋", "🍊", "🍐", "🍍", "🍌"],
            ["⚽️", "🏀", "🏓", "🏸", "🎾", "🏏", "🏑", "🛹", "🥊"],
            ["🥁", "🎳", "🥎", "🍇", "🦋", "🌘", "🚚", "📷", "⛈"],
        ]
    }
    
    private lazy var game = Concentration(cardPair: cardPairs)
    
    private var cardPairs: Int {
        return (cardButtons.count + 1) / 2
    }
    
    private var gameScore = 0 {
        didSet {
            generateAttributedLabel()
        }
    }
    
    func generateAttributedLabel() {
        let attributes: [NSAttributedString.Key: Any] = [
            .strokeWidth: 5,
            .strokeColor: UIColor.systemGreen
        ]
        countLabel.attributedText = NSAttributedString(string: "Score: \(gameScore)", attributes: attributes)

    }
    
    @IBAction func newGameButton(_ sender: UIButton) {
        game = Concentration(cardPair: cardPairs)
        theme = GameData.emojiBank.count.random
        emojis = GameData.emojiBank[theme!]
        emoji = [Card: String]()
        updateCard()
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
        for index in cardButtons.indices {
            let card = game.cards[index]
            let button = cardButtons[index]
            if card.faceUp {
                button.backgroundColor = UIColor.systemGray5
                button.setTitle(emoji(for: card), for: UIControl.State.normal)
            } else {
                button.backgroundColor = UIColor.systemBlue
                button.setTitle("", for: UIControl.State.normal)
            }
            if card.matched {
                button.backgroundColor = UIColor.clear
                button.setTitle("", for: UIControl.State.normal)
            }
        }
        gameScore = game.getScore()
    }
    
    lazy private var emojis = GameData.emojiBank[theme!]
    var theme: Int? = GameData.emojiBank.count.random
    private var emoji = [Card: String]()
    
    private func emoji(for card: Card) -> String {
        if emoji[card] == nil, emojis.count > 0 {
            emoji[card] = emojis.remove(at: emojis.count.random)
        }
        return emoji[card] ?? "?"
    }
}

extension Int {
    var random: Int {
        if (abs(self) > 0) {
            return Int.random(in: 0..<abs(self))
        } else {
            return self
        }
    }
}
