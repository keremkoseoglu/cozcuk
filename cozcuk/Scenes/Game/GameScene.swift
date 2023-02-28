//
//  GameScene.swift
//  cozcuk
//
//  Created by Dr. Kerem Koseoglu on 22.06.2022.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, CozcukScene {
    public  var puzzleManager   : GameScenePuzzleManager?
    public  var panel           : GamePanel?
    public  var currentView     : SKView?
    private var scenery         : GameScenery?
    private var observer        : GameSceneObserver?
    
    public static func moveToView(_ view: SKView) {
        ComboManager.getInstance().reset()
        let scene = GameScene(fileNamed: "GameScene")
        scene!.currentView = view
        scene!.cozcukShowInView(view)
    }
    
    override func didMove(to view: SKView) {
        SynonymHistory.getInstance().active = true
        self.observer   = GameSceneObserver(gameScene: self)
        self.scenery    = GameScenery(scene: self)
        self.panel      = GamePanel(scene       : self,
                                    observers   : self.observer!.gamePanelObservers,
                                    zPosition   : 2)
        
        self.puzzleManager = GameScenePuzzleManager(scene: self, zPosition: 2)
        self.observer?.loadNewPuzzle()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.panel?.touchesBegan(touches)
    }
}
