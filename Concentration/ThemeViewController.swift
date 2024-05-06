//
//  ThemeViewController.swift
//  Concentration
//
//  Created by Mina Shoaib Rahman on 5/5/24.
//

import UIKit

class ThemeViewController: UIViewController {
    private var concentrationViewController: ConcentrationViewController? {
        return (splitViewController?.viewControllers.last as? UINavigationController)?.viewControllers.last as? ConcentrationViewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func changeTheme(_ sender: UIButton) {
//        print(concentrationViewController ?? "empty view")
        if let game = concentrationViewController, let theme = sender.currentTitle {
            setGameTheme(theme, toGame: game)
        } else {
            performSegue(withIdentifier: "Show Game", sender: sender)
        }
    }
    
    func setGameTheme(_ theme: String, toGame game: ConcentrationViewController) {
        switch theme {
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
        if segue.identifier == "Show Game", let game = segue.destination as? ConcentrationViewController, let theme = (sender as? UIButton)?.currentTitle {
            setGameTheme(theme, toGame: game)
        }
    }
}
