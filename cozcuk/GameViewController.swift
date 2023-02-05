//
//  GameViewController.swift
//  cozcuk
//
//  Created by Dr. Kerem Koseoglu on 22.06.2022.
//

import UIKit
import SpriteKit
import GameplayKit

#warning("game view controller startup") /*
moveToView protocol olsun
    stats scene
game starter diye bir sınıf yap
game view controller oraya gitsin
*/

class GameViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            #warning("run mode live olacak")
            startGame(scene     : WelcomeScene.self,
                      runMode   : .TEST,
                      view      : view)
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return .portrait
        
        /*
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }*/
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        ColorSchemeManager.getInstance().userInterfaceStyleChanged()
    }

    private func startGame(scene: CozcukScene.Type, runMode: GameRunMode, view: SKView) {
        ColorSchemeManager.initialize(viewController: self)
        
        let gameRunModeManager = GameRunModeManager.getInstance()
        gameRunModeManager.gameRunMode = runMode
        let container = gameRunModeManager.container
        
        if container.erasePurchaseFlags {InAppPurchaseManager.getInstance().purchasedFlagInDatabase = false}
        
        scene.moveToView(view)

        view.ignoresSiblingOrder    = true
        view.showsFPS               = container.showsFPS
        view.showsNodeCount         = container.showsNodeCount
    }
}
