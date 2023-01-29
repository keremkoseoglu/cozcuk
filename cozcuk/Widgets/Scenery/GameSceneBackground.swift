//
//  GameSceneBackground.swift
//  cozcuk
//
//  Created by Dr. Kerem Koseoglu on 14.08.2022.
//

import SpriteKit

class GameSceneBackground {
    private static let IMG_NAME : String    = "Grow"
    private var node            : SKSpriteNode
    private var scene           : SKScene
    
    init(scene: SKScene, zPosition: CGFloat = 0) {
        self.scene          = scene
        self.node           = SKSpriteNode(imageNamed: GameSceneBackground.IMG_NAME)
        self.node.position  = CGPoint(x: 0, y: 0)
        self.node.zPosition = zPosition
        self.node.alpha     = 0.5
        self.scene.addChild(self.node)
        self.scene.backgroundColor = UIColor.black
    }
}
