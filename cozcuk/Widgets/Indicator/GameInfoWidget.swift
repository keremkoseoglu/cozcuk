//
//  GameInfoWidget.swift
//  cozcuk
//
//  Created by Dr. Kerem Koseoglu on 15.08.2022.
//

import SpriteKit

struct GameInfoWidgetProps {
    var icon    : String
}

class GameInfoWidget {
    public         var scene       : SKScene
    public         var position    : CGPoint
    public         var zPosition   : CGFloat
    public         var props       : GameInfoWidgetProps?
    private static let PANEL_IMG   : String    = "Panel_Up"
    private        var panel       : SKSpriteNode?
    private        var icon        : SKSpriteNode?
    private        var _text       : SKLabelNode?
    
    init(scene      : SKScene,
         position   : CGPoint,
         zPosition  : CGFloat = 1) {
        self.scene      = scene
        self.position   = position
        self.zPosition  = zPosition
        
        self.props      = getProps()
        putPanelToScene()
        putIconToScene()
        putTextToScene()
    }
    
    public var text: String {
        get {return self._text?.text ?? ""}
        set(newText) {self._text?.text = newText}
    }
    
    public var height: CGFloat {
        get {return self.panel!.size.height}
    }
    
    public var width: CGFloat {
        get {return self.panel!.size.width}
    }
    
    public func getProps() -> GameInfoWidgetProps {
        fatalError("Unimplemented method: getProps")
    }
    
    private func putPanelToScene() {
        self.panel  = SKSpriteNode(imageNamed: GameInfoWidget.PANEL_IMG)
        let scale   = (self.scene.size.width / 5) / self.panel!.size.width
        let x       = self.position.x + (self.panel!.size.width  / 2 * scale)
        let y       = self.position.y // - (self.panel!.size.height / 2 * scale)
        
        self.panel!.position     = CGPoint(x: x, y: y)
        self.panel!.zPosition    = self.zPosition
        self.panel!.setScale(scale)
        self.scene.addChild(self.panel!)
    }
    
    private func putIconToScene() {
        self.icon   = SKSpriteNode(imageNamed: self.props!.icon)
        let scale   = self.panel!.xScale * (self.panel!.size.width / (self.icon!.size.width * 2.5))
        let x       = self.panel!.position.x
                        - (self.panel!.size.width / 2)
                        + (self.icon!.size.width * scale / 2)
        
        let y       = self.panel!.position.y
                        + (self.panel!.size.height / 1.5)
                        - (self.icon!.size.height * scale / 2)
        
        self.icon!.position     = CGPoint(x: x, y: y)
        self.icon!.zPosition    = self.panel!.zPosition + 1
        self.icon!.setScale(scale)
        self.scene.addChild(self.icon!)
    }
    
    private func putTextToScene() {
        self._text  = SKLabelNode(text: "")
        let x       = self.icon!.position.x + (self.icon!.size.width / 2)
        
        let y       = self.icon!.position.y - (self.icon!.size.height / 2.2)
        
        self._text!.horizontalAlignmentMode = .left
        self._text!.verticalAlignmentMode   = .center
        self._text!.fontName                = LetterNode.FONT
        self._text!.fontSize                = LetterNode.FONT_SIZE * (self.panel!.xScale / 2.75)
        self._text!.fontColor               = LetterNode.FONT_COLOR
        self._text!.position                = CGPoint(x: x, y: y)
        self._text!.zPosition               = self.icon!.zPosition
        self.scene.addChild(self._text!)
    }
}
