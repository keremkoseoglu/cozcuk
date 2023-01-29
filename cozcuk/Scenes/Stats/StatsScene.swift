//
//  StatsScene.swift
//  cozcuk
//
//  Created by Dr. Kerem Koseoglu on 16.08.2022.
//

import SpriteKit

class StatsScene: SKScene {
    public  var currentView     : SKView?
    public  var panel           : StatsPanel?
    
    private var scenery         : GameScenery?
    private var observer        : StatsSceneObserver?
    
    
    public static func moveToView(_ view: SKView) {
        let scene = StatsScene(fileNamed: "StatsScene")
        scene!.currentView = view
        scene!.cozcukShowInView(view)
    }
    
    override func didMove(to view: SKView) {
        self.scenery    = GameScenery(scene: self)
        self.observer   = StatsSceneObserver(statsScene: self)
        self.panel      = StatsPanel(scene      : self,
                                     zPosition  : 9,
                                     observer   : self.observer)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.panel?.touchesBegan(touches)
    }
}
