//
//  WelcomeSceneObserver.swift
//  cozcuk
//
//  Created by Dr. Kerem Koseoglu on 29.08.2022.
//

import SpriteKit

class WelcomeSceneObserver: WelcomePanelButtonsObserver {
    private var welcomeScene: WelcomeScene
    
    public init(welcomeScene: WelcomeScene) {
        self.welcomeScene = welcomeScene
    }
    
    func welcomePanelButtonClicked(_ button: WelcomePanelButton) {
        switch button {
        case .startGame:
            GameScene.moveToView(self.welcomeScene.currentView!)
        case .stats:
            StatsScene.moveToView(self.welcomeScene.currentView!)
        case .tutorial:
            TutorialScene.moveToView(self.welcomeScene.currentView!)
        }
    }
    
    
}
