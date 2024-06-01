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
        // in master detail page by default detail page is shown for small screen. to override this behavior we're showing master page by default for small screen
        // but for big screen, side by side view is shown and this will have no effect
        return true
    }

    @IBOutlet var gameOptions: [UIButton]!
    @IBAction func changeTheme(_ sender: UIButton) {
        if let theme = sender.currentTitle {
            if lastGame != nil {
                lastGame?.resetTheme(ConcentrationViewController.GameData.Theme.getTheme(theme))
                // from pushViewController definition, if a VC is already in the stack than pushing it again makes not difference. so below code is not necessary for big screen,
                // as it will show view side by side, so no VC will be popped, but for small screen pressing back will pop VC. so we're pushing back previous VC again. [VC -> view controller]
                // for big screen side by side view, splitViewController has two children.
                // splitViewController?.viewControllers.first is the master page and splitViewController?.viewControllers.last is the navigation VC
                // for small screen splitViewController has one children at a time as only one VC is shown at a time
                // splitViewController will have two UINavigationController, first is for master and last is for detail VC
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

// NOTE: big screen means iPad or some iPhone plus models
