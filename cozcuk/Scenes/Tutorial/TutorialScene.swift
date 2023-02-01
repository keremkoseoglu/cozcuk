//
//  TutorialScene.swift
//  cozcuk
//
//  Created by Dr. Kerem Koseoglu on 29.08.2022.
//

import SpriteKit

class TutorialScene: SKScene {
    public  var panel           : TutorialPanel?
    public  var currentView     : SKView?
    private var scenery         : GameScenery?
    private var observer        : TutorialSceneObserver?
    private var plaque          : WelcomePlaque?
    
    public static func moveToView(_ view: SKView) {
        let scene = TutorialScene(fileNamed: "TutorialScene")
        scene!.currentView = view
        scene!.cozcukShowInView(view)
    }
    
    override func didMove(to view:SKView) {
        SynonymHistory.getInstance().active = false
        self.plaque         = WelcomePlaque(scene: self, zPosition: 9, text: GameRunModeManager.getInstance().container.tutorialTitle)
        
        self.observer       = TutorialSceneObserver(tutorialScene: self)
        self.scenery        = GameScenery(scene: self)
        
        self.panel          = TutorialPanel(scene   : self,
                                            observer: self.observer)
    
        self.observer?.loadFirstStep()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.panel?.touchesBegan(touches)
    }
}
