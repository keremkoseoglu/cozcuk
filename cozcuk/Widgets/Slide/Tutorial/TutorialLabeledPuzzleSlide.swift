//
//  TutorialLabeledPuzzleSlide.swift
//  cozcuk
//
//  Created by Dr. Kerem Koseoglu on 12.01.2023.
//

import SpriteKit

class TutorialLabeledPuzzleSlide: Slide {
    private static var LABEL_TOP        : CGFloat = 300
    private var labelIntro              : String
    private var puzzleWord              : String
    private var puzzle                  : Puzzle?
    private var gameScenePuzzleManager  : GameScenePuzzleManager?
    private var puzzleLabel             : SKLabelNode?
    
    
    init(labelIntro: String, puzzleWord: String) {
        self.labelIntro = labelIntro
        self.puzzleWord = puzzleWord
    }
    
    func putToScene(scene: SKScene, zPosition: CGFloat) {
        var labelText = self.labelIntro
        var numberOfLines = 1
        
        do {
            self.puzzle = try PuzzleBuilderManager.getInstance().buildRandomPuzzle(word: self.puzzleWord)
            self.gameScenePuzzleManager = GameScenePuzzleManager(scene: scene)
            self.gameScenePuzzleManager!.loadPrebuiltPuzzle(puzzle!)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + LetterAnimator.introDuration) {
                self.gameScenePuzzleManager!.showSolution()
            }
            
            for solutionPart in self.puzzle!.solution.solutionParts {
                let solText = "\n" + solutionPart.encodedWord + " - " + solutionPart.decodedWord;
                labelText += solText
                numberOfLines += 1
            }
        }
        catch {}
        
        let labelY = TutorialLabeledPuzzleSlide.LABEL_TOP * -1 * scene.cozcukScaleY
        
        self.puzzleLabel = SKLabelNode(text: labelText)
        self.puzzleLabel!.numberOfLines = numberOfLines
        self.puzzleLabel!.lineBreakMode = .byWordWrapping
        self.puzzleLabel!.position  = CGPoint(x: 0, y: labelY)
        self.puzzleLabel!.zPosition = zPosition
        self.puzzleLabel!.verticalAlignmentMode = .bottom
        scene.addChild(self.puzzleLabel!)
    }
    
    func removeFromScene() {
        self.gameScenePuzzleManager?.puzzleNode?.wordNode.removeFromScene()
        PuzzleAnimator.getInstance().removeAnimationsFromParent()
        self.puzzleLabel?.removeFromParent()
    }
    
    
}
