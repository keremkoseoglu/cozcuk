//
//  PuzzleAnimator.swift
//  cozcuk
//
//  Created by Dr. Kerem Koseoglu on 14.08.2022.
//

import SpriteKit

enum PuzzleAnimationType {
    case hint
    case solution
    case success
    case wrongGuess
    case load
    case wiggle
}

struct PuzzleAnimationOption {
    public var key          : String
    public var stringValue  : String    = ""
    public var boolValue    : Bool      = false
}

struct PuzzleAnimationOptions {
    public var keyVals = [PuzzleAnimationOption]()
    
    public func getStringValue(_ key: String) -> String {
        for option in self.keyVals {
            if option.key == key {return option.stringValue}
        }
        return ""
    }
    
    public func getBoolValue(_ key: String) -> Bool {
        for option in self.keyVals {
            if option.key == key {return option.boolValue}
        }
        return false
    }
}

protocol PuzzleAnimation {
    static var runDuration: CGFloat {get}
    
    func run(puzzleNode: PuzzleNode, options: PuzzleAnimationOptions)
    func stop(puzzleNode: PuzzleNode)
    func removeFromParent()
}

struct PuzzleAnimationDict {
    public var type         : PuzzleAnimationType
    public var animation    : PuzzleAnimation
}

class PuzzleAnimator {
    private static var SINGLETON: PuzzleAnimator?
    private var animations: [PuzzleAnimationDict]
    
    public static func getInstance() -> PuzzleAnimator {
        if PuzzleAnimator.SINGLETON == nil {PuzzleAnimator.SINGLETON = PuzzleAnimator()}
        return PuzzleAnimator.SINGLETON!
    }
    
    public func run(puzzleNode  : PuzzleNode,
                    type        : PuzzleAnimationType,
                    options     : PuzzleAnimationOptions? = nil) {
        
        let animation = getAnimation(type: type)
        let passOptions = options == nil ? PuzzleAnimationOptions() : options
        
        animation.run(puzzleNode: puzzleNode,
                      options   : passOptions!)
    }

    public func stop(puzzleNode: PuzzleNode, type: PuzzleAnimationType) {
        let animation = getAnimation(type: type)
        animation.stop(puzzleNode: puzzleNode)
    }
    
    public func removeAnimationsFromParent() {
        for animation in self.animations {
            animation.animation.removeFromParent()
        }
    }
    
    private init() {
        self.animations = [PuzzleAnimationDict]()
    }
    
    private func getAnimation(type: PuzzleAnimationType) -> PuzzleAnimation {
        // Read & return from cache if possible
        for paz in self.animations {
            if paz.type == type {
                return paz.animation
            }
        }
        
        // New cache entry
        var animation: PuzzleAnimation? = nil
        
        switch type {
        case .hint          : animation = HintPuzzleAnimation()
        case .load          : animation = LoadPuzzleAnimation()
        case .solution      : animation = SolutionPuzzleAnimation()
        case .wrongGuess    : animation = WrongGuessPuzzleAnimation()
        case .success       : animation = SuccessPuzzleAnimation()
        case .wiggle        : animation = WigglePuzzleAnimation()
        }
        
        let newAnimation = PuzzleAnimationDict(type     : type,
                                               animation: animation!)
        self.animations.append(newAnimation)
        return newAnimation.animation
    }
}
