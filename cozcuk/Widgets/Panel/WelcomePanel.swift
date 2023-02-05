//
//  WelcomePanel.swift
//  cozcuk
//
//  Created by Dr. Kerem Koseoglu on 29.08.2022.
//

import SpriteKit

class WelcomePanel: ColorSchemeObserver {
    private static  let FONT_SCALE          : CGFloat   = 0.25
    public          var buttons             : WelcomePanelButtons
    private         var scene               : SKScene
    private         var zPosition           : CGFloat
    private         var labelY              : CGFloat
    private         var kkLabel             : SKLabelNode?
    private         var colorSchemeManager  : ColorSchemeManager
    
    
    public init(scene: SKScene, zPosition: CGFloat, observer: WelcomePanelButtonsObserver) {
        self.scene              = scene
        self.zPosition          = zPosition
        self.labelY             = (self.scene.size.height / -2) + (100 * self.scene.cozcukScaleY)
        self.colorSchemeManager = ColorSchemeManager.getInstance()
        
        self.buttons            = WelcomePanelButtons(scene     : scene,
                                                      zPosition : zPosition,
                                                      observer  : observer)

        self.kkLabel            = createKkLabel(color: .black)
        self.scene.addChild(self.kkLabel!)
        setLabelColor()
        
        self.colorSchemeManager.addObserver(self)
    }
    
    func touchesBegan(_ touches: Set<UITouch>) {
        self.buttons.touchesBegan(touches)
    }
    
    public func colorSchemeChanged(uiStyle: UIUserInterfaceStyle) {
        self.setLabelColor()
    }
    
    private func createKkLabel(color: UIColor) -> SKLabelNode {
        let result = SKLabelNode(text: "Dr. Kerem Koseoglu")
        result.zPosition  = self.zPosition + 2
        result.position   = CGPoint(x: 0, y: self.labelY)
        result.fontName   = PushButton.FONT
        result.fontSize   = LetterNode.FONT_SIZE * WelcomePanel.FONT_SCALE
        result.fontColor  = color
        return result
    }
    
    private func setLabelColor() {
        switch self.colorSchemeManager.userInterfaceStyle {
        case .light:
            self.kkLabel?.fontColor = .black
        default:
            self.kkLabel?.fontColor = .white
        }
    }
    
}
