//
//  PushButtons.swift
//  cozcuk
//
//  Created by Dr. Kerem Koseoglu on 16.08.2022.
//


import SpriteKit

enum GamePanelButton {
    case exitGame
    case showHint
    case showAnswer
    case nextPuzzle
    case toggleMusic
}

protocol GamePanelButtonsObserver {
    func gamePanelButtonClicked(_ button: GamePanelButton)
}

class GamePanelButtons {
    public  var exitButton              : PushButton
    public  var hintButton              : PushButton
    public  var showAnswerButton        : PushButton
    public  var nextPuzzleButton        : PushButton
    public  var toggleMusicButton       : ToggleButton
    public  var observer                : GamePanelButtonsObserver?
    
    private var scene                   : SKScene
    private var zPosition               : CGFloat
    private var answerRelatedButtons    : [PushButton]
    
    init(scene: SKScene, zPosition: CGFloat, observer: GamePanelButtonsObserver?) {
        self.scene              = scene
        self.zPosition          = zPosition
        self.observer           = observer
        
        let buttonFactory       = GamePanelButtonFactory(scene: scene, zPosition: zPosition)
        
        self.exitButton         = buttonFactory.createExitButton()
        self.hintButton         = buttonFactory.createHintButton()
        self.showAnswerButton   = buttonFactory.createShowAnswerButton()
        self.nextPuzzleButton   = buttonFactory.createNextPuzzleButton()
        self.toggleMusicButton  = buttonFactory.createToggleMusicButton()
        
        self.toggleMusicButton.checked = AudioManager.getInstance().soundIsOn
        
        self.answerRelatedButtons = [self.hintButton, self.showAnswerButton]
    }
    
    public func touchesBegan(_ touches: Set<UITouch>) {
        if self.observer == nil {return}
        
        for touch in touches {
            let touchLocation   = touch.location(in: self.scene)
            let touchedNodes    = self.scene.nodes(at: touchLocation)
            
            for touchedNode in touchedNodes {
                if self.exitButton.isOwnNode(touchedNode) {
                    PushButtonAnimator.getInstance().click(button: self.exitButton, scene: self.scene)
                    self.observer?.gamePanelButtonClicked(GamePanelButton.exitGame)
                    return
                }
                
                if self.hintButton.isOwnNode(touchedNode) {
                    PushButtonAnimator.getInstance().click(button   : self.hintButton,
                                                           scene    : self.scene)
                    self.observer?.gamePanelButtonClicked(GamePanelButton.showHint)
                    return
                }
                
                if self.showAnswerButton.isOwnNode(touchedNode) {
                    PushButtonAnimator.getInstance().click(button   : self.showAnswerButton,
                                                           scene    : self.scene)
                    self.observer?.gamePanelButtonClicked(GamePanelButton.showAnswer)
                    return
                }
                
                if self.nextPuzzleButton.isOwnNode(touchedNode) {
                    PushButtonAnimator.getInstance().click(button   : self.nextPuzzleButton,
                                                           scene    : self.scene)
                    self.observer?.gamePanelButtonClicked(GamePanelButton.nextPuzzle)
                    return
                }
                
                if self.toggleMusicButton.isOwnNode(touchedNode) {
                    self.observer?.gamePanelButtonClicked(GamePanelButton.toggleMusic)
                    return
                }
            }
        }
    }
    
    public func disableAnswerRelatedButtons() {
        setAnswerRelatedButtonsEnabled(enabled: false)
    }
    
    public func enableAnswerRelatedButtons() {
        setAnswerRelatedButtonsEnabled(enabled: true)
    }
    
    private func setAnswerRelatedButtonsEnabled(enabled: Bool) {
        for button in self.answerRelatedButtons {
            button.enabled = enabled
        }
    }
}


