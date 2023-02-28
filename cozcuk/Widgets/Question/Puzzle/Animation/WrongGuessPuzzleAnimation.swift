//
//  ShowWrongGuessPuzzleAnimation.swift
//  cozcuk
//
//  Created by Dr. Kerem Koseoglu on 30.08.2022.
//

import SpriteKit

class WrongGuessPuzzleAnimation: PuzzleAnimation {
    private static var nodes: [SKNode] = [SKNode]()
    var wrongLabel: SKLabelNode?
    
    static var runDuration: CGFloat {
        get {
            assert(false) // Will implement when needed
            return -1
        }
    }
    
    static func removeAllFromScene(scene: SKScene) {
        for node in WrongGuessPuzzleAnimation.nodes {
            if node.parent != scene {continue}
            node.removeAllActions()
            node.removeFromParent()
        }
    }
    
    func run(puzzleNode: PuzzleNode, options: PuzzleAnimationOptions) {
        FeedbackManager.getInstance().wrongAnswer(scene: puzzleNode.scene)
        _ = ToastWidget(scene: puzzleNode.scene, text: "Yanlış", zPosition: 99, fadeOut: true)
        
        /*self.wrongLabel = SKLabelNode(text: "Yanlış")
        self.wrongLabel!.position = CGPoint(x: 0, y: -100 * puzzleNode.scene.cozcukScaleY) // Ekranda Hint varsa çakışmasın
        self.wrongLabel!.zPosition = 99
        self.wrongLabel!.fontColor = csm.userInterfaceStyle == .light ? .black : .white
        puzzleNode.scene.addChild(self.wrongLabel!)
        
        WrongGuessPuzzleAnimation.nodes.append(self.wrongLabel!)
        
        let fadeOut = SKAction.fadeOut(withDuration: TimeInterval(3))
        self.wrongLabel!.run(fadeOut)*/
    }
    
    func stop(puzzleNode: PuzzleNode) {}
    
    func removeFromParent() {
        self.wrongLabel?.removeAllActions()
        self.wrongLabel?.removeFromParent()
    }
    
}
