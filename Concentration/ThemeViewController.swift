//
//  ThemeViewController.swift
//  Concentration
//
//  Created by Mina Shoaib Rahman on 5/5/24.
//

import UIKit

class ThemeViewController: UIViewController {
    
    private var concentrationViewController: ConcentrationViewController? {
        return splitViewController?.viewControllers.last as? ConcentrationViewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func ChangeTheme(_ sender: UIButton) {
        if let game = concentrationViewController, let buttonType = sender.currentTitle {
            setThemeFromButtonType(buttonType, toGame: game)
        } else {
            performSegue(withIdentifier: "Show Game", sender: sender)
        }
    }
    
    func setThemeFromButtonType(_ buttonType: String, toGame game: ConcentrationViewController) {
        switch buttonType {
        case "Food":
            game.resetTheme(ConcentrationViewController.GameData.Theme.food.rawValue)
        case "Fruit":
            game.resetTheme(ConcentrationViewController.GameData.Theme.fruit.rawValue)
        case "Sport":
            game.resetTheme(ConcentrationViewController.GameData.Theme.sport.rawValue)
        default:
            game.resetTheme(ConcentrationViewController.GameData.emojiBank.count.random)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let segueId = segue.identifier {
            switch segueId {
            case "Show Game":
                if let button = sender as? UIButton, let game = segue.destination as? ConcentrationViewController, let buttonType = button.currentTitle {
                    setThemeFromButtonType(buttonType, toGame: game)
                }
            default:
                break
            }
        }
    }
}
