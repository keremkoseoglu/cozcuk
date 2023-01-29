//
//  GamePanelButtonFactory.swift
//  cozcuk
//
//  Created by Dr. Kerem Koseoglu on 16.08.2022.
//

import SpriteKit

class GamePanelButtonFactory {
    public  static let EXIT_BUTTON_TEXT     : String    = "Çıkış"
    public  static let HINT_BUTTON_TEXT     : String    = "İpucu"
    public  static let ANSWER_BUTTON_TEXT   : String    = "Pes"
    public  static let NEXT_BUTTON_TEXT     : String    = "Geç"
    
    private static let SCENE_BOTTOM_MARGIN  : CGFloat   = 100
    private static let IMAGE_SCALE_MULTI    : CGFloat   = 0.4
    private static let TEXT_SCALE_MULTI     : CGFloat   = 0.35
    private static let TEXT_MARGIN_MULTI    : CGFloat   = 1.2
    
    private var scene           : SKScene
    private var zPosition       : CGFloat
    private var _yPos           : CGFloat?
    private var _exitX          : CGFloat?
    private var _hintX          : CGFloat?
    private var _answerX        : CGFloat?
    private var _nextX          : CGFloat?
    private var _imgScale       : CGFloat?
    private var _txtScale       : CGFloat?
    private var _txtMarginScale : CGFloat?
    
    init(scene: SKScene, zPosition: CGFloat) {
        self.scene      = scene
        self.zPosition  = zPosition
    }
    
    public func createExitButton() -> PushButton {
        return PushButton(scene            : self.scene,
                          shape            : PushButtonShape.small,
                          color            : PushButtonColor.orange,
                          text             : GamePanelButtonFactory.EXIT_BUTTON_TEXT,
                          zPosition        : self.zPosition,
                          position         : CGPoint(x: self.exitX, y: self.yPos),
                          imageScale       : self.imageScale,
                          textScale        : self.textScale,
                          textMarginScale  : self.textMarginScale)
    }
    
    public func createHintButton() -> PushButton {
        return PushButton(scene            : self.scene,
                          shape            : PushButtonShape.normal,
                          color            : PushButtonColor.pink,
                          text             : GamePanelButtonFactory.HINT_BUTTON_TEXT,
                          zPosition        : self.zPosition,
                          position         : CGPoint(x: self.hintX, y: self.yPos),
                          imageScale       : self.imageScale,
                          textScale        : self.textScale,
                          textMarginScale  : self.textMarginScale )
    }
    
    public func createShowAnswerButton() -> PushButton {
        return PushButton(scene            : self.scene,
                          shape            : PushButtonShape.normal,
                          color            : PushButtonColor.pink,
                          text             : GamePanelButtonFactory.ANSWER_BUTTON_TEXT,
                          zPosition        : self.zPosition,
                          position         : CGPoint(x: self.answerX, y: self.yPos),
                          imageScale       : self.imageScale,
                          textScale        : self.textScale,
                          textMarginScale  : self.textMarginScale )
    }
    
    public func createNextPuzzleButton() -> PushButton {
        return PushButton(scene            : self.scene,
                          shape            : PushButtonShape.small,
                          color            : PushButtonColor.orange,
                          text             : GamePanelButtonFactory.NEXT_BUTTON_TEXT,
                          zPosition        : self.zPosition,
                          position         : CGPoint(x: self.nextX, y: self.yPos),
                          imageScale       : self.imageScale,
                          textScale        : self.textScale,
                          textMarginScale  : self.textMarginScale )
    }
    
    public func createToggleMusicButton() -> ToggleButton {
        return ToggleButton(scene       : self.scene,
                            onImage     : "Music_On",
                            offImage    : "Music_Off_2",
                            position    : CGPoint(x: self.nextX, y: self.yPos * -1),
                            zPosition   : self.zPosition,
                            scale       : self.imageScale / 3,
                            checked     : false)
    }
    
    private var yPos: CGFloat {
        get {
            if self._yPos == nil {
                self._yPos = ( (SKScene.COZCUK_HEIGHT / -2)
                               + GamePanelButtonFactory.SCENE_BOTTOM_MARGIN )
                             * self.scene.cozcukScaleY
            }
            
            return self._yPos!
        }
    }
    
    private var exitX: CGFloat {
        get {
            if self._exitX == nil {
                self._exitX = (self.scene.size.width / -2)
                                + (PushButtonShape.small.size.width * self.imageScale / 2)
            }
            return self._exitX!
        }
    }
    
    private var hintX: CGFloat {
        get {
            if self._hintX == nil {
                self._hintX = (self.scene.size.width / -4)
                                + (PushButtonShape.normal.size.width * self.imageScale / 2)
            }
            return self._hintX!
        }
    }
    
    private var answerX: CGFloat {
        get {
            if self._answerX == nil {
                self._answerX = self.hintX * -1
            }
            return self._answerX!
        }
    }
    
    private var nextX: CGFloat {
        get {
            if self._nextX == nil {
                self._nextX = self.exitX * -1
            }
            return self._nextX!
        }
    }
    
    private var imageScale: CGFloat {
        get {
            if self._imgScale == nil {
                self._imgScale = self.scene.cozcukScaleMax
                                    * GamePanelButtonFactory.IMAGE_SCALE_MULTI
            }
            return self._imgScale!
        }
    }
    
    private var textScale: CGFloat {
        get {
            if self._txtScale == nil {
                self._txtScale = self.scene.cozcukScaleMax
                                    * GamePanelButtonFactory.TEXT_SCALE_MULTI
            }
            return self._txtScale!
        }
    }
    
    private var textMarginScale: CGFloat {
        get {
            if self._txtMarginScale == nil {
                self._txtMarginScale = self.scene.cozcukScaleMax
                                         * GamePanelButtonFactory.TEXT_MARGIN_MULTI
            }
            return self._txtMarginScale!
        }
    }
}
