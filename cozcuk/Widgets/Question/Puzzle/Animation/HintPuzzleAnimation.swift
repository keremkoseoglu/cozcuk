//
//  ShowHintAnimation.swift
//  cozcuk
//
//  Created by Dr. Kerem Koseoglu on 30.08.2022.
//


import SpriteKit

enum HintPuzzleOptionKey: String {
    case hideLetterCount    = "hideLetterCount"
}

class HintPuzzleAnimation: PuzzleAnimation {
    private var puzzleNode: PuzzleNode?
    
    static var runDuration: CGFloat {
        get {
            return LetterAnimator.fadeToColorAndShiftVerticalDuration
                 + LetterAnimator.shiftAndMoveHorizontalDuration
        }
    }
    
    func run(puzzleNode: PuzzleNode, options: PuzzleAnimationOptions) {
        self.puzzleNode = puzzleNode
        if self.puzzleNode!.hintShown {return}
        self.puzzleNode!.hintShown = true
        
        animateLetters()
        
        if !options.getBoolValue(HintPuzzleOptionKey.hideLetterCount.rawValue) {
            showLetterCount()
        }
    }
    
    func stop(puzzleNode: PuzzleNode) {}
    
    func removeFromParent() {
        self.puzzleNode?.wordNode.removeFromScene()
    }
    
    private func animateLetters() {
        let animator        = LetterAnimator.getInstance()
        var charPos         = -1
        var prevWordColor   = LetterButtonColor.getRegularColorAtIndex(index: 0)
        var direction       = VerticalDirection.up
        
        // ABCDEF -> ABC, DEF
        for solutionPart in self.puzzleNode!.puzzle.solution.solutionParts {
            let partColor   = LetterButtonColor.getNextRegularColor(prev: prevWordColor)
            prevWordColor   = partColor // For next iteration
            direction       = direction == VerticalDirection.up ?
                                VerticalDirection.down :
                                VerticalDirection.up
            
            // ABC -> A, B, C
            for _ in solutionPart.encodedWord {
                charPos += 1
                let letter = self.puzzleNode!.wordNode.getLetterAtIndex(charPos)

                animator.fadeToColorAndShiftVertical(
                    letter          : letter,
                    newColor        : partColor,
                    direction       : direction,
                    preDelayIndex   : charPos)
            }
        }
    }
    
    private func showLetterCount() {
        let _ = ToastWidget(scene       : self.puzzleNode!.scene,
                            text        : "\(self.puzzleNode!.puzzle.solution.length) harf",
                            zPosition   : self.puzzleNode!.zPosition + 1,
                            fadeOut     : false)
    }
}
