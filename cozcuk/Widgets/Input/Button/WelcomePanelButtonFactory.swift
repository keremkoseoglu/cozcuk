//
//  WelcomePanelButtonFactory.swift
//  cozcuk
//
//  Created by Dr. Kerem Koseoglu on 29.08.2022.
//

import SpriteKit

class WelcomePanelButtonFactory {
    public  static  let PLAY_TEXT               : String            = "Oyna"
    public  static  let STAT_TEXT               : String            = "Tarihçe"
    private static  let IMAGE_SCALE_MULTI       : CGFloat           = 0.6
    private static  let TEXT_SCALE_MULTI        : CGFloat           = 0.6
    private static  let TEXT_MARGIN_MULTI       : CGFloat           = 1
    private static  let BTN_SHAPE               : PushButtonShape   = PushButtonShape.big
    private         var scene                   : SKScene
    private         var zPosition               : CGFloat
    private         var _imgScale               : CGFloat?
    private         var _txtScale               : CGFloat?
    private         var _txtMarginScale         : CGFloat?
    private         var _btnSpace               : CGFloat?
    
    init(scene: SKScene, zPosition: CGFloat) {
        self.scene      = scene
        self.zPosition  = zPosition
    }
    
    public func createStartButton() -> PushButton {
        return PushButton(scene            : self.scene,
                          shape            : WelcomePanelButtonFactory.BTN_SHAPE,
                          color            : .green,
                          text             : WelcomePanelButtonFactory.PLAY_TEXT,
                          zPosition        : self.zPosition,
                          position         : CGPoint(x: 0, y: self.btnSpace),
                          imageScale       : self.imageScale,
                          textScale        : self.textScale,
                          textMarginScale  : self.textMarginScale )
    }
    
    public func createTutorialButton() -> PushButton {
        return PushButton(scene            : self.scene,
                          shape            : WelcomePanelButtonFactory.BTN_SHAPE,
                          color            : .orange,
                          text             : GameRunModeManager.DEFAULT_TUTORIAL_TITLE,
                          zPosition        : self.zPosition,
                          position         : CGPoint(x: 0, y: 0),
                          imageScale       : self.imageScale,
                          textScale        : self.textScale,
                          textMarginScale  : self.textMarginScale )
    }
    
    public func createStatsButton() -> PushButton {
        return PushButton(scene            : self.scene,
                          shape            : WelcomePanelButtonFactory.BTN_SHAPE,
                          color            : .pink,
                          text             : WelcomePanelButtonFactory.STAT_TEXT,
                          zPosition        : self.zPosition,
                          position         : CGPoint(x: 0, y: -self.btnSpace),
                          imageScale       : self.imageScale,
                          textScale        : self.textScale,
                          textMarginScale  : self.textMarginScale )
    }
    
    private var imageScale: CGFloat {
        get {
            if self._imgScale == nil {
                self._imgScale = self.scene.cozcukScaleMax
                                    * WelcomePanelButtonFactory.IMAGE_SCALE_MULTI
            }
            return self._imgScale!
        }
    }
    
    private var textScale: CGFloat {
        get {
            if self._txtScale == nil {
                self._txtScale = self.scene.cozcukScaleMax
                                    * WelcomePanelButtonFactory.TEXT_SCALE_MULTI
            }
            return self._txtScale!
        }
    }
    
    private var textMarginScale: CGFloat {
        get {
            if self._txtMarginScale == nil {
                self._txtMarginScale = self.scene.cozcukScaleMax
                                         * WelcomePanelButtonFactory.TEXT_MARGIN_MULTI
            }
            return self._txtMarginScale!
        }
    }
    
    private var btnSpace: CGFloat {
        get {
            if self._btnSpace == nil {
                let btnSize = WelcomePanelButtonFactory.BTN_SHAPE.size
                self._btnSpace = btnSize.height * self.scene.cozcukScaleMax
            }
            return self._btnSpace!
        }
    }
}
