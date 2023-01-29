//
//  PushButtonAnimator.swift
//  cozcuk
//
//  Created by Dr. Kerem Koseoglu on 29.08.2022.
//

import SpriteKit

class PushButtonAnimator {
    private static var SINGLETON: PushButtonAnimator?
    
    public static func getInstance() -> PushButtonAnimator {
        if PushButtonAnimator.SINGLETON == nil {
            PushButtonAnimator.SINGLETON = PushButtonAnimator()
        }
        
        return PushButtonAnimator.SINGLETON!
    }
    
    public func click(button: PushButton, scene: SKScene) {
        let step1  = SKAction.scale(to      : button.imageNode.xScale * 0.5,
                                    duration: TimeInterval(0.04))
        
        let step2  = SKAction.scale(to      : button.imageNode.xScale,
                                    duration: TimeInterval(0.04))
        
        let action = SKAction.sequence([step1, step2])
        
        button.imageNode.run(action)
        FeedbackManager.getInstance().keyPress(scene: scene)
    }
}
