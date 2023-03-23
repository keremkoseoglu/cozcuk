//
//  GameScenePuzzleManager.swift
//  cozcuk
//
//  Created by Dr. Kerem Koseoglu on 23.08.2022.
//

import SpriteKit

class GameScenePuzzleManager {
    public  var puzzleNode  : PuzzleNode?
    private var scene       : SKScene
    private var zPosition   : CGFloat
    private var animator    : PuzzleAnimator
    
    public init(scene: SKScene, zPosition: CGFloat = 2) {
        self.scene      = scene
        self.zPosition  = zPosition
        self.animator   = PuzzleAnimator.getInstance()
    }
    
    public var isLoaded: Bool {
        get {return self.puzzleNode != nil}
    }
    
    public func loadPuzzle()  {
        self.puzzleNode?.wordNode.removeFromScene()
        do {
            // let puzzle = try PuzzleQueue.getInstance().getNextPuzzle()
            let puzzle = try GradedPuzzleQueue.getInstance().getNextPuzzle()
            loadPrebuiltPuzzle(puzzle)
        }
        catch {
            return
        }
        
    }
    
    public func loadPrebuiltPuzzle(_ puzzle: Puzzle) {
        self.puzzleNode?.wordNode.removeFromScene()
        
        self.puzzleNode = PuzzleNode(scene      : self.scene,
                                     puzzle     : puzzle,
                                     position   : CGPoint(x: 0, y: self.scene.size.height / 5),
                                     zPosition  : self.zPosition)
    
        self.animator.run(puzzleNode: self.puzzleNode!, type: .wiggle)
    }
    
    public func showHint() {
        self.animator.run(puzzleNode: self.puzzleNode!, type: .hint)
    }
    
    public func showSolution() {
        if self.puzzleNode!.wordNode.removed {return}
        self.animator.stop(puzzleNode: self.puzzleNode!, type: .wiggle)
        self.animator.run(puzzleNode: self.puzzleNode!, type: .solution)
    }
    
    public func checkAnswer(answer: String) -> Bool {
        let answerChecker   = AnswerChecker.getInstance()
        
        let answerIsCorrect =
            answerChecker.checkAnswer(puzzleAnswer   : self.puzzleNode!.puzzle.answer,
                                      userAnswer     : answer)
        
        switch answerIsCorrect {
        case true:
            self.animator.stop(puzzleNode: self.puzzleNode!, type: .wiggle)
            self.animator.run(puzzleNode: self.puzzleNode!, type: .success)
        case false:
            self.animator.run(puzzleNode: self.puzzleNode!, type: .wrongGuess)
        }
        
        return answerIsCorrect
    }
}
