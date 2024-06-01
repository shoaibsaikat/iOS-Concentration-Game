//
//  ThemeViewController.swift
//  Concentration
//
//  Created by Mina Shoaib Rahman on 5/5/24.
//

import UIKit

class ThemeViewController: UIViewController, UISplitViewControllerDelegate {
    // making this strong will retain previous game
    var lastGame: ConcentrationViewController?
    
    // this do not work if SplitViewController is set double column (by default), fixed by setting it unspecified from storyboard
    override func awakeFromNib() {
        super.awakeFromNib()
        splitViewController?.delegate = self
    }
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        // in master detail page by default default page is shown
        // for small screen iPhone we're showing master page
        // but for big screen i.e. iPads side by side view is shown and this will have no effect
        return true
    }

    @IBOutlet var gameOptions: [UIButton]!
    @IBAction func changeTheme(_ sender: UIButton) {
        if let theme = sender.currentTitle {
            if lastGame != nil {
                lastGame?.resetTheme(ConcentrationViewController.GameData.Theme.getTheme(theme))
                (splitViewController?.viewControllers.last as? UINavigationController)?.pushViewController(lastGame!, animated: true)
            } else {
                performSegue(withIdentifier: "Show Game", sender: sender)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let game = segue.destination as? ConcentrationViewController
        if segue.identifier == "Show Game", let theme = (sender as? UIButton)?.currentTitle, game != nil {
            game?.theme = ConcentrationViewController.GameData.Theme.getTheme(theme)
        }
    }
}
