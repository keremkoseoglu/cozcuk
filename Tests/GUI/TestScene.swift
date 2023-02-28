//
//  TestScene.swift
//  cozcuk
//
//  Created by Dr. Kerem Koseoglu on 13.08.2022.
//

import SpriteKit

class TestScene: SKScene, CozcukScene {
    public  var currentView     : SKView?
    
    public static func moveToView(_ view: SKView) {
        let scene = TestScene(fileNamed: "TestScene")
        scene!.currentView = view
        scene?.cozcukShowInView(view)
    }
    
    override func didMove(to view: SKView) {
        do {
            _ = GameScenery(scene: self)
            //testLetterNode()
            //testWordNode()
            // try testPuzzleNode()
            // try testPuzzleHint()
            // try testPanel()
            // try testPuzzleSolution()
            // try testReverseWord()
            // try testReverseWordPartial()
            // try testRotateWord()
            // testPushButton()
            //testShootingStar()
            //testShootingStars()
            // testInAppPurchase()
            // UserRankTest().execute()
            // AchievementTest().execute()
            // RankManagerTest().execute()
            // try testScoreBoardStars()
            // try testScoreBoardRanks()
            // try testScoreBoardCombo()
            // testRankEvaluationAnimation()
            try testPuzzleDifficulty()
            
        } catch {
            print("error")
        }
    }
    
    private func testInAppPurchase() {
        InAppPurchaseTest().execute()
    }
    
    private func testLetterNode() {
        let _ = LetterNode(scene       : self,
                           letter      : "K",
                           position    : CGPoint(x: 100, y: 100),
                           zPosition   : 3)
        
        let grey = LetterNode(scene       : self,
                              letter      : "Ç",
                              position    : CGPoint(x: 200, y: 100),
                              zPosition   : 3,
                              scale       : 0.5,
                              color       : LetterButtonColor.blue)
    
        grey.color = LetterButtonColor.pink
    }
    
    private func testWordNode() {
        let _ = WordNode(scene      : self,
                         word       : "ÇEKOSLOVAKYA",
                         position   : CGPoint(x: 0, y: -100),
                         zPosition  : 3)
        
        let pisim = WordNode(scene      : self,
                             word       : "PİSİM",
                             position   : CGPoint(x: 0, y: 100),
                             zPosition  : 3)
    
        pisim.getLetterAtIndex(2).color = LetterButtonColor.pink
        pisim.getLetterAtIndex(3).color = LetterButtonColor.violet
        
        let hayalet = WordNode(scene      : self,
                               word       : "HAYALET",
                               position   : CGPoint(x: 0, y: 300),
                               zPosition  : 3,
                               animate    : false)
    
        WordAnimator.getInstance().remove(word: hayalet)
    }
    
    private func testPuzzleNode() throws {
        let puzzle = try PuzzleQueue.getInstance().getNextPuzzle()
        
        let _ = PuzzleNode(scene       : self,
                           puzzle      : puzzle,
                           position    : CGPoint(x: 0, y: 0),
                           zPosition   : 3)
    }
    
