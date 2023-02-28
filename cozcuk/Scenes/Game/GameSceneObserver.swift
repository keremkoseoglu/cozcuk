//
//  GameSceneObserver.swift
//  cozcuk
//
//  Created by Dr. Kerem Koseoglu on 22.08.2022.
//

import SpriteKit
import StoreKit

class GameSceneObserver: GamePanelButtonsObserver, KeyboardButtonsObserver {
    private var gameScene       : GameScene
    private var puzzleFlags     : PuzzleSolutionFlags?
    private var puzzleLoaded    : Bool
    private var db              : Database
    private var iap             : InAppPurchaseManager
    private var requestReview   : RequestReviewManager
    private var rankManager     : RankManager?
    
    public init(gameScene: GameScene) {
        self.gameScene      = gameScene
        self.puzzleLoaded   = false
        self.db             = Database.getInstance()
        self.iap            = InAppPurchaseManager.getInstance()
        self.requestReview  = RequestReviewManager.getInstance()
        
        do {
            self.rankManager = try RankManager.getInstance()
        } catch {print(error)}
    }
    
    public var gamePanelObservers: GamePanelObservers {
        get {
            return GamePanelObservers(panelButton: self, keyboardButton: self)
        }
    }
    
    func gamePanelButtonClicked(_ button: GamePanelButton) {
        switch button {
        case .exitGame:
            updateStats()
            WelcomeScene.moveToView(self.gameScene.currentView!)
            
        case .nextPuzzle:
            updateStats()
            PuzzleAnimator.getInstance().removeAnimationsFromParent()
            RankEvaluationResultBadgeAnimator.getInstance().removeAnimationsFromParent()
            removeGarbageFromScene()
            loadNewPuzzle()
            self.gameScene.panel?.enableAnswerRelatedStuff()
            
        case .showAnswer:
            if self.puzzleFlags!.gaveUp || self.puzzleFlags!.puzzleSolved {return}
            if self.iap.purchaseNeeded { initiateInAppPurchase() }
            if self.iap.purchaseNeeded {return}
            
            self.db.incrementStatistic(type: .hintGiveUpClickCount)
            self.puzzleFlags!.gaveUp = true
            updateStats()
            self.gameScene.panel?.clock.pauseTimer()
            
            self.gameScene.panel?.disableAnswerRelatedStuff()
            removeGarbageFromScene()
            self.gameScene.puzzleManager?.showSolution()
            self.requestReview.userFinishedPuzzle(scene: self.gameScene)

        case .showHint:
            if self.puzzleFlags!.hintShown || self.puzzleFlags!.gaveUp || self.puzzleFlags!.puzzleSolved {return}
            
            self.db.incrementStatistic(type: .hintGiveUpClickCount)
            if self.iap.purchaseNeeded { initiateInAppPurchase() }
            if self.iap.purchaseNeeded {return}
            
            self.puzzleFlags!.hintShown = true
            self.gameScene.puzzleManager?.showHint()
            
        case .toggleMusic:
            self.gameScene.panel!.buttons!.toggleMusicButton.toggle()
            AudioManager.getInstance().soundIsOn = self.gameScene.panel!.buttons!.toggleMusicButton.checked
        }
    }
    
    func keyboardButtonClicked(_ button: KeyboardButton) {
        if button != .guess {return}
        
        let userAnswer      =   self.gameScene.panel?.keyboard?.screenText ?? ""
        if  userAnswer      ==  "" {return}
        let answerCorrect   =   self.gameScene.puzzleManager?.checkAnswer(answer: userAnswer)
        
        switch (answerCorrect) {
        case true:
            handleCorrectAnswer()
        case false:
            handleWrongAnswer()
        default:
            return
        }
    }
    
    public func loadNewPuzzle() {
        self.gameScene.panel?.clock.pauseTimer()
        self.gameScene.panel?.keyboard?.screenText = ""
        self.gameScene.puzzleManager?.loadPuzzle()
        self.gameScene.panel?.clock.startTimer()
        self.puzzleFlags = PuzzleSolutionFlags()
        
        PuzzleAnimator.getInstance().run(
            puzzleNode  : self.gameScene.puzzleManager!.puzzleNode!,
            type        : .load)
        
        self.puzzleLoaded = true
    }
    
    private func updateStats() {
        if !self.puzzleLoaded {return}
        if self.puzzleFlags!.statsUpdated {return}
        
        if !self.puzzleFlags!.puzzleSolved {
            self.puzzleFlags!.gaveUp = true
            ComboManager.getInstance().reset()
        }
        
        let db = Database.getInstance()
        db.incrementStatistic(type: StatisticType.puzzleAttemptCount)
        db.incrementStatistic(type: self.puzzleFlags!.statisticType)
        self.puzzleFlags!.statsUpdated = true
    }
    
    private func removeGarbageFromScene() {
        WrongGuessPuzzleAnimation.removeAllFromScene(scene: self.gameScene)
        ToastWidget.removeToastsFromScene(scene: self.gameScene)
        SuccessPuzzleAnimation.removeFromScene(scene: self.gameScene)
    }
    
    private func initiateInAppPurchase() {
        InAppPurchasePopup(scene: self.gameScene).show()
    }
    
    private func handleCorrectAnswer() {
        ToastWidget.removeToastsFromScene(scene: self.gameScene) // Hint aldıysa
        self.gameScene.panel?.clock.pauseTimer()
        self.gameScene.panel?.disableAnswerRelatedStuff()
        
        self.puzzleFlags!.puzzleSolved  = true
        self.puzzleFlags!.playDuration  = self.gameScene.panel?.clock.elapsedSeconds ?? 0
        
        if !(self.rankManager?.userRank.isMaxLevel ?? false) {
            let rankResult = self.rankManager?.handlePuzzleSolution(
                puzzle    : self.gameScene.puzzleManager!.puzzleNode!.puzzle,
                flags     : self.puzzleFlags!)
            
            RankEvaluationAnimator.getInstance().animateResult(
                scene       : self.gameScene,
                result      : rankResult!,
                position    : CGPoint(x: 0, y: -150 * self.gameScene.cozcukScaleY),
                zPosition   : 15,
                puzzle      : self.gameScene.puzzleManager!.puzzleNode!.puzzle
            )
        }
            
        PuzzleAnimator.getInstance().run(puzzleNode : self.gameScene.puzzleManager!.puzzleNode!,
                                         type       : .success)
        
        self.requestReview.userFinishedPuzzle(scene: self.gameScene)
    }
    
    private func handleWrongAnswer() {
        PuzzleAnimator.getInstance().run(puzzleNode : self.gameScene.puzzleManager!.puzzleNode!,
                                         type       : .wrongGuess)
    }

    
}
