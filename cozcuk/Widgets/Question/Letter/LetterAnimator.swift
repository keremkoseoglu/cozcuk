//
//  LetterAnimator.swift
//  cozcuk
//
//  Created by Dr. Kerem Koseoglu on 14.08.2022.
//

import SpriteKit

enum VerticalDirection {
    case up
    case down
}

class LetterAnimator {
    public  static  let MOVE_DURATION        : CGFloat   = 1
    private static  let FADE_DURATION        : CGFloat   = 1
    private static  let DELAY_DURATION       : CGFloat   = 0.05
    private static  var SINGLETON            : LetterAnimator?
    private static  let MOVE_SIZE            : CGFloat   = 10
    private         var _fadeAndRemoveAction : SKAction?
    private         var _shiftUpAction       : SKAction?
    private         var _shiftDownAction     : SKAction?
    private         var _fadeInAction        : SKAction?
    
    public static var shiftAndMoveHorizontalDuration: CGFloat {
        get {return LetterAnimator.MOVE_DURATION * 3}
    }
    
    public static var fadeToColorAndShiftVerticalDuration: CGFloat {
        // +1 is an approximation
        get {return LetterAnimator.FADE_DURATION + 1}
    }
    
    public static func getInstance() -> LetterAnimator {
        if LetterAnimator.SINGLETON == nil {
            LetterAnimator.SINGLETON = LetterAnimator()
        }
        
        return LetterAnimator.SINGLETON!
    }
    
    public func fadeToColor(letter: LetterNode, newColor: LetterButtonColor) {
        // Copy current button
        let oldButtonNode       = letter.buttonNode.copy() as! SKSpriteNode
        oldButtonNode.zPosition = letter.buttonNode.zPosition + 1
        letter.scene?.addChild(oldButtonNode)
        
        // Set original color
        letter.color = newColor
        
        // Fade out copy
        oldButtonNode.run(self.fadeAndRemoveAction)
    }
    
    public func fadeIn(letter: LetterNode) {
        letter.runAction(self.fadeInAction)
    }
    
    public func shiftVertical(letter         : LetterNode,
                              direction      : VerticalDirection,
                              preDelayIndex  : Int = 0) {
        
        let action = buildShiftVerticalAction(letter        : letter,
                                              direction     : direction,
                                              preDelayIndex : preDelayIndex)
        
        letter.runAction(action)
    }
    
    public func fadeToColorAndShiftVertical(letter           : LetterNode,
                                            newColor         : LetterButtonColor,
                                            direction        : VerticalDirection,
                                            preDelayIndex    : Int = 0) {

        fadeToColor(letter: letter, newColor: newColor)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + LetterAnimator.FADE_DURATION, execute: {
            self.shiftVertical(letter        : letter,
                               direction     : direction,
                               preDelayIndex : preDelayIndex)
        })
    }
    
    public func fadeAndRemove(letter: LetterNode) {
        letter.runAction(self.fadeAndRemoveAction)
    }
    
    public func moveHorizontal(letter: LetterNode, targetX: CGFloat) {
        let moveAction = buildMoveAction(targetX: targetX)
        letter.runAction(moveAction)
    }
    
    public func shiftAndMoveHorizontal(letter           : LetterNode,
                                       targetX          : CGFloat,
                                       firstDirection   : VerticalDirection) {

        var move1Size = firstDirection == VerticalDirection.up ?
                          letter.buttonNode.size.height * -1 :
                          letter.buttonNode.size.height
        
        move1Size = move1Size / 2
        
        let move1Action = SKAction.moveBy(x         : 0,
                                          y         : move1Size,
                                          duration  : TimeInterval(LetterAnimator.MOVE_DURATION))
        
        let move2Action = SKAction.moveBy(x         : 0,
                                          y         : move1Size * -1,
                                          duration  : TimeInterval(LetterAnimator.MOVE_DURATION))
        
        let moveAction = buildMoveAction(targetX: targetX)
        
        let actions = SKAction.sequence([move1Action, moveAction, move2Action])
        
        letter.runAction(actions)
    }
    
    public func click(letter: LetterNode) {
        let step1  = SKAction.scale(to      : letter.buttonNode.xScale * 0.5,
                                    duration: TimeInterval(0.04))
        
        let step2  = SKAction.scale(to      : letter.buttonNode.xScale,
                                    duration: TimeInterval(0.04))
        
        let action = SKAction.sequence([step1, step2])
        
        letter.runButtonAction(action)
        FeedbackManager.getInstance().keyboardPress(scene: letter.scene!)
    }
    
    private init() {
    }
    
    private var fadeAndRemoveAction: SKAction {
        get {
            if self._fadeAndRemoveAction == nil {
                let fadeDuration    = TimeInterval(LetterAnimator.FADE_DURATION)
                let fadeAction      = SKAction.fadeOut(withDuration: fadeDuration)
                let rmvAction       = SKAction.removeFromParent()
                self._fadeAndRemoveAction = SKAction.sequence([fadeAction,
                                                               rmvAction])
            }
            return self._fadeAndRemoveAction!
        }
    }
    
    private var shiftUpAction: SKAction {
        get {
            if self._shiftUpAction == nil {
                self._shiftUpAction =
                    SKAction.moveBy(x: 0,
                                    y: LetterAnimator.MOVE_SIZE * -1,
                                    duration: TimeInterval(LetterAnimator.MOVE_DURATION))
            }
            
            return self._shiftUpAction!
        }
    }
    
    private var shiftDownAction: SKAction {
        get {
            if self._shiftDownAction == nil {
                self._shiftDownAction =
                    SKAction.moveBy(x: 0,
                                    y: LetterAnimator.MOVE_SIZE,
                                    duration: TimeInterval(LetterAnimator.MOVE_DURATION))
            }
            
            return self._shiftDownAction!
        }
    }
    
    private var fadeInAction: SKAction {
        get {
            if self._fadeInAction == nil {
                self._fadeInAction =
                    SKAction.fadeIn(withDuration: TimeInterval(LetterAnimator.FADE_DURATION))
            }
            return self._fadeInAction!
        }
    }
    
    private func verticalDirectionToShiftAction(_ direction: VerticalDirection) -> SKAction {
        switch direction {
        case .up:
            return self.shiftUpAction
        case .down:
            return self.shiftDownAction
        }
    }
    
    private func buildShiftVerticalAction(letter         : LetterNode,
                                          direction      : VerticalDirection,
                                          preDelayIndex  : Int = 0) -> SKAction {
                                                 
         var action = verticalDirectionToShiftAction(direction)
         
         if preDelayIndex > 0 {
             let delay       = TimeInterval(CGFloat(preDelayIndex) * LetterAnimator.DELAY_DURATION)
             let delayAction = SKAction.wait(forDuration: delay)
             action          = SKAction.sequence([delayAction, action])
         }
        
        return action
    }
    
    private func buildMoveAction(targetX: CGFloat) -> SKAction {
        return SKAction.moveTo(x: targetX, duration: LetterAnimator.MOVE_DURATION)
    }
}
