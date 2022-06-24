//
//  LetterJumpPlayground.swift
//  cozcuk
//
//  Created by Dr. Kerem Koseoglu on 22.06.2022.
//

import SpriteKit

class LetterJumpPlaygroundScene: SKScene {
    private static let LETTER_SPACE: CGFloat = 50
    private var labels: [SKLabelNode]?
    
    override func didMove(to view: SKView) {
        createLabels(text: "KIRMIZIADAM")
    }
    
    private func createLabels(text: String) {
        self.labels = [SKLabelNode]()
        var grow = false
        let strlen = CGFloat(text.count)
        var x = (strlen / 2) * LetterJumpPlaygroundScene.LETTER_SPACE * -1
        
        for char in text {
            self.labels!.append(createLabel(text: String(char), x: x, grow: grow))
            x += LetterJumpPlaygroundScene.LETTER_SPACE
            grow = grow ? false : true
        }
        
        for i in 0...self.labels!.count-1 {addChild(self.labels![i])}
    }
    
    private func createLabel(text   : String,
                             x      : CGFloat,
                             grow   : Bool) -> SKLabelNode {
        let result      = SKLabelNode(text: text)
        result.fontName = "Menlo"
        result.fontSize = 60
        result.position = CGPoint(x: x, y: 0)
        result.alpha    = 0
        /*
         let debutHeight         = result.yScale
        let scaleTo: CGFloat    = grow ? 0.1 : -0.1
        let act1 = SKAction.scaleY(to: debutHeight+scaleTo, duration: 0.1)
        let act2 = SKAction.scaleY(to: debutHeight-scaleTo, duration: 0.1)
        let act3 = SKAction.scaleY(to: debutHeight        , duration: 0.1)
        
        let sequence = SKAction.sequence([act1, act2, act1, act2, act1, act2, act1, act2, act3])
        result.run(SKAction.repeat(sequence, count: 1))*/
        
        let act1 = SKAction.fadeIn(withDuration: 3)
        result.run(act1)
        
        return result
    }
}
