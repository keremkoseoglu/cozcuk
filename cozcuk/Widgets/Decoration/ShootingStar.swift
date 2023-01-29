//
//  ShootingStar.swift
//  cozcuk
//
//  Created by Dr. Kerem Koseoglu on 1.09.2022.
//

import SpriteKit

class ShootingStar {
    private static  let IMG_NAME        : String        = "stars_big"
    private static  let IMG_SCALE       : CGFloat       = 0.5
    private static  let TURN_ANGLE      : CGFloat       = 90
    private static  let TURN_DURATION   : CGFloat       = 1
    private static  let FADE_DURATION   : CGFloat       = 0.2
    private static  let MOVE_DURATION   : CGFloat       = 0.5
    private         var scene           : SKScene
    private         var zPosition       : CGFloat
    private         var imgNode         : SKSpriteNode?
    
    public init(scene: SKScene, zPosition: CGFloat) {
        self.scene      = scene
        self.zPosition  = zPosition
    }
    
    public func shoot(from: CGPoint, to: CGPoint) {
        initImgNode(pos: from)
        startTurning()
        moveStar(to: to)
    }
    
    public func removeFromParent() {
        self.imgNode?.removeFromParent()
    }
    
    private func initImgNode(pos: CGPoint) {
        self.imgNode            = SKSpriteNode(imageNamed: ShootingStar.IMG_NAME)
        self.imgNode!.alpha     = 0
        self.imgNode!.position  = pos
        self.imgNode!.setScale(ShootingStar.IMG_SCALE * self.scene.cozcukScaleMax)
        self.scene.addChild(self.imgNode!)
    }
    
    private func startTurning() {
        let turnAction = SKAction.rotate(byAngle    : ShootingStar.TURN_ANGLE,
                                         duration   : TimeInterval(ShootingStar.TURN_DURATION))
        let forever    = SKAction.repeatForever(turnAction)
        self.imgNode!.run(forever)
    }
    
    private func moveStar(to: CGPoint) {
        let fadeIn = SKAction.fadeIn(withDuration: TimeInterval(ShootingStar.FADE_DURATION))
        self.imgNode!.run(fadeIn)
        
        let move    = SKAction.move(to: to, duration: TimeInterval(ShootingStar.MOVE_DURATION))
        let fadeOut = SKAction.fadeOut(withDuration: TimeInterval(ShootingStar.FADE_DURATION))
        let remove  = SKAction.removeFromParent()
        let seq     = SKAction.sequence([move, fadeOut, remove])
        self.imgNode!.run(seq)
    }
    
}
