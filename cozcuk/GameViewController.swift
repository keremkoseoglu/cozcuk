//
//  GameViewController.swift
//  cozcuk
//
//  Created by Dr. Kerem Koseoglu on 22.06.2022.
//

import UIKit
import SpriteKit
import GameplayKit

enum GameRunMode {
    case TEST
    case IN_APP_PURCHASE_TEST
    case REQUEST_REVIEW_TEST
    case SCREENSHOT
    case LIVE
}

struct GameRunModeContainer {
    var showsFPS                : Bool
    var showsNodeCount          : Bool
    var tutorialTitle           : String
    var erasePurchaseFlags      : Bool
    var puzzlesBeforeReview     : Int
    var eraseReviewRequested    : Bool
}

class GameRunModeManager {
    public  static  let DEFAULT_TUTORIAL_TITLE  : String = "Yardım"
    private static  var SINGLETON               : GameRunModeManager?
    private         var _gameRunMode            : GameRunMode
    
    public static func getInstance() -> GameRunModeManager {
        if GameRunModeManager.SINGLETON == nil {
            GameRunModeManager.SINGLETON = GameRunModeManager()
        }
        
        return GameRunModeManager.SINGLETON!
    }
    
    public var gameRunMode: GameRunMode {
        get { return self._gameRunMode }
        set(newMode) {self._gameRunMode = newMode}
    }
    
    public var container: GameRunModeContainer {
        get {
            switch (self._gameRunMode) {
            case .TEST:
                return GameRunModeContainer(showsFPS            : true,
                                            showsNodeCount      : true,
                                            tutorialTitle       : "Yardım",
                                            erasePurchaseFlags  : false,
                                            puzzlesBeforeReview : 10,
                                            eraseReviewRequested: false)
            case .IN_APP_PURCHASE_TEST:
                return GameRunModeContainer(showsFPS            : true,
                                            showsNodeCount      : true,
                                            tutorialTitle       : "Yardım",
                                            erasePurchaseFlags  : true,
                                            puzzlesBeforeReview : 10,
                                            eraseReviewRequested: false)
            case .REQUEST_REVIEW_TEST:
                return GameRunModeContainer(showsFPS            : true,
                                            showsNodeCount      : true,
                                            tutorialTitle       : "Yardım",
                                            erasePurchaseFlags  : false,
                                            puzzlesBeforeReview : 3,
                                            eraseReviewRequested: true)
            case .LIVE:
                return GameRunModeContainer(showsFPS            : false,
                                            showsNodeCount      : false,
                                            tutorialTitle       : "Yardım",
                                            erasePurchaseFlags  : false,
                                            puzzlesBeforeReview : 50,
                                            eraseReviewRequested: false)
            case .SCREENSHOT:
                return GameRunModeContainer(showsFPS            : false,
                                            showsNodeCount      : false,
                                            tutorialTitle       : "Çözcük",
                                            erasePurchaseFlags  : false,
                                            puzzlesBeforeReview : 50,
                                            eraseReviewRequested: false)
            }
        }
    }
    
    private init() {
        self._gameRunMode = .TEST
    }
}


class GameViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            let gameRunModeManager = GameRunModeManager.getInstance()
            gameRunModeManager.gameRunMode = .LIVE
            let container = gameRunModeManager.container
            
            if container.erasePurchaseFlags {InAppPurchaseManager.getInstance().purchasedFlagInDatabase = false}
            
            //TestScene.moveToView(view)
            GameScene.moveToView(view)
            //WelcomeScene.moveToView(view)
            //TutorialScene.moveToView(view)
            //StatsScene.moveToView(view)

            view.ignoresSiblingOrder    = true
            view.showsFPS               = container.showsFPS
            view.showsNodeCount         = container.showsNodeCount
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

}
