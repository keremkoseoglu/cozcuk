//
//  WordAnimator.swift
//  cozcuk
//
//  Created by Dr. Kerem Koseoglu on 14.08.2022.
//

import SpriteKit

class WordAnimator {
    private static var SINGLETON: WordAnimator?
    
    public static func getInstance() -> WordAnimator {
        if WordAnimator.SINGLETON == nil {WordAnimator.SINGLETON = WordAnimator()}
        return WordAnimator.SINGLETON!
    }
    
    public func remove(word: WordNode) {
        let animator = LetterAnimator.getInstance()
        
        for letter in word.letterNodes {
            animator.fadeAndRemove(letter: letter)
        }
    }
    
    public func fadeIn(word: WordNode) {
        let animator = LetterAnimator.getInstance()
        
        for letter in word.letterNodes {
            animator.fadeIn(letter: letter)
        }
    }
    
    public func reverse(word: WordNode) {
        reverseLetterNodes(word.letterNodes)
    }
    
    public func reverseLettersOfIndex(word: WordNode, index1: Int, index2: Int) {
        var letterNodes = [LetterNode]()
        var index       = -1
        
        for node in word.letterNodes {
            index += 1
            if index < index1 {continue}
            if index > index2 {break}
            letterNodes.append(node)
        }
        
        reverseLetterNodes(letterNodes)
    }
    
    public func rotateLettersOfIndex(word: WordNode, index1: Int, index2: Int) {
        reverseLettersOfIndex(word: word, index1: index1, index2: index2)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + LetterAnimator.shiftAndMoveHorizontalDuration) {
            self.reverseLettersOfIndex(word: word, index1: index1, index2: index2)
        }
    }
    
    private init() {}
    
    private func reverseLetterNodes(_ letters: [LetterNode]) {
        let animator        = LetterAnimator.getInstance()
        var leftIndex       = -1
        let maxLeftIndex    = letters.count / 2
        
        while true {
            leftIndex += 1
            if leftIndex > maxLeftIndex {break}
            
            let rightIndex  = letters.count - leftIndex - 1
            let leftLetter  = letters[leftIndex]
            let rightLetter = letters[rightIndex]
            let leftX       = leftLetter.position.x
            let rightX      = rightLetter.position.x
            
            animator.shiftAndMoveHorizontal(letter          : leftLetter,
                                            targetX         : rightX,
                                            firstDirection  : VerticalDirection.up)
        
            animator.shiftAndMoveHorizontal(letter          : rightLetter,
                                            targetX         : leftX,
                                            firstDirection  : VerticalDirection.down)
        }
    }
}
