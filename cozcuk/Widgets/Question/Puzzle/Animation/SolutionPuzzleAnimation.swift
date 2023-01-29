//
//  ShowSolutionPuzzleAnimation.swift
//  cozcuk
//
//  Created by Dr. Kerem Koseoglu on 30.08.2022.
//

import SpriteKit

class SolutionPuzzleAnimation: PuzzleAnimation {
    private static var _hintOptions : PuzzleAnimationOptions?
    private static var _solutionY   : CGFloat?
    private var solutionNode        : PuzzleNode?
    
    
    static var runDuration: CGFloat {
        get {
            assert(false) // Will implement when needed
            return -1
        }
    }
    
    public static var solutionY: CGFloat {
        get {return SolutionPuzzleAnimation._solutionY ?? 0}
    }
    
    func run(puzzleNode: PuzzleNode, options: PuzzleAnimationOptions) {
        buildSolutionNode(puzzleNode: puzzleNode)
        
        showHint(puzzleNode: puzzleNode)
        showHint(puzzleNode: self.solutionNode!)

        DispatchQueue.main.asyncAfter(
            deadline: .now() + HintPuzzleAnimation.runDuration,
            execute: {
                self.rotateReverseSolutionWords(puzzleNode: puzzleNode)
                self.rotateReverseSolutionWords(puzzleNode: self.solutionNode!)
            })
    }
    
    func stop(puzzleNode: PuzzleNode) {}
    
    func removeFromParent() {
        self.solutionNode?.wordNode.removeFromScene()
    }
    
    private static var hintOptions: PuzzleAnimationOptions {
        get {
            if SolutionPuzzleAnimation._hintOptions == nil {
                let keyVal = PuzzleAnimationOption(
                                key         : HintPuzzleOptionKey.hideLetterCount.rawValue,
                                stringValue : "",
                                boolValue   : true)
                
                SolutionPuzzleAnimation._hintOptions = PuzzleAnimationOptions(keyVals: [keyVal])
            }
            return SolutionPuzzleAnimation._hintOptions!
        }
    }
    
    private func showHint(puzzleNode: PuzzleNode) {
        PuzzleAnimator.getInstance().run(puzzleNode : puzzleNode,
                                         type       : .hint,
                                         options    : SolutionPuzzleAnimation.hintOptions)
    }
    
    private func buildSolutionNode(puzzleNode: PuzzleNode) {
        removeFromParent()
        
        var fakeParts = [PuzzleSolutionPart]()
        
        for realPart in puzzleNode.puzzle.solution.solutionParts {
            let fakePart = PuzzleSolutionPart(encodedWord   : realPart.decodedWord,
                                              decodedWord   : realPart.encodedWord,
                                              isReversed    : realPart.isReversed,
                                              isPuzzled     : realPart.isPuzzled)
            fakeParts.append(fakePart)
        }
        
        let fakeSolution = PuzzleSolution(solutionParts: fakeParts)
        
        let fakePuzzle = Puzzle(question        : puzzleNode.puzzle.answer,
                                answer          : puzzleNode.puzzle.question,
                                solution        : fakeSolution,
                                built           : puzzleNode.puzzle.built,
                                replacementCount: puzzleNode.puzzle.replacementCount)
        
        let firstButton = puzzleNode.wordNode.letterNodes[0].buttonNode
        
        SolutionPuzzleAnimation._solutionY = firstButton.position.y - (firstButton.size.height * 2)
        
        self.solutionNode = PuzzleNode(scene       : puzzleNode.scene,
                                       puzzle      : fakePuzzle,
                                       position    : CGPoint(x: 0, y: SolutionPuzzleAnimation._solutionY!),
                                       zPosition   : puzzleNode.zPosition + 1)
    }
    
    private func rotateReverseSolutionWords(puzzleNode: PuzzleNode) {
        let wordAnim = WordAnimator.getInstance()
        var cursor1: Int = 0
        var cursor2: Int = 0
        
        for realPart in puzzleNode.puzzle.solution.solutionParts {
            if realPart.isReversed {
                cursor2 = cursor1 + realPart.encodedWord.count - 1
            
                wordAnim.rotateLettersOfIndex(word     : puzzleNode.wordNode,
                                              index1   : cursor1,
                                              index2   : cursor2)
            }
            
            cursor1 += realPart.encodedWord.count
        }
    }
    
}
