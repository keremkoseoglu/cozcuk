//
//  ComboManager.swift
//  cozcuk
//
//  Created by Dr. Kerem Koseoglu on 12.02.2023.
//

struct Combo {
    var comboCount: Int = 0
    var multiplier: Int = 0
}

protocol ComboObserver {
    func comboChanged(newCombo: Combo)
}

class ComboManager {
    public  static  let MAX_COMBO   : Int = 5
    private static  var SINGLETON   : ComboManager?
    private         var _combo      : Combo
    private         var observers   : [ComboObserver]
    
    public static func getInstance() -> ComboManager {
        if ComboManager.SINGLETON == nil {
            self.SINGLETON = ComboManager()
        }
        return self.SINGLETON!
    }
    
    public var combo: Combo {
        get {return self._combo}
    }
    
    public func reset() {
        self._combo.comboCount = 0
        self._combo.multiplier = 0
        notifyObservers()
    }
    
    public func handlePuzzleSolution(flags: PuzzleSolutionFlags) {
        switch flags.puzzleSolved {
        case true:
            increase()
        case false:
            reset()
        }
    }
    
    public func registerObserver(_ observer: ComboObserver) {
        self.observers.append(observer)
    }
    
    public func increase() {
        if self._combo.comboCount >= ComboManager.MAX_COMBO {return}
        self._combo.comboCount += 1
        self._combo.multiplier += 1
        notifyObservers()
    }
    
    private init() {
        self._combo     = Combo()
        self.observers  = [ComboObserver]()
    }
    
    private func notifyObservers() {
        for observer in observers {
            observer.comboChanged(newCombo: self._combo)
        }
    }
    
}
