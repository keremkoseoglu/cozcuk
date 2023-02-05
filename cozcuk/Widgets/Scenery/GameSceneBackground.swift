//
//  GameSceneBackground.swift
//  cozcuk
//
//  Created by Dr. Kerem Koseoglu on 14.08.2022.
//

import SpriteKit

class GameSceneBackground: ColorSchemeObserver {
    private static let DARK_IMG_NAME    : String    = "Grow"
    private static let LIGHT_IMG_NAME   : String    = "Grow2"
    private var darkNode                : SKSpriteNode?
    private var lightNode               : SKSpriteNode?
    private var scene                   : SKScene
    private var zPosition               : CGFloat
    
    init(scene: SKScene, zPosition: CGFloat = 0) {
        self.scene          = scene
        self.zPosition      = zPosition
        self.darkNode       = createNode(imageName: GameSceneBackground.DARK_IMG_NAME)
        self.lightNode      = createNode(imageName: GameSceneBackground.LIGHT_IMG_NAME)
        
        self.scene.addChild(self.darkNode!)
        self.scene.addChild(self.lightNode!)
        
        let csm = ColorSchemeManager.getInstance()
        implementColorScheme(uiStyle: csm.userInterfaceStyle)
        csm.addObserver(self)
    }
    
    public func colorSchemeChanged(uiStyle: UIUserInterfaceStyle) {
        implementColorScheme(uiStyle: uiStyle)
    }
    
    private func createNode(imageName: String) -> SKSpriteNode {
        let result       = SKSpriteNode(imageNamed: imageName)
        result.position  = CGPoint(x: 0, y: 0)
        result.zPosition = self.zPosition
        result.alpha     = 0.5
        return result
    }
    
    private func implementColorScheme(uiStyle: UIUserInterfaceStyle) {
        switch uiStyle {
        case .light:
            self.darkNode?.isHidden = true
            self.lightNode?.isHidden = false
            self.scene.backgroundColor = UIColor.white
        default:
            self.darkNode?.isHidden = false
            self.lightNode?.isHidden = true
            self.scene.backgroundColor = UIColor.black
        }
    }
}
