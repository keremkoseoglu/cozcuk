//
//  PuzzleNode.swift
//  cozcuk
//
//  Created by Dr. Kerem Koseoglu on 13.08.2022.
//

import SpriteKit

class PuzzleNode {
    private var _scene      : SKScene
    private var _puzzle     : Puzzle
    private var _wordNode   : WordNode
    private var _position   : CGPoint
    private var _zPosition  : CGFloat
    public  var hintShown   : Bool
    
    init(scene: SKScene, puzzle: Puzzle, position: CGPoint, zPosition: CGFloat) {
        self._scene     = scene
        self._puzzle    = puzzle
        self._position  = position
        self._zPosition = zPosition
        self.hintShown  = false
        
        self._wordNode = WordNode(scene      : self._scene,
                                  word       : self._puzzle.question,
                                  position   : self._position,
                                  zPosition  : self._zPosition,
                                  animate    : true)
    }
    
    public var wordNode: WordNode {
        get {return self._wordNode}
    }
    
    public var puzzle: Puzzle {
        get {return self._puzzle}
    }
    
    public var scene: SKScene {
        get {return self._scene}
    }
    
    public var zPosition: CGFloat {
        get {return self._zPosition}
    }
    
    public var position: CGPoint {
        get {return self._position}
    }
}
