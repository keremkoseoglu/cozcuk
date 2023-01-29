//
//  ToggleButton.swift
//  cozcuk
//
//  Created by Dr. Kerem Koseoglu on 17.08.2022.
//

import SpriteKit

class ToggleButton: NodeContainer {
    private var scene       : SKScene
    private var offNode     : SKSpriteNode
    private var onNode      : SKSpriteNode
    private var _checked    : Bool
    private var zPosition   : CGFloat
    private var _position   : CGPoint
    private var scale       : CGFloat
    
    public init(scene       : SKScene,
                onImage     : String,
                offImage    : String,
                position    : CGPoint,
                zPosition   : CGFloat = 2,
                scale       : CGFloat = 1,
                checked     : Bool = false) {
        self.scene      = scene
        self.onNode     = SKSpriteNode(imageNamed: onImage)
        self.offNode    = SKSpriteNode(imageNamed: offImage)
        self._checked   = checked
        self.zPosition  = zPosition
        self.scale      = scale
        self._position  = position
        
        initNode(self.onNode)
        initNode(self.offNode)
        welcomeChecked()
    }
    
    public var checked: Bool {
        get {return self._checked}
        set(newChecked) {
            self._checked = newChecked
            welcomeChecked()
        }
    }
    
    public var position: CGPoint {
        get {return self._position}
    }
    
    func isOwnNode(_ node: SKNode) -> Bool {
        return node == self.onNode || node == self.offNode
    }
    
    public func toggle() {
        self.checked = !self._checked
    }
    
    private func welcomeChecked() {
        self.onNode.isHidden    = !self._checked
        self.offNode.isHidden   = self._checked
    }
    
    private func initNode(_ node: SKSpriteNode) {
        node.position   = self._position
        node.zPosition  = self.zPosition
        
        node.setScale(self.scale)
        self.scene.addChild(node)
    }
    
    
}
