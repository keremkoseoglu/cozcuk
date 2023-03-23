//
//  TutorialLabeledButtonSlide.swift
//  cozcuk
//
//  Created by Dr. Kerem Koseoglu on 13.01.2023.
//

import SpriteKit

class TutorialLabeledButtonSlide: Slide, ColorSchemeObserver {
    private static var LABEL_TOP: CGFloat = 300
    private var labelText       : String
    private var button          : PushButton
    private var buttonLabel     : SKLabelNode?
    private var colorScheme     : ColorSchemeManager
    
    init(labelText: String, button: PushButton) {
        self.labelText      = labelText
        self.button         = button
        self.button.visible = false
        self.colorScheme    = ColorSchemeManager.getInstance()
        self.colorScheme.addObserver(self)
    }
    
    func putToScene(scene: SKScene, zPosition: CGFloat) {
        self.button.position    = CGPoint(x: 0, y: 0)
        self.button.visible     = true
        
        let labelY = TutorialLabeledButtonSlide.LABEL_TOP * -1 * scene.cozcukScaleY
        
        self.buttonLabel = SKLabelNode(text: labelText)
        self.buttonLabel!.position  = CGPoint(x: 0, y: labelY)
        self.buttonLabel!.zPosition = zPosition
        self.buttonLabel!.verticalAlignmentMode = .bottom
        self.buttonLabel!.fontName              = "Impact"
        self.buttonLabel!.fontSize              = 45 * scene.cozcukScaleMax
        setButtonLabelColor()
        scene.addChild(self.buttonLabel!)
    }
    
    func removeFromScene() {
        self.button.removeFromScene()
        self.buttonLabel?.removeFromParent()
    }
    
    public func colorSchemeChanged(uiStyle: UIUserInterfaceStyle) {
        setButtonLabelColor()
    }
    
    private func setButtonLabelColor() {
        switch self.colorScheme.userInterfaceStyle {
        case .light:
            self.buttonLabel?.fontColor = .black
        default:
            self.buttonLabel?.fontColor = .white
        }
    }
}
