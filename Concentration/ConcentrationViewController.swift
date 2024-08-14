//
//  ViewController.swift
//  Concentration
//
//  Created by Mina Shoaib Rahman on 7/1/24.
//

import UIKit

class ConcentrationViewController: UIViewController {
    override var description: String {
        return "Current theme: \(theme?.rawValue as Int?)"
    }
    
    struct GameData {
        enum Theme: Int {
            case Food = 0
            case Fruit
            case Sport
            case Face
            case Animal
            case Vehicle
            
            static func getTheme(_ theme: String?) -> ConcentrationViewController.GameData.Theme {
                switch theme {
                case "Food":    return ConcentrationViewController.GameData.Theme.Food
                case "Fruit":   return ConcentrationViewController.GameData.Theme.Fruit
                case "Sport":   return ConcentrationViewController.GameData.Theme.Sport
                case "Face":    return ConcentrationViewController.GameData.Theme.Face
                case "Animal":  return ConcentrationViewController.GameData.Theme.Animal
                case "Vehicle": return ConcentrationViewController.GameData.Theme.Vehicle
                default:        return ConcentrationViewController.GameData.Theme.Food
                }
            }
        }
        
        static var themeBank = [
            Theme.Food: ["🍰", "🍤", "🍩", "🍪", "🥛", "🍫", "🍗", "🍔", "🌮"],
            Theme.Fruit: ["🍎", "🍒", "🥭", "🍉", "🍋", "🍊", "🍐", "🍍", "🍌"],
            Theme.Sport: ["⚽️", "🏀", "🏓", "🏸", "🎾", "🏏", "🏑", "🛹", "🥊"],
            Theme.Face: ["🤩", "😍", "😇", "🤓", "😜", "🥵", "🤬", "🥶", "🤯"],
            Theme.Animal: ["🐶", "🐮", "🐔", "🐻", "🐋", "🐆", "🦚", "🦢", "🐪"],
            Theme.Vehicle: ["🚗", "🚑", "🚌", "🚅", "🚁", "🚤", "🚀", "🛩", "🚜"],
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
    
    func startNewGame(withTheme theme: GameData.Theme?) {
        self.theme = theme
        game = Concentration(cardPair: cardPairs)
        emojis = GameData.themeBank[theme!] ?? GameData.themeBank[GameData.Theme.Food]
        emoji = [Card: String]()
        updateCard()
    }
    
    @IBAction func newGameButton(_ sender: UIButton) {
        startNewGame(withTheme: GameData.themeBank.randomElement()?.key)
    }
    
    @IBOutlet private var cardButtons: [UIButton]!
    
    @IBOutlet private weak var countLabel: UILabel! {
        didSet {
            generateAttributedLabel()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // for small screen splitViewController?.viewControllers.first or last are the same, because only one VC is visible
        // for big screen splitViewController has two children as both master and detail VC are shown
        // here we're getting first child of splitViewController as we're trying to get master page
        if let themeVC = (splitViewController?.viewControllers.first as? UINavigationController)?.viewControllers.first as? ThemeViewController {
            // saving currently running game, so that theme can be changed while playing
            themeVC.lastGame = self
        }        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        if splitViewController?.preferredDisplayMode != .oneOverSecondary {
            splitViewController?.preferredDisplayMode = .oneOverSecondary
        }
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
        if cardButtons != nil {
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
    }
    
    var gameEnded: Bool {
        for card in game.cards {
            if card.matched == false {
                return false
            }
        }
        return true
    }
    
    func resetTheme(_ theme: GameData.Theme) {
        if gameEnded {
            startNewGame(withTheme: theme)
        } else {
            self.theme = theme
            emojis = GameData.themeBank[theme]
            emoji = [Card: String]()
            updateCard()
        }
    }
    
    var theme = GameData.themeBank.randomElement()?.key
    private var emoji = [Card: String]()
    lazy private var emojis = GameData.themeBank[theme!] ?? GameData.themeBank[GameData.Theme.Food]

    private func emoji(for card: Card) -> String {
        if emoji[card] == nil, (emojis?.count)! > 0 {
            emoji[card] = emojis?.remove(at: (emojis?.count.random)!)
        }
        return emoji[card] ?? "?"
    }
}

extension Int {
    var random: Int {
        if (abs(self) > 0) {
            return Int.random(in: 0 ..< abs(self))
        } else {
            return self
        }
    }
}