    private func testPuzzleHint() throws {
        let puzzle = try PuzzleQueue.getInstance().getNextPuzzle()
        
        let puzzleNode = PuzzleNode(scene       : self,
                                    puzzle      : puzzle,
                                    position    : CGPoint(x: 0,
                                                          y: self.scene!.size.height / 5),
                                    zPosition   : 3)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
            PuzzleAnimator.getInstance().run(puzzleNode: puzzleNode, type: .hint)
        })
    }
    
    private func testPuzzleSolution() throws {
        // let puzzle = try PuzzleQueue.getInstance().getNextPuzzle()
        let puzzle = try PuzzleBuilderManager.getInstance().buildRandomPuzzle(word: "KEDİ")
        
        let puzzleNode = PuzzleNode(scene       : self,
                                    puzzle      : puzzle,
                                    position    : CGPoint(x: 0, y: 0),
                                    zPosition   : 3)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
            PuzzleAnimator.getInstance().run(puzzleNode: puzzleNode, type: .solution)
        })
    }
    
    private func testReverseWord() {
        let pisim = WordNode(scene      : self,
                             word       : "PİSİM",
                             position   : CGPoint(x: 0, y: 100),
                             zPosition  : 3)
    
        pisim.getLetterAtIndex(2).color = LetterButtonColor.pink
        pisim.getLetterAtIndex(3).color = LetterButtonColor.violet
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
            WordAnimator.getInstance().reverse(word: pisim)
        })
    }
    
    private func testReverseWordPartial() {
        let pisim = WordNode(scene      : self,
                             word       : "HAYALET",
                             position   : CGPoint(x: 0, y: 100),
                             zPosition  : 3)
    
        pisim.getLetterAtIndex(2).color = LetterButtonColor.pink
        pisim.getLetterAtIndex(3).color = LetterButtonColor.violet
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
            WordAnimator.getInstance().reverseLettersOfIndex(word   : pisim,
                                                             index1 : 3,
                                                             index2 : 5)
        })
    }
    
    private func testRotateWord() {
        let pisim = WordNode(scene      : self,
                             word       : "HAYALET",
                             position   : CGPoint(x: 0, y: 100),
                             zPosition  : 3)
    
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
            WordAnimator.getInstance().rotateLettersOfIndex(word   : pisim,
                                                            index1 : 3,
                                                            index2 : 5)
        })
    }
    
    private func testPanel() {
        let panel = GamePanel(scene: self, observers: nil, zPosition: 2)
        panel.clock.startTimer()
    }
    
    private func testPushButton() {
        let _ = PushButton(scene        : self,
                           shape        : PushButtonShape.big,
                           color        : PushButtonColor.blue,
                           text         : "Button 1",
                           zPosition    : 2,
                           position     : CGPoint(x: 0, y: 0))
        
        let _ = PushButton(scene            : self,
                           shape            : PushButtonShape.long,
                           color            : PushButtonColor.orange,
                           text             : "Button 2",
                           zPosition        : 2,
                           position         : CGPoint(x: 0, y: -200),
                           imageScale       : 0.5,
                           textScale        : 0.4,
                           textMarginScale  : 1.2 )
    }
    
    private func testShootingStar() {
        let star = ShootingStar(scene: self, zPosition: 3)
        star.shoot(from : CGPoint(x: 0, y: 0),
                   to   : CGPoint(x: 0, y: 300))
    }
    
    private func testShootingStars() {
        let stars = ShootingStars(scene: self, zPosition: 3)
        
        stars.shootHorizontal(fromX: -300, toX: 300, midY: 0, starCount: 3)
    }
    
    private func testScoreBoardStars() throws {
        _ = try ScoreBoard(scene: self, position: CGPoint(x: 0, y: 0))
        
        let rankManager = try RankManager.getInstance()
        rankManager.userRank.reset()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            rankManager.userRank.increaseScore(scoreToAdd: 1000)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            rankManager.userRank.increaseScore(scoreToAdd: 1000)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 7) {
            rankManager.userRank.increaseScore(scoreToAdd: 1000)
        }
    }
    
    private func testScoreBoardRanks() throws {
        _ = try ScoreBoard(scene: self, position: CGPoint(x: 0, y: 0))
        let rankManager = try RankManager.getInstance()
        rankManager.userRank.reset()
        var pos = 1
        
        while pos < 50 {
            DispatchQueue.main.asyncAfter(deadline: .now() + DispatchTimeInterval.seconds(pos)) {
                rankManager.userRank.increaseLevel()
            }
            
            pos += 1
        }
    }

    private func testScoreBoardCombo() throws {
        _ = try ScoreBoard(scene: self, position: CGPoint(x: 0, y: 0))
        
        let comboManager = ComboManager.getInstance()
        var pos = 1
        
        while pos < 3 {
            DispatchQueue.main.asyncAfter(deadline: .now() + DispatchTimeInterval.seconds(pos*2)) {
                comboManager.increase()
            }
            
            pos += 1
        }
    }
    
    private func testRankEvaluationAnimation() {
        /*
        RankEvaluationAnimator.getInstance().animateFreeStyle(
            scene       : self                  ,
            position    : CGPoint(x: 0, y: 0)   ,
            zPosition   : 99                    ,
            delay       : 0                     ,
            text        : "Çok uzun metin"      ,
            multiplier  : 3)
         */
        
        let res =
        RankEvaluationResult(
            achievements: [Achievement(name: "Test achievement", multiplier: 4),
                           Achievement(name: "Çok uzun soru", multiplier: 2)],
            combo: Combo(comboCount: 2, multiplier: 2),
            earnedScore: 10)
        
        RankEvaluationAnimator.getInstance().animateResult(
            scene       : self,
            result      : res,
            position    : CGPoint(x: 0, y: 0),
            zPosition   : 99,
            puzzle      : nil)
    }
    
    private func testPuzzleDifficulty() throws {
        let calc    = PuzzleDifficultyCalculator.getInstance()
        let queue   = try PuzzleQueue.getInstance()
        
        var puzzleCount = 0
        
        while puzzleCount < 10 {
            let puzzle      = try queue.getNextPuzzle()
            let difficulty  = try calc.calculateDifficulty(puzzle)
            
            print(puzzle.question + " - " + puzzle.answer)
            print(difficulty.competency)
            print(difficulty.level)
            print(String(difficulty.score))
            
            puzzleCount += 1
        }
    }
}
