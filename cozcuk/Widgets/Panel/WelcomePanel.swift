//
//  WelcomePanel.swift
//  cozcuk
//
//  Created by Dr. Kerem Koseoglu on 29.08.2022.
//

import SpriteKit

class WelcomePanel {
    private static  let FONT_SCALE  : CGFloat   = 0.25
    private         var scene       : SKScene
    private         var zPosition   : CGFloat
    private         var kkLabel     : SKLabelNode
    public          var buttons     : WelcomePanelButtons
    
    public init(scene: SKScene, zPosition: CGFloat, observer: WelcomePanelButtonsObserver) {
        self.scene      = scene
        self.zPosition  = zPosition
        self.kkLabel    = SKLabelNode(text: "Dr. Kerem Koseoglu")
        
        self.buttons    = WelcomePanelButtons(scene     : scene,
                                              zPosition : zPosition,
                                              observer  : observer)

        setupKkLabel()
    }
    
    func touchesBegan(_ touches: Set<UITouch>) {
        self.buttons.touchesBegan(touches)
    }
    
    private func setupKkLabel() {
        let labelY = (self.scene.size.height / -2) + (100 * self.scene.cozcukScaleY)
        
        
        self.kkLabel.zPosition  = self.zPosition + 2
        self.kkLabel.position   = CGPoint(x: 0, y: labelY)
        self.kkLabel.fontColor  = .white
        self.kkLabel.fontName   = PushButton.FONT
        self.kkLabel.fontSize   = LetterNode.FONT_SIZE * WelcomePanel.FONT_SCALE
        self.scene.addChild(self.kkLabel)
    }
}
