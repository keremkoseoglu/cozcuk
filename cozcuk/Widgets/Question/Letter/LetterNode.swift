//
//  LetterNode.swift
//  cozcuk
//
//  Created by Dr. Kerem Koseoglu on 13.08.2022.
//

import SpriteKit

class LetterNode: EnableableWidget {
    public  static let FONT                 : String    = "Menlo"
    public  static let FONT_SIZE            : CGFloat   = 100
    public  static let FONT_COLOR           : UIColor   = UIColor.black
    public  static let LETTER_TOP_MARGIN    : CGFloat   = 35
    private static var _sampleNode          : SKSpriteNode?
    private static var fadeOutAction        : SKAction?
    
    private var _letter             : String
    private var _scene              : SKScene?
    private var _buttonNode         : SKSpriteNode
    private var _letterNode         : SKLabelNode
    private var _position           : CGPoint
    private var zPosition           : CGFloat
    private var scale               : CGFloat
    private var _color              : LetterButtonColor
    private var alpha               : CGFloat
    private var textScale           : CGFloat
    private var _enabled            : Bool
    private var _enableableNodes    : [SKNode]?
    private var enabler             : WidgetEnabler?
    private var _removed            : Bool
    
    public static var sampleNode: SKSpriteNode {
        get {
            if LetterNode._sampleNode == nil {
                LetterNode._sampleNode = SKSpriteNode(imageNamed: LetterButtonColor.blue.imageName)
            }
            return LetterNode._sampleNode!
        }
    }
    
    init(scene      : SKScene?,
         letter     : String,
         position   : CGPoint,
         zPosition  : CGFloat,
         scale      : CGFloat = 1,
         color      : LetterButtonColor = LetterButtonColor.violet,
         alpha      : CGFloat = 1,
         textScale  : CGFloat = 1) {
        self._scene      = scene
        self._letter     = letter
        self._position   = position
        self.zPosition   = zPosition
        self.scale       = scale
        self._color      = color
        self.alpha       = alpha
        self._buttonNode = SKSpriteNode(imageNamed: self._color.imageName)
        self._letterNode = SKLabelNode(text: self._letter)
        self.textScale   = textScale
        self._enabled    = true
        self._removed    = false
        self.position    = position
        
        setupButton()
        setupLetter()
        
        self._enableableNodes   = [self._buttonNode, self._letterNode]
        self.enabler            = WidgetEnabler(widget: self)
    }
    
    public var color: LetterButtonColor {
        get {return self._color}
        set(newColor) {
            self._color = newColor
            self._buttonNode.texture = SKTexture(imageNamed: self._color.imageName)
        }
    }
    
    public var position: CGPoint {
        get {return self._buttonNode.position}
        set (newPosition) {
            self._position               = newPosition
            self._buttonNode.position    = self._position
            self._letterNode.position    = self._buttonNode.position
            self._letterNode.position.y  -= (LetterNode.LETTER_TOP_MARGIN * self.scale)
        }
    }
    
    public var buttonNode: SKSpriteNode {
        get {return self._buttonNode}
    }
    
    public var letterNode: SKLabelNode {
        get {return self._letterNode}
    }
    
    public var scene: SKScene? {
        get {return self._scene}
    }
    
    public var letter: String {
        get {return self._letter}
        set(newLetter) {
            self._letter            = newLetter
            self._letterNode.text   = self._letter
        }
    }
    
    public var enabled: Bool {
        get {
            return self._enabled
        }
        set (newEnabled) {
            self._enabled = newEnabled
            self.enabler!.updateGui()
        }
    }
    
    public var enableableNodes: [SKNode] {
        get {return self._enableableNodes!}
    }
    
    public var removed: Bool {get {return self._removed}}
    
    public func runAction(_ action: SKAction) {
        runButtonAction(action)
        runTextAction(action)
    }
    
    public func runButtonAction(_ action: SKAction) {
        self._buttonNode.run(action)
    }
    
    public func runTextAction(_ action: SKAction) {
        self._letterNode.run(action)
    }
    
    public func isOwnNode(_ node: SKNode) -> Bool {
        if (!self.enabled) {return false}
        return node == self.buttonNode || node == self.letterNode
    }
    
    public func removeFromScene() {
        if self._removed {return}
        self._removed = true
        self.enabled = false
        
        /*
         BU KODLAR; KEDİ PROBLEMİ VARKEN EKLENDİ. GEREK KALMADI.
         self._buttonNode.removeAllActions()
        self._buttonNode.removeFromParent()
        
        self._letterNode.removeAllActions()
        self._letterNode.removeFromParent()*/
        
        LetterNode.lazyBuildFadeOutAction()
        runTextAction(LetterNode.fadeOutAction!)
        runButtonAction(LetterNode.fadeOutAction!)
    }
    
    private static func lazyBuildFadeOutAction() {
        if LetterNode.fadeOutAction != nil {return}
        let act1 = SKAction.fadeOut(withDuration: 0.1)
        let act2 = SKAction.removeFromParent()
        LetterNode.fadeOutAction = SKAction.sequence([act1, act2])
    }
    
    private func setupButton() {
        self._buttonNode.zPosition   = self.zPosition
        self._buttonNode.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        self._buttonNode.alpha       = self.alpha
        self._buttonNode.setScale(self.scale)
        self._scene?.addChild(self._buttonNode)
    }
    
    private func setupLetter() {
        self._letterNode.fontName    = LetterNode.FONT
        self._letterNode.fontSize    = LetterNode.FONT_SIZE * self.scale * self.textScale
        self._letterNode.fontColor   = LetterNode.FONT_COLOR
        self._letterNode.zPosition   = self._buttonNode.zPosition + 2
        self._letterNode.alpha       = self.alpha
        self._scene?.addChild(self._letterNode)
    }
}
