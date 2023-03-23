//
//  GameViewController.swift
//  cozcuk
//
//  Created by Dr. Kerem Koseoglu on 22.06.2022.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    private static let STARTED_WITH_HELP_KEY: String = "GVCStartedWithHelp"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            startGame(scene     : getStartupScene(),
                      runMode   : .LIVE,
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
    
    private func getStartupScene() -> CozcukScene.Type {
        var startupScene = WelcomeScene.self as CozcukScene.Type
        
        let db = Database.getInstance()
        if !db.getBool(GameViewController.STARTED_WITH_HELP_KEY) {
            startupScene = TutorialScene.self as CozcukScene.Type
            db.setBool(GameViewController.STARTED_WITH_HELP_KEY, true)
        }
        
        return startupScene
    }
}
