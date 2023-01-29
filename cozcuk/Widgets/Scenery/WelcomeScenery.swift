//
//  WelcomeScenery.swift
//  cozcuk
//
//  Created by Dr. Kerem Koseoglu on 29.08.2022.
//

import SpriteKit

class WelcomeScenery {
    private var scene       : SKScene
    private var zPosition   : CGFloat
    private var background  : GameSceneBackground
    private var plaque      : WelcomePlaque
    
    public init(scene: SKScene, zPosition: CGFloat) {
        self.scene      = scene
        self.zPosition  = zPosition
        self.background = GameSceneBackground(scene: self.scene, zPosition: self.zPosition)
        self.plaque     = WelcomePlaque(scene: self.scene, zPosition: self.zPosition + 1)
    }
}
