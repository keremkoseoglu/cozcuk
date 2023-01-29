//
//  WordNode.swift
//  cozcuk
//
//  Created by Dr. Kerem Koseoglu on 13.08.2022.
//

import SpriteKit

class WordNode {
    private var scene        : SKScene
    private var word         : String
    private var _letterNodes : [LetterNode]
    private var position     : CGPoint
    private var zPosition    : CGFloat
    private var letterScale  : CGFloat
    
    init(scene      : SKScene,
         word       : String,
         position   : CGPoint,
         zPosition  : CGFloat,
         animate    : Bool = true) {
        self.scene          = scene
        self.word           = word
        self._letterNodes   = [LetterNode]()
        self.position       = position
        self.zPosition      = zPosition
        self.letterScale    = 1
        
        buildLetterNodes(alpha: animate ? 0 : 1)
        if animate {WordAnimator.getInstance().fadeIn(word: self)}
    }
    
    public var letterNodes: [LetterNode] {
        get {return self._letterNodes}
    }
    
    public func getLetterAtIndex(_ index: Int) -> LetterNode {
        return self._letterNodes[index]
    }
    
    public func removeFromScene() {
        for letterNode in self.letterNodes {
            letterNode.removeFromScene()
        }
    }
    
    private func buildLetterNodes(alpha: CGFloat) {
        // Calculate
        let sampleLetterNode    = LetterNode.sampleNode
        let letterWidth         = sampleLetterNode.size.width
        let wordWidth           = letterWidth * CGFloat(self.word.count)
        self.letterScale        = self.scene.size.width / wordWidth
        let scaledWordWidth     = wordWidth * self.letterScale
        let scaledLetterWidth   = letterWidth * self.letterScale
        var letterXPos          = self.position.x - (scaledWordWidth / 2) + (scaledLetterWidth / 2)
        
        // Generate each letter
        for char in self.word {
            let letterPos = CGPoint(x: letterXPos, y: self.position.y)
            
            let letterNode = LetterNode(scene       : self.scene,
                                        letter      : String(char),
                                        position    : letterPos,
                                        zPosition   : self.zPosition,
                                        scale       : self.letterScale,
                                        alpha       : alpha)
            
            self._letterNodes.append(letterNode)
            letterXPos += scaledLetterWidth
        }
    }
}
