//
//  GameScenery.swift
//  cozcuk
//
//  Created by Dr. Kerem Koseoglu on 14.08.2022.
//

import SpriteKit

class GameScenery {
    private var background  : GameSceneBackground
    private var scene       : SKScene
    
    init(scene: SKScene, zPosition: CGFloat = 0) {
        self.scene      = scene
        self.background = GameSceneBackground(scene: self.scene, zPosition: zPosition)
    }
}
