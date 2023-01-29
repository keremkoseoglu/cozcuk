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
    
    public init(gameScene: GameScene) {
        self.gameScene      = gameScene
        self.puzzleLoaded   = false
        self.db             = Database.getInstance()
        self.iap            = InAppPurchaseManager.getInstance()
        self.requestReview  = RequestReviewManager.getInstance()
    }
    
    public var gamePanelObservers: GamePanelObservers {
        get {
            return GamePanelObservers(panelButton: self, keyboardButton: self)
        }
    }
    
    func gamePanelButtonClicked(_ button: GamePanelButton) {
        switch button {
        case .exitGame:
            WelcomeScene.moveToView(self.gameScene.currentView!)
            
        case .nextPuzzle:
            if !self.puzzleFlags!.puzzleSolved {self.puzzleFlags!.gaveUp = true}
            updateStats()
            PuzzleAnimator.getInstance().removeAnimationsFromParent()
            removeGarbageFromScene()
            loadNewPuzzle()
            self.gameScene.panel?.enableAnswerRelatedStuff()
            
        case .showAnswer:
            if self.puzzleFlags!.gaveUp || self.puzzleFlags!.puzzleSolved {return}
            self.db.incrementStatistic(type: .hintGiveUpClickCount)
            if self.iap.purchaseNeeded { initiateInAppPurchase() }
            if self.iap.purchaseNeeded {return}
            
            self.gameScene.panel?.disableAnswerRelatedStuff()
            self.puzzleFlags!.gaveUp = true
            self.gameScene.panel?.clock.pauseTimer()
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
        switch button {
        case .guess:
            let userAnswer      = self.gameScene.panel?.keyboard?.screenText ?? ""
            
            if userAnswer == "" {return}
            
            let animator        = PuzzleAnimator.getInstance()
            let answerCorrect   = self.gameScene.puzzleManager?.checkAnswer(answer: userAnswer)
            
            switch (answerCorrect) {
            case true:
                self.gameScene.panel?.clock.pauseTimer()
                self.gameScene.panel?.disableAnswerRelatedStuff()
                
                self.puzzleFlags!.puzzleSolved = true
                animator.run(puzzleNode : self.gameScene.puzzleManager!.puzzleNode!,
                             type       : .success)
                
                self.requestReview.userFinishedPuzzle(scene: self.gameScene)
            case false:
                animator.run(puzzleNode : self.gameScene.puzzleManager!.puzzleNode!,
                             type       : .wrongGuess)
            default:
                return
            }
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
        let db = Database.getInstance()
        db.incrementStatistic(type: StatisticType.puzzleAttemptCount)
        db.incrementStatistic(type: self.puzzleFlags!.statisticType)
    }
    
    private func removeGarbageFromScene() {
        WrongGuessPuzzleAnimation.removeAllFromScene(scene: self.gameScene)
        ToastWidget.removeToastsFromScene(scene: self.gameScene)
        SuccessPuzzleAnimation.removeFromScene(scene: self.gameScene)
    }
    
    private func initiateInAppPurchase() {
        InAppPurchasePopup(scene: self.gameScene).show()
    }

    
}
