//
//  Keyboard.swift
//  cozcuk
//
//  Created by Dr. Kerem Koseoglu on 18.08.2022.
//

import SpriteKit

enum KeyboardButton {
    case guess
}

protocol KeyboardButtonsObserver {
    func keyboardButtonClicked(_ button: KeyboardButton)
}

class Keyboard {
    public  static  let DELETE_BUTTON_TEXT      : String   = "Sil"
    public  static  let GUESS_BUTTON_TEXT       : String   = "Gönder"
    
    private static  let KEY_ROWS                : [String] = ["QWERTYUIOPĞÜ",
                                                              "ASDFGHJKLŞİ",
                                                              "ZXCVBNMÖÇ"]
    private static  let LETTER_BUTTON_COLOR     = LetterButtonColor.ovalBlue
    private static  let PUSH_BUTTON_SHAPE       = PushButtonShape.long
    private static  var _LETTER_BUTTON_SPRITE   : SKSpriteNode?
    private static  var _LONGEST_KEY_ROW_COUNT  : Int?
    private         var scene                   : SKScene
    private         var letterKeys              : [LetterNode]
    private         var position                : CGPoint
    private         var zPosition               : CGFloat
    private         var scale                   : CGFloat
    private         var yCursor                 : CGFloat
    private         var monitor                 : SKShapeNode?
    private         var monitorLabel            : SKLabelNode?
    private         var observer                : KeyboardButtonsObserver?
    private         var delButton               : PushButton?
    private         var guessButton             : PushButton?
    private         var _screenText             : String
    private         var backspaceButton         : PushButton?
    private         var answerRelatedButtons    : [PushButton?]?
    
    
    public init(scene       : SKScene,
                position    : CGPoint,
                zPosition   : CGFloat,
                observer    : KeyboardButtonsObserver?) {
        self.scene          = scene
        self.position       = position
        self.zPosition      = zPosition
        self.letterKeys     = [LetterNode]()
        self.scale          = 0
        self.yCursor        = self.position.y
        self.observer       = observer
        self._screenText    = ""
        
        calculateScale()
        buildMonitor()
        buildKeyboard()
        buildButtons()
    }
    
    public var screenText: String {
        get {
            return self._screenText
        }
        set(newText) {
            self._screenText = newText
            updateMonitorText()
        }
    }
    
    public func touchesBegan(_ touches: Set<UITouch>) {
        for touch in touches {
            let touchLocation   = touch.location(in: self.scene)
            let touchedNodes    = self.scene.nodes(at: touchLocation)
            
            for touchedNode in touchedNodes {
                if self.guessButton!.isOwnNode(touchedNode) {
                    PushButtonAnimator.getInstance().click(
                        button  : self.guessButton!,
                        scene   : self.scene)
                    
                    self.observer?.keyboardButtonClicked(.guess)
                    return
                }
                
                if self.delButton!.isOwnNode(touchedNode) {
                    PushButtonAnimator.getInstance().click(
                        button  : self.delButton!,
                        scene   : self.scene)
                    
                    self.screenText = ""
                    return
                }
                
                if self.backspaceButton!.isOwnNode(touchedNode) {
                    PushButtonAnimator.getInstance().click(
                        button  : self.backspaceButton!,
                        scene   : self.scene)
                    
                    if self.screenText.count > 0 {
                        self.screenText = String(self.screenText.prefix(self.screenText.count - 1))
                    }
                    
                    return
                }
                
                for letterKey in self.letterKeys {
                    if letterKey.isOwnNode(touchedNode) {
                        LetterAnimator.getInstance().click(letter: letterKey)
                        self.screenText += letterKey.letter
                        return
                    }
                }

            }
        }
    }
    
    private static var longestKeyRowCount: Int {
        get {
            if Keyboard._LONGEST_KEY_ROW_COUNT == nil {
                Keyboard._LONGEST_KEY_ROW_COUNT = 0
                for keyRow in Keyboard.KEY_ROWS {
                    if keyRow.count > Keyboard._LONGEST_KEY_ROW_COUNT! {
                        Keyboard._LONGEST_KEY_ROW_COUNT = keyRow.count
                    }
                }
            }
            return Keyboard._LONGEST_KEY_ROW_COUNT!
        }
    }
    
    private static var letterButtonSprite: SKSpriteNode {
        get {
            if Keyboard._LETTER_BUTTON_SPRITE == nil {
                Keyboard._LETTER_BUTTON_SPRITE =
                    SKSpriteNode(imageNamed: Keyboard.LETTER_BUTTON_COLOR.imageName)
            }
            return Keyboard._LETTER_BUTTON_SPRITE!
        }
    }
    
    private func calculateScale() {
        let btnWidth    = Keyboard.letterButtonSprite.size.width
        let rowWidth    = btnWidth * CGFloat(Keyboard.longestKeyRowCount)
        self.scale      = self.scene.size.width / rowWidth
    }
    
