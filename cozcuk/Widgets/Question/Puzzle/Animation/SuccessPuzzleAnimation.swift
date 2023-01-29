//
//  ShowSuccessPuzzleAnimator.swift
//  cozcuk
//
//  Created by Dr. Kerem Koseoglu on 30.08.2022.
//

import SpriteKit

class SuccessPuzzleAnimation: PuzzleAnimation {
    private static var nodes: [SKNode] = [SKNode]()
    private var bravoLabel: SKLabelNode?
    private var stars: ShootingStars?
    
    static var runDuration: CGFloat {
        get {
            assert(false) // Will implement when needed
            return -1
        }
    }
    
    public static func removeFromScene(scene: SKScene) {
        for node in SuccessPuzzleAnimation.nodes {
            if node.parent != scene {continue}
            node.removeAllActions()
            node.removeFromParent()
        }
    }
    
    func run(puzzleNode: PuzzleNode, options: PuzzleAnimationOptions) {
        // Cevabı göster
        PuzzleAnimator.getInstance().run(puzzleNode: puzzleNode, type: .solution)
        FeedbackManager.getInstance().correctAnswer(scene: puzzleNode.scene)
        
        
        // Yıldızlar
        self.stars = ShootingStars(scene: puzzleNode.scene, zPosition: puzzleNode.zPosition + 1)
        
        self.stars!.shootHorizontalRandom(fromX   : puzzleNode.scene.size.width / -2,
                                          toX     : puzzleNode.scene.size.width / 2,
                                          midY    : SolutionPuzzleAnimation.solutionY)
        
        // Bravo
        self.bravoLabel = SKLabelNode(text: "Bravo!")
        self.bravoLabel!.position = CGPoint(x: 0, y: 0)
        self.bravoLabel!.zPosition = 99
        puzzleNode.scene.addChild(self.bravoLabel!)
        SuccessPuzzleAnimation.nodes.append(self.bravoLabel!)
        
        let fadeOut = SKAction.fadeOut(withDuration: TimeInterval(3))
        self.bravoLabel!.run(fadeOut)
    }

    
    func stop(puzzleNode: PuzzleNode) {}
    
    func removeFromParent() {
        // Solution animation başka yerde gönderiliyor ekrandan
        self.stars?.removeFromParent()
        self.bravoLabel?.removeFromParent()
    }
}
