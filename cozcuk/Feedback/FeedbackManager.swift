//
//  FeedbackManager.swift
//  cozcuk
//
//  Created by Dr. Kerem Koseoglu on 15.10.2022.
//

import SpriteKit

class FeedbackManager {
    private static var SINGLETON: FeedbackManager?
    private var audio: AudioManager
    private var haptics: HapticsManager
    
    public static func getInstance() -> FeedbackManager {
        if FeedbackManager.SINGLETON == nil {
            FeedbackManager.SINGLETON = FeedbackManager()
        }
        return FeedbackManager.SINGLETON!
    }
    
    public func correctAnswer(scene: SKScene) {
        self.audio.playSoundEffect(.correctAnswer, scene)
        self.haptics.success()
    }
    
    public func wrongAnswer(scene: SKScene) {
        self.audio.playSoundEffect(.wrongAnswer, scene)
        self.haptics.error()
    }
    
    public func questionload(scene: SKScene) {
        self.audio.playSoundEffect(.questionLoad, scene)
    }
    
    public func keyPress(scene: SKScene) {
        self.audio.playSoundEffect(.keyPress, scene)
        self.haptics.selection()
    }
    
    public func keyboardPress(scene: SKScene) {
        self.audio.playSoundEffect(.keyboardPress, scene)
    }
    
    private init() {
        self.audio = AudioManager.getInstance()
        self.haptics = HapticsManager.getInstance()
    }
}
