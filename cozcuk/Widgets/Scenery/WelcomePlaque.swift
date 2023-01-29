//
//  WelcomePlaque.swift
//  cozcuk
//
//  Created by Dr. Kerem Koseoglu on 29.08.2022.
//

import SpriteKit

class WelcomePlaque {
    public  static  let ANIM_DURAT  : CGFloat   = 1
    
    private static  let BG_IMAGE    : String    = "Header.png"
    private static  let DEFAULT_TEXT: String    = "ÇÖZCÜK"
    private static  let TEXT_MARGIN : CGFloat   = 0.025
    private static  let FONT_SCALE  : CGFloat   = 0.8

    private         var scene       : SKScene
    private         var zPosition   : CGFloat
    private         var bgNode      : SKSpriteNode
    private         var textNode    : SKLabelNode
    private         var animTime    : TimeInterval
    private         var _bgTargetY  : CGFloat?
    private         var text        : String
    
    public init(scene: SKScene, zPosition: CGFloat, text: String = DEFAULT_TEXT) {
        self.text       = text
        self.scene      = scene
        self.zPosition  = zPosition
        self.bgNode     = SKSpriteNode(imageNamed: WelcomePlaque.BG_IMAGE)
        self.textNode   = SKLabelNode(text: self.text)
        self.animTime   = TimeInterval(WelcomePlaque.ANIM_DURAT)
        
        setupBgNode()
        setupTextNode()
        animateBgNode()
        animateTextNode()
    }
    
    private var bgTargetY: CGFloat {
        get {
            if self._bgTargetY == nil {
                self._bgTargetY = ((self.scene.size.height / 2) * self.scene.cozcukScaleMax)
                                - ((self.bgNode.size.height / 2) * self.scene.cozcukScaleMax)
            }
            return self._bgTargetY!
        }
    }
    
    private func setupBgNode() {
        self.bgNode.setScale(self.scene.cozcukScaleMax)
        
        let bgY: CGFloat = (self.scene.size.height / 2)
                         + (self.bgNode.size.height * self.bgNode.yScale / 2)
        
        self.bgNode.position = CGPoint(x: 0, y: bgY)
        self.scene.addChild(self.bgNode)
    }
    
    private func setupTextNode() {
        self.textNode.fontName      =   LetterNode.FONT
        self.textNode.fontSize      =   LetterNode.FONT_SIZE
                                        * self.bgNode.xScale
                                        * WelcomePlaque.FONT_SCALE
        self.textNode.fontColor     =   UIColor.black
        self.textNode.position      =   self.bgNode.position
        self.textNode.position.y    =   getTextY(baseY: self.textNode.position.y)
        self.textNode.zPosition     =   self.bgNode.zPosition + 1
        self.scene.addChild(self.textNode)
    }
    
    private func animateBgNode() {
        let bgAnimation = SKAction.moveTo(y         : self.bgTargetY,
                                          duration  : self.animTime)
        self.bgNode.run(bgAnimation)
    }
    
    private func animateTextNode() {
        let txtAnimation = SKAction.moveTo(y         : getTextY(baseY: self.bgTargetY),
                                           duration  : self.animTime)
        self.textNode.run(txtAnimation)
    }
    
    private func getTextY(baseY: CGFloat) -> CGFloat {
        return baseY - (baseY * WelcomePlaque.TEXT_MARGIN)
    }
}