    private func buildMonitor() {
        // Monitor
        let height = 100 * self.scale
        
        self.monitor = SKShapeNode(rect: CGRect(x       : self.scene.size.width / -2,
                                                y       : self.yCursor,
                                                width   : self.scene.size.width,
                                                height  : height),
                                   cornerRadius: 2)
        
        self.monitor!.fillColor      = .gray
        self.monitor!.glowWidth      = 1
        self.monitor!.alpha          = 1
        
        self.scene.addChild(self.monitor!)
        
        
        // Monitor label
        self.monitorLabel               = SKLabelNode(fontNamed: LetterNode.FONT)
        self.monitorLabel!.fontSize     = LetterNode.FONT_SIZE * self.scale
        self.monitorLabel!.fontColor    = LetterNode.FONT_COLOR
        self.monitorLabel!.zPosition    = self.monitor!.zPosition + 1
        self.monitorLabel!.position     = CGPoint(x: self.monitor!.position.x,
                                                  y: self.yCursor + (height / 2))
        self.monitorLabel!.horizontalAlignmentMode  = .center
        self.monitorLabel!.verticalAlignmentMode    = .center
        self.scene.addChild(self.monitorLabel!)
        
        // Flush
        self.yCursor -= height
    }
    
    public func enableAnswerRelatedStuff() {
        setAnswerRelatedStuffEnabled(enabled: true)
    }
    
    public func disableAnswerRelatedStuff() {
        setAnswerRelatedStuffEnabled(enabled: false)
    }
    
    private func buildKeyboard() {
        for keyRow in Keyboard.KEY_ROWS {
            var keyX = self.position.x
                     - ((CGFloat(keyRow.count) / 2)
                        * Keyboard.letterButtonSprite.size.width
                        * self.scale)
                     + ( Keyboard.letterButtonSprite.size.width / 4 )
            
            for letter in keyRow {
                let letterNode = createLetterNode(letter: String(letter), x: keyX, y: self.yCursor)
                self.letterKeys.append(letterNode)
                
                keyX += Keyboard.letterButtonSprite.size.width * self.scale
            }
            
            self.yCursor -= Keyboard.letterButtonSprite.size.height * self.scale
        }
    }
    
    private func buildButtons() {
        self.yCursor -= Keyboard.letterButtonSprite.size.height * self.scale / 2
        let btnWidth = Keyboard.PUSH_BUTTON_SHAPE.size.width
        
        self.delButton =
            createPushButton(color  : .orange,
                             text   : Keyboard.DELETE_BUTTON_TEXT,
                             x      : 0 - (btnWidth / 2 * self.scale),
                             y      : self.yCursor)
        
        self.guessButton =
            createPushButton(color  : .green,
                             text   : Keyboard.GUESS_BUTTON_TEXT,
                             x      : self.delButton!.position.x * -1,
                             y      : self.delButton!.position.y)
        
        let backX = self.guessButton!.position.x
                    + (self.guessButton!.imageNode.size.width * self.scale * 2)
        
        self.backspaceButton =
            createPushButton(color  : .grey,
                             text   : "",
                             x      : backX,
                             y      : self.delButton!.position.y,
                             shape  : PushButtonShape.arrow)
        
        self.yCursor -= Keyboard.PUSH_BUTTON_SHAPE.size.height * self.scale
        
        self.answerRelatedButtons   = [self.delButton, self.guessButton, self.backspaceButton]
    }
    
    private func createLetterNode(letter    : String,
                                  x         : CGFloat,
                                  y         : CGFloat) -> LetterNode {
        return LetterNode(scene       : self.scene,
                          letter      : String(letter),
                          position    : CGPoint(x: x, y: y),
                          zPosition   : self.zPosition,
                          scale       : self.scale,
                          color       : Keyboard.LETTER_BUTTON_COLOR,
                          alpha       : 1,
                          textScale   : 0.75)
    }
    
    private func createPushButton(color : PushButtonColor,
                                  text  : String,
                                  x     : CGFloat,
                                  y     : CGFloat,
                                  shape : PushButtonShape = Keyboard.PUSH_BUTTON_SHAPE
                                 ) -> PushButton {
        return PushButton(scene             : self.scene,
                          shape             : shape,
                          color             : color,
                          text              : text,
                          zPosition         : self.zPosition,
                          position          : CGPoint(x: x, y: y),
                          imageScale        : self.scale / 1.2,
                          textScale         : self.scale / 1.8,
                          textMarginScale   : 1.25)
    }
    
    private func updateMonitorText() {
        self.monitorLabel?.text = self._screenText
    }
    
    private func setAnswerRelatedStuffEnabled(enabled: Bool) {
        for button in self.answerRelatedButtons! {button!.enabled = enabled}
        
        for letter in self.letterKeys {letter.enabled = enabled}
    }
}
