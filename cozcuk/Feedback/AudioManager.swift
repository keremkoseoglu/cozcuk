//
//  AudioManager.swift
//  cozcuk
//
//  Created by Dr. Kerem Koseoglu on 25.08.2022.
//

import SpriteKit
import AudioToolbox

enum SoundEffect {
    case correctAnswer
    case wrongAnswer
    case questionLoad
    case keyPress
    case keyboardPress
}

class AudioManager {
    private static let DB_NAME: String = "SOUND_ON"
    private static var SINGLETON: AudioManager?
    private var _soundIsOn: Bool
    private var playRight: SKAction
    private var playSnap: SKAction
    private var playSpell: SKAction
    private var playWrong: SKAction
    
    public static func getInstance() -> AudioManager {
        if AudioManager.SINGLETON == nil {
            AudioManager.SINGLETON = AudioManager()
        }
        
        return AudioManager.SINGLETON!
    }
    
    public var soundIsOn: Bool {
        get {return self._soundIsOn}
        set (newVal) {
            self._soundIsOn = newVal
            Database.getInstance().setBool(AudioManager.DB_NAME, newVal)
        }
    }
    
    public func playSoundEffect(_ soundEffect: SoundEffect, _ scene: SKScene) {
        if !self.soundIsOn {return}
        
        switch soundEffect {
        case .correctAnswer:
            scene.run(self.playRight)
        case .wrongAnswer:
            scene.run(self.playWrong)
        case .questionLoad:
            scene.run(self.playSpell)
        case .keyPress:
            scene.run(self.playSnap)
        case .keyboardPress:
            AudioServicesPlaySystemSound(1123)
        }
    }
    
    private init() {
        self._soundIsOn = Database.getInstance().getBool(AudioManager.DB_NAME)
        self.playRight = SKAction.playSoundFileNamed("right.wav", waitForCompletion: false)
        self.playSnap = SKAction.playSoundFileNamed("snap.wav", waitForCompletion: false)
        self.playSpell = SKAction.playSoundFileNamed("spell.wav", waitForCompletion: false)
        self.playWrong = SKAction.playSoundFileNamed("wrong.wav", waitForCompletion: false)
    }
}
