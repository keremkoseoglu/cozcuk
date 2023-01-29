//
//  TutorialSceneObserver.swift
//  cozcuk
//
//  Created by Dr. Kerem Koseoglu on 10.01.2023.
//

import SpriteKit

class TutorialSceneObserver: DoubleFooterButtonsObserver {
    private var tutorialScene   : TutorialScene
    private var slideSet        : TutorialSlideSet
    
    public init(tutorialScene: TutorialScene) {
        self.tutorialScene  = tutorialScene
        self.slideSet       = TutorialSlideSet(scene: self.tutorialScene)
    }
    
    public func doubleFooterButtonClicked(_ button: DoubleFooterButton) {
        switch button {
        case .right:
            removeCurrentStep()
            loadNextStep()
        case .left:
            exitTutorial()
        }
    }
    
    public func loadFirstStep() {
        self.slideSet.rewind()
        loadNextStep()
    }
    
    private func loadNextStep() {
        if !self.slideSet.hasNextSlide {
            exitTutorial()
            return
        }
        let slide = self.slideSet.getNextSlide()
        slide.putToScene(scene: self.tutorialScene, zPosition: 9)
    }
    
    private func removeCurrentStep() {
        if !self.slideSet.hasCurrentSlide {return}
        let currentSlide = self.slideSet.getCurrentSlide()
        currentSlide.removeFromScene()
    }
    
    private func exitTutorial() {
        WelcomeScene.moveToView(self.tutorialScene.currentView!)
    }
    
    
}
