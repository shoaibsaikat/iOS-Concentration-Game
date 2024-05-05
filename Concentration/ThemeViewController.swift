//
//  ThemeViewController.swift
//  Concentration
//
//  Created by Mina Shoaib Rahman on 5/5/24.
//

import UIKit

class ThemeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let segueId = segue.identifier {
            switch segueId {
            case "Show Game":
                if let button = sender as? UIButton, let game = segue.destination as? ConcentrationViewController {
                    switch button.currentTitle {
                    case "Food":
                        game.theme = ConcentrationViewController.GameData.Theme.food.rawValue
                    case "Fruit":
                        game.theme = ConcentrationViewController.GameData.Theme.fruit.rawValue
                    case "Sport":
                        game.theme = ConcentrationViewController.GameData.Theme.sport.rawValue
                    default:
                        game.theme = ConcentrationViewController.GameData.emojiBank.count.random
                    }
                }
            default:
                break
            }
        }
    }


}
