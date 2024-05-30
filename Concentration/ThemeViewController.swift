//
//  ThemeViewController.swift
//  Concentration
//
//  Created by Mina Shoaib Rahman on 5/5/24.
//

import UIKit

class ThemeViewController: UIViewController, UISplitViewControllerDelegate {
    // making this strong will retain previous game but makes game unresonsive, to fix it SplitViewController delegate must be set (for iphone)
    private var lastGame: ConcentrationViewController?
    private var gameNavigationController: UINavigationController? {
        return splitViewController?.viewControllers.last as? UINavigationController
    }
    private var gameViewController: ConcentrationViewController? {
        return gameNavigationController?.viewControllers.last as? ConcentrationViewController
    }
    
    // this do not work if SplitViewController is set double column (by default), fixed by setting it unspecified from storyboard
    override func awakeFromNib() {
        super.awakeFromNib()
        splitViewController?.delegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        if lastGame != nil {
            return false
        }
        return true
    }

    @IBAction func changeTheme(_ sender: UIButton) {
        if let theme = sender.currentTitle {
            // we already know the running game
            if let game = gameViewController {
                // for ipad
                game.resetTheme(getTheme(theme))
            } else if lastGame != nil {
                // for iphone
                lastGame?.resetTheme(getTheme(theme))
                gameNavigationController?.pushViewController(lastGame!, animated: true)
            } else {
                performSegue(withIdentifier: "Show Game", sender: sender)
            }
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
            lastGame = game
            game.theme = getTheme(theme)
        }
    }
}
