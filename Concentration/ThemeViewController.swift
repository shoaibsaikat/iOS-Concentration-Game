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
        if let game = concentrationViewController, let theme = sender.currentTitle {
//            ipad
            game.resetTheme(getTheme(theme))
        } else {
//            iphone
            performSegue(withIdentifier: "Show Game", sender: sender)
        }
    }
    
    func getTheme(_ theme: String) -> Int {
        switch theme {
        case "Food":    return ConcentrationViewController.GameData.Theme.food.rawValue
        case "Fruit":   return ConcentrationViewController.GameData.Theme.fruit.rawValue
        case "Sport":   return ConcentrationViewController.GameData.Theme.sport.rawValue
        case "Face":    return ConcentrationViewController.GameData.Theme.face.rawValue
        case "Animal":  return ConcentrationViewController.GameData.Theme.animal.rawValue
        case "Vehicle": return ConcentrationViewController.GameData.Theme.vehicle.rawValue
        default:        return ConcentrationViewController.GameData.emojiBank.count.random
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Show Game", let game = segue.destination as? ConcentrationViewController, let theme = (sender as? UIButton)?.currentTitle {
            game.theme = getTheme(theme)
        }
    }
}
