//
//  GameClock.swift
//  cozcuk
//
//  Created by Dr. Kerem Koseoglu on 15.08.2022.
//

import SpriteKit

class GameClockCounter {
    public var count  : Int
    
    init() {
        self.count = 0
    }
    
    public var countAsTimeText: String {
        get {
            let minVal  : Int       = self.count / 60
            let secVal  : Int       = self.count - (minVal * 60)
            var minutes : String    = "\(minVal)"
            var seconds : String    = "\(secVal)"
            
            while minutes.count < 2 {minutes = "0\(minutes)"}
            while seconds.count < 2 {seconds = "0\(seconds)"}
            
            return "\(minutes):\(seconds)"
        }
    }
}

class GameClock: GameInfoWidget {
    private static  let CLOCK_IMG   : String    = "Time"

    private         var timer       : Timer?
    private         var counting    : Bool?
    private         var counter     : GameClockCounter?
    
    override init(scene: SKScene, position: CGPoint, zPosition: CGFloat = 1) {
        self.counting   = false
        self.counter    = GameClockCounter()
        super.init(scene: scene, position: position, zPosition: zPosition)
    }
    
    override func getProps() -> GameInfoWidgetProps {
        return GameInfoWidgetProps(icon: GameClock.CLOCK_IMG)
    }
    
    public func startTimer() {
        lazyCreateTimer()
        resetTimer()
        self.counting   = true
    }
    
    public func pauseTimer() {
        self.counting = false
    }
    
    public func resetTimer() {
        self.count = 0
    }
    
    @objc
    public func timerTicked() {
        if !(self.counting ?? false) {return}
        self.count += 1
    }
    
    private var count: Int {
        get {return self.counter!.count}
        set(newCount) {
            self.counter!.count  = newCount
            self.text           = self.counter!.countAsTimeText
        }
    }
    
    private func lazyCreateTimer() {
        if self.timer != nil {return}
        
        self.timer = Timer.scheduledTimer(timeInterval    : TimeInterval(1),
                                          target          : self,
                                          selector        : #selector(timerTicked),
                                          userInfo        : nil,
                                          repeats         : true)
    }
}
