//
//  TutorialLabeledPuzzleSlide.swift
//  cozcuk
//
//  Created by Dr. Kerem Koseoglu on 12.01.2023.
//

import SpriteKit

class TutorialLabeledPuzzleSlide: Slide, ColorSchemeObserver {
    private static var LABEL_TOP        : CGFloat = 300
    private var labelIntro              : String
    private var puzzleWord              : String
    private var puzzle                  : Puzzle?
    private var gameScenePuzzleManager  : GameScenePuzzleManager?
    private var puzzleLabel             : SKLabelNode?
    private var colorScheme             : ColorSchemeManager
    
    
    init(labelIntro: String, puzzleWord: String) {
        self.labelIntro     = labelIntro
        self.puzzleWord     = puzzleWord
        self.colorScheme    = ColorSchemeManager.getInstance()
        self.colorScheme.addObserver(self)
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
        
        self.puzzleLabel                        = SKLabelNode(text: labelText)
        self.puzzleLabel!.numberOfLines         = numberOfLines
        self.puzzleLabel!.lineBreakMode         = .byWordWrapping
        self.puzzleLabel!.position              = CGPoint(x: 0, y: labelY)
        self.puzzleLabel!.zPosition             = zPosition
        self.puzzleLabel!.verticalAlignmentMode = .bottom
        self.puzzleLabel!.fontName              = "Impact"
        self.puzzleLabel!.fontSize              = 45 * scene.cozcukScaleMax
        setPuzzleLabelColor()
        scene.addChild(self.puzzleLabel!)
    }
    
    func removeFromScene() {
        self.gameScenePuzzleManager?.puzzleNode?.wordNode.removeFromScene()
        PuzzleAnimator.getInstance().removeAnimationsFromParent()
        self.puzzleLabel?.removeFromParent()
    }
    
    public func colorSchemeChanged(uiStyle: UIUserInterfaceStyle) {
        setPuzzleLabelColor()
    }
    
    private func setPuzzleLabelColor() {
        switch self.colorScheme.userInterfaceStyle {
        case .light:
            self.puzzleLabel?.fontColor = .black
        default:
            self.puzzleLabel?.fontColor = .white
        }
    }
    
    
}
