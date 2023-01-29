//
//  PushButton.swift
//  cozcuk
//
//  Created by Dr. Kerem Koseoglu on 16.08.2022.
//

import SpriteKit

enum PushButtonShape: String {
    private static var _bigSample       : SKSpriteNode?
    private static var _littleSample    : SKSpriteNode?
    private static var _longSample      : SKSpriteNode?
    private static var _normalSample    : SKSpriteNode?
    private static var _roundSample     : SKSpriteNode?
    private static var _smallSample     : SKSpriteNode?
    private static var _arrowSample     : SKSpriteNode?
    
    case big        = "Big"
    case little     = "Little"
    case long       = "Long"
    case normal     = ""
    case round      = "Round"
    case small      = "Small"
    case arrow      = "Arrow"
    
    public var size: CGSize {
        get {
            switch self {
            case .big:
                if PushButtonShape._bigSample == nil {
                    PushButtonShape._bigSample = SKSpriteNode(imageNamed: PushButton.buildImageName(shape: self, color: .blue))
                }
                return PushButtonShape._bigSample!.size
            case .little:
                if PushButtonShape._littleSample == nil {
                    PushButtonShape._littleSample = SKSpriteNode(imageNamed: PushButton.buildImageName(shape: self, color: .blue))
                }
                return PushButtonShape._littleSample!.size
            case .long:
                if PushButtonShape._longSample == nil {
                    PushButtonShape._longSample = SKSpriteNode(imageNamed: PushButton.buildImageName(shape: self, color: .blue))
                }
                return PushButtonShape._longSample!.size
            case .normal:
                if PushButtonShape._normalSample == nil {
                    PushButtonShape._normalSample = SKSpriteNode(imageNamed: PushButton.buildImageName(shape: self, color: .blue))
                }
                return PushButtonShape._normalSample!.size
            case .round:
                if PushButtonShape._roundSample == nil {
                    PushButtonShape._roundSample = SKSpriteNode(imageNamed: PushButton.buildImageName(shape: self, color: .green))
                }
                return PushButtonShape._roundSample!.size
            case .small:
                if PushButtonShape._smallSample == nil {
                    PushButtonShape._smallSample = SKSpriteNode(imageNamed: PushButton.buildImageName(shape: self, color: .blue))
                }
                return PushButtonShape._smallSample!.size
            case .arrow:
                if PushButtonShape._arrowSample == nil {
                    PushButtonShape._arrowSample = SKSpriteNode(imageNamed: PushButton.buildImageName(shape: self, color: .blue))
                }
                return PushButtonShape._arrowSample!.size
            }
        }
    }
}

enum PushButtonColor: String {
    case blue       = "Blue"
    case green      = "Green"
    case grey       = "Grey"
    case orange     = "Orange"
    case pink       = "Pink"
    case red        = "Red"
}

class PushButton: NodeContainer, EnableableWidget {
    public  static  let FONT                : String = "Avenir Roman"
    private static  let IMG_NAME_PREFIX     : String = "Button_"
    
    private         var scene               : SKScene
    private         var shape               : PushButtonShape
    private         var color               : PushButtonColor
    private         var _text               : String
    private         var imageName           : String
    private         var _imageNode          : SKSpriteNode?
    private         var _textNode           : SKLabelNode?
    private         var zPosition           : CGFloat
    private         var _position           : CGPoint
    private         var imageScale          : CGFloat
    private         var textScale           : CGFloat
    private         var textMarginScale     : CGFloat
    private         var _enabled            : Bool
    private         var _enableableNodes    : [SKNode]?
    private         var enabler             : WidgetEnabler?
    
    init(scene              : SKScene,
         shape              : PushButtonShape,
         color              : PushButtonColor,
         text               : String,
         zPosition          : CGFloat,
         position           : CGPoint,
         imageScale         : CGFloat = 1,
         textScale          : CGFloat = 1,
         textMarginScale    : CGFloat = 1) {
        self.scene              = scene
        self.shape              = shape
        self.color              = color
        self._text              = text
        self.imageName          = ""
        self.zPosition          = zPosition
        self._position          = position
        self.imageScale         = imageScale
        self.textScale          = textScale
        self.textMarginScale    = textMarginScale
        self._enabled           = true
        
        self.buildSelfImageName()
        self.buildImageNode()
        self.buildTextNode()
        
        self._enableableNodes   = [self._imageNode!, self._textNode!]
        self.enabler            = WidgetEnabler(widget: self)
    }
    
    public static func buildImageName(shape: PushButtonShape, color: PushButtonColor) -> String {
        // Button_Big_Blue
        var result = PushButton.IMG_NAME_PREFIX
        if shape.rawValue != "" {result += "\(shape.rawValue)_"}
        result += "\(color.rawValue)"
        return result
    }
    
    public var position: CGPoint {
        get {return self._position}
        set(newPosition) {
            self._position          = newPosition
            self.imageNode.position = self._position
            self.textNode.position  = supposedTextPosition
        }
    }
    
    public var text: String {
        get {return self._text}
        set(newText) {
            self._text = newText
            self._textNode?.text = text
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
    
    public var imageNode: SKSpriteNode  {get {return self._imageNode!}}
    public var textNode : SKLabelNode   {get {return self._textNode!}}
    
    public var enableableNodes: [SKNode] {
        get {return self._enableableNodes!}
    }
    
    public var visible: Bool {
        get {
            return self._imageNode?.alpha != 0
        }
        set(newVisible) {
            if newVisible {
                self._imageNode?.alpha  = 100
                self._textNode?.alpha   = 100
                self._enabled           = true
            } else {
                self._imageNode?.alpha  = 0
                self._textNode?.alpha   = 0
                self._enabled           = false
            }
        }
    }
    
    public func isOwnNode(_ node: SKNode) -> Bool {
        if !self._enabled {return false}
        
        return node == self._imageNode! || node == self._textNode!
    }
    
    public func removeFromScene() {
        self._textNode?.removeFromParent()
        self._imageNode?.removeFromParent()
    }
    
    private var supposedTextPosition: CGPoint {
        get {
            let topMargin   : CGFloat = self._imageNode!.size.height / 5
            let posY        : CGFloat = self._imageNode!.position.y - (topMargin * self.textMarginScale)
            let pos         : CGPoint = CGPoint(x: self._imageNode!.position.x,
                                                y: posY)
            return pos
        }
    }
    
    private func buildSelfImageName() {
        // Button_Big_Blue
        self.imageName = PushButton.IMG_NAME_PREFIX
        if self.shape.rawValue != "" {self.imageName += "\(self.shape.rawValue)_"}
        self.imageName += "\(self.color.rawValue)"
    }
    
    private func buildImageNode() {
        self._imageNode = SKSpriteNode(imageNamed: self.imageName)
        self._imageNode!.zPosition  = self.zPosition
        self._imageNode!.position   = self._position
        self._imageNode!.setScale(self.imageScale)
        self.scene.addChild(self._imageNode!)
    }
    
    private func buildTextNode() {
        self._textNode                          = SKLabelNode(text: self.text)
        self._textNode!.fontName                = PushButton.FONT
        self._textNode!.fontColor               = LetterNode.FONT_COLOR
        self._textNode!.fontSize                = LetterNode.FONT_SIZE * self.textScale
        self._textNode!.horizontalAlignmentMode = .center
        self._textNode!.zPosition               = self._imageNode!.zPosition + 1
        self._textNode!.position                = self.supposedTextPosition
        self.scene.addChild(self._textNode!)
    }
}
