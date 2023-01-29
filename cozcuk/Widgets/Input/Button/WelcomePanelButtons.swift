//
//  WelcomePanelButtons.swift
//  cozcuk
//
//  Created by Dr. Kerem Koseoglu on 29.08.2022.
//

import SpriteKit

enum WelcomePanelButton {
    case startGame
    case stats
    case tutorial
}

protocol WelcomePanelButtonsObserver {
    func welcomePanelButtonClicked(_ button: WelcomePanelButton)
}

class WelcomePanelButtons {
    public  var startButton         : PushButton
    public  var statsButton         : PushButton
    public  var tutorialButton      : PushButton
    public  var observer            : WelcomePanelButtonsObserver?
    
    private var scene               : SKScene
    private var zPosition           : CGFloat
    
    init(scene: SKScene, zPosition: CGFloat, observer: WelcomePanelButtonsObserver?) {
        self.scene              = scene
        self.zPosition          = zPosition
        self.observer           = observer
        
        let buttonFactory       = WelcomePanelButtonFactory(scene: scene, zPosition: zPosition)
        
        self.startButton        = buttonFactory.createStartButton()
        self.statsButton        = buttonFactory.createStatsButton()
        self.tutorialButton     = buttonFactory.createTutorialButton()
    }
    
    public func touchesBegan(_ touches: Set<UITouch>) {
        if self.observer == nil {return}
        
        for touch in touches {
            let touchLocation   = touch.location(in: self.scene)
            let touchedNodes    = self.scene.nodes(at: touchLocation)
            
            for touchedNode in touchedNodes {
                if self.startButton.isOwnNode(touchedNode) {
                    PushButtonAnimator.getInstance().click(button   : self.startButton,
                                                           scene    : self.scene)
                    self.observer?.welcomePanelButtonClicked(.startGame)
                    return
                }
                
                if self.statsButton.isOwnNode(touchedNode) {
                    PushButtonAnimator.getInstance().click(button   : self.statsButton,
                                                           scene    : self.scene)
                    self.observer?.welcomePanelButtonClicked(.stats)
                    return
                }
                
                if self.tutorialButton.isOwnNode(touchedNode) {
                    PushButtonAnimator.getInstance().click(button   : self.tutorialButton,
                                                           scene    : self.scene)
                    self.observer?.welcomePanelButtonClicked(.tutorial)
                    return
                }
            }
        }
    }
}
