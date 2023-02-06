//
//  PopupWidget.swift
//  cozcuk
//
//  Created by Dr. Kerem Koseoglu on 31.08.2022.
//

import SpriteKit

class ToastWidget {
    private static  var nodes           : [SKNode] = [SKNode]()
    private static  var disappearAction : SKAction?
    private         var scene           : SKScene
    private         var text            : String
    private         var rect            : SKShapeNode
    private         var label           : SKLabelNode
    private         var zPosition       : CGFloat
    
    public static func removeToastsFromScene(scene: SKScene) {
        for node in ToastWidget.nodes {
            if node.scene != scene {continue}
            node.removeAllActions()
            node.removeFromParent()
            node.isHidden = true
        }
    }
    
    public init(scene       : SKScene   ,
                text        : String    ,
                zPosition   : CGFloat   ,
                fadeOut     : Bool  = true) {
        self.scene      = scene
        self.text       = text
        self.zPosition  = zPosition
        self.rect       = SKShapeNode(rectOf: CGSize(width: self.scene.size.width / 4,
                                                     height: self.scene.size.height / 25),
                                      cornerRadius: 12)
        
        self.label      = SKLabelNode(text: self.text)
        
        showToast()
        if fadeOut { disappear() }
    }
    
    private static func lazyCreateDisappearAction() {
        if ToastWidget.disappearAction != nil {return}
        let waitAction  = SKAction.wait(forDuration: 2)
        let fadeAction  = SKAction.fadeOut(withDuration: 2)
        let rmvAction   = SKAction.removeFromParent()
        ToastWidget.disappearAction = SKAction.sequence([waitAction, fadeAction, rmvAction])
    }
    
    private func showToast() {
        self.rect.zPosition     = self.zPosition
        self.rect.fillColor     = .white
        self.rect.position      = CGPoint(x: 0, y: 0)
        
        self.label.zPosition    = self.rect.zPosition + 1
        self.label.fontColor    = .black
        self.label.fontName     = LetterNode.FONT
        self.label.fontSize     = LetterNode.FONT_SIZE * self.scene.cozcukScaleMax * 0.25
        self.label.position     = CGPoint(x: 0, y: self.rect.frame.size.height * -0.20)
        
        self.scene.addChild(self.rect)
        self.scene.addChild(self.label)
        
        ToastWidget.nodes.append(self.rect)
        ToastWidget.nodes.append(self.label)
    }
    
    private func disappear() {
        ToastWidget.lazyCreateDisappearAction()
        self.rect.run(ToastWidget.disappearAction!)
        self.label.run(ToastWidget.disappearAction!)
    }
}
