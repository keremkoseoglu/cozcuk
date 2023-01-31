//
//  LoadPuzzleAnimation.swift
//  cozcuk
//
//  Created by Dr. Kerem Koseoglu on 30.08.2022.
//

import SpriteKit

class LoadPuzzleAnimation: PuzzleAnimation {
    static var runDuration: CGFloat {
        get {
            assert(false) // Will implement when needed
            return -1
        }
    }
    
    func run(puzzleNode: PuzzleNode, options: PuzzleAnimationOptions) {
        FeedbackManager.getInstance().questionload(scene: puzzleNode.scene)
        
        let stars = ShootingStars(scene     : puzzleNode.scene,
                                  zPosition : puzzleNode.zPosition + 1)
        
        stars.shootHorizontal(fromX     : (puzzleNode.scene.size.width / -2) - 100,
                              toX       : (puzzleNode.scene.size.width /  2) + 100,
                              midY      : puzzleNode.position.y,
                              starCount : 1)
    }
    
    func stop(puzzleNode: PuzzleNode) {}
    
    func removeFromParent() {
        // Nothing to do at this time
    }
}
