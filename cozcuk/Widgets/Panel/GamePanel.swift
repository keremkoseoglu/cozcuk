//
//  GameScenePanel.swift
//  cozcuk
//
//  Created by Dr. Kerem Koseoglu on 15.08.2022.
//

import SpriteKit

struct GamePanelObservers {
    var panelButton    : GamePanelButtonsObserver?
    var keyboardButton : KeyboardButtonsObserver?
}

class GamePanel {
    public  var clock       : GameClock
    public  var keyboard    : Keyboard?
    public  var buttons     : GamePanelButtons?
    
    private var scene       : SKScene
    private var observers   : GamePanelObservers?
    private var scoreBoard  : ScoreBoard?
    
    
    init(scene: SKScene, observers: GamePanelObservers?, zPosition: CGFloat = 1) {
        self.scene      = scene
        self.observers  = observers
        
        self.buttons = GamePanelButtons(scene       : self.scene,
                                        zPosition   : zPosition,
                                        observer    : self.observers?.panelButton)
        
        self.clock = GameClock(scene    : self.scene,
                               position : CGPoint(x: self.buttons!.exitButton.position.x,
                                                  y: self.buttons!.toggleMusicButton.position.y),
                               zPosition: zPosition)
    
        self.keyboard = Keyboard(scene      : self.scene,
                                 position   : CGPoint(x: 0, y: -250 * self.scene.cozcukScaleMax),
                                 zPosition  : zPosition,
                                 observer   : self.observers?.keyboardButton)
        
        do {
            self.scoreBoard = try ScoreBoard(scene: self.scene,
                                             position: CGPoint(x: self.clock.width / 3, y: self.buttons!.toggleMusicButton.position.y))
        } catch {print(error)}
    }
    
    func touchesBegan(_ touches: Set<UITouch>) {
        self.buttons?.touchesBegan(touches)
        self.keyboard?.touchesBegan(touches)
    }
    
    public func enableAnswerRelatedStuff() {
        self.buttons?.enableAnswerRelatedButtons()
        self.keyboard?.enableAnswerRelatedStuff()
    }
    
    public func disableAnswerRelatedStuff() {
        self.buttons?.disableAnswerRelatedButtons()
        self.keyboard?.disableAnswerRelatedStuff()
    }
}
