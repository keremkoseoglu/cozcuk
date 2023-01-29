//
//  WigglePuzzleAnimation.swift
//  cozcuk
//
//  Created by Dr. Kerem Koseoglu on 30.08.2022.
//

import SpriteKit

class WigglePuzzleAnimation: PuzzleAnimation {
    private var timer           : Timer?
    private var puzzleNode      : PuzzleNode?
    private var wiggleAction    : SKAction?
    
    static var runDuration: CGFloat {
        get {
            assert(false) // Will implement when needed
            return -1
        }
    }
    
    public init() {
        self.timer = Timer.scheduledTimer(timeInterval    : TimeInterval(1),
                                          target          : self,
                                          selector        : #selector(timerTicked),
                                          userInfo        : nil,
                                          repeats         : true)
    }
    
    func run(puzzleNode: PuzzleNode, options: PuzzleAnimationOptions) {
        self.puzzleNode = puzzleNode
    }
    
    func stop(puzzleNode: PuzzleNode) {
        self.puzzleNode = nil
    }
    
    func removeFromParent() {
        #warning("remove from parent")
    }
    
    @objc
    public func timerTicked() {
        if self.puzzleNode == nil {return}
        if !shouldRandomlyAnimate() {return}
        buildWiggleAction()
        let randomLetterIndex = Int.random(in: 0..<self.puzzleNode!.wordNode.letterNodes.count)
        let randomLetterNode = self.puzzleNode!.wordNode.getLetterAtIndex(randomLetterIndex)
        randomLetterNode.runAction(self.wiggleAction!)
    }
    
    private func buildWiggleAction() {
        if self.wiggleAction != nil {return}
        
        let upAction            = SKAction.move(by      : CGVector(dx: 0, dy: 10),
                                                duration: TimeInterval(0.1))
        let downAction          = SKAction.move(by      : CGVector(dx: 0, dy: -15),
                                                duration: TimeInterval(0.1))
        let up2Action           = SKAction.move(by      : CGVector(dx: 0, dy: 5),
                                                duration: TimeInterval(0.1))
        self.wiggleAction       = SKAction.sequence([upAction, downAction, up2Action])
    }
    
    private func shouldRandomlyAnimate() -> Bool {
        let rnd = Int.random(in: 0..<5)
        return rnd == 2
    }
    
}
