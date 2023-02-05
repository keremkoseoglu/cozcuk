//
//  WelcomeScene.swift
//  cozcuk
//
//  Created by Dr. Kerem Koseoglu on 25.08.2022.
//

import SpriteKit

class WelcomeScene: SKScene, CozcukScene {
    public  var currentView : SKView?
    private var scenery     : WelcomeScenery?
    private var panel       : WelcomePanel?
    private var observer    : WelcomeSceneObserver?
    
    public static func moveToView(_ view: SKView) {
        let scene           = WelcomeScene(fileNamed: "WelcomeScene")
        scene!.currentView  = view
        scene!.cozcukShowInView(view)
    }
    
    override func didMove(to view: SKView) {
        self.observer   = WelcomeSceneObserver(welcomeScene: self)
        self.scenery    = WelcomeScenery(scene: self, zPosition: 1)
        self.panel      = WelcomePanel(scene: self, zPosition: 2, observer: self.observer!)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.panel?.touchesBegan(touches)
    }
    
}
