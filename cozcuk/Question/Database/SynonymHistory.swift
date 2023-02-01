//
//  SynonymHistory.swift
//  cozcuk
//
//  Created by Dr. Kerem Koseoglu on 1.02.2023.
//

class SynonymHistory: SynonymHistoryState {
    private static  var SINGLETON   : SynonymHistory?
    private         var state       : SynonymHistoryState
    private         var activeState : SynonymHistoryActiveState
    private         var passiveState: SynonymHistoryPassiveState
    private         var _active     : Bool
    
    public static func getInstance() -> SynonymHistory {
        if SynonymHistory.SINGLETON == nil {SynonymHistory.SINGLETON = SynonymHistory()}
        return SynonymHistory.SINGLETON!
    }
    
    public var active: Bool {
        get {return self._active}
        set (newVal) {
            if newVal {
                self.state      = self.activeState
                self._active    = true
            }
            else {
                self.state      = self.passiveState
                self._active    = false
            }
        }
    }
    
    public func puzzleContainsRecentSynonyms(_ puzzle: Puzzle) -> Bool {
        return self.state.puzzleContainsRecentSynonyms(puzzle)
    }
    
    public func recordPuzzleSynonyms(_ puzzle: Puzzle) {
        self.state.recordPuzzleSynonyms(puzzle)
    }
    
    public func clearHistory() {
        self.state.clearHistory()
    }
    
    private init() {
        self.activeState    = SynonymHistoryActiveState()
        self.passiveState   = SynonymHistoryPassiveState()
        self.state          = self.activeState
        self._active        = true
    }
}

protocol SynonymHistoryState {
    func puzzleContainsRecentSynonyms(_ puzzle: Puzzle) -> Bool
    func recordPuzzleSynonyms(_ puzzle: Puzzle)
    func clearHistory()
}

class SynonymHistoryActiveState: SynonymHistoryState {
    private static  let DB_NAME     : String = "SynonymHistory"
    private static  let MAX_HISTORY : Int   = 100
    private         var db          : Database
    
    public init() {
        self.db = Database.getInstance()
    }
    
    public func puzzleContainsRecentSynonyms(_ puzzle: Puzzle) -> Bool {
        let recentSynonyms = self.db.getStringArray(SynonymHistoryActiveState.DB_NAME)
        
        for recentSynonym in recentSynonyms {
            for sp in puzzle.solution.solutionParts {
                if sp.decodedWord == recentSynonym || sp.encodedWord == recentSynonym {return true}
            }
        }
        
        return false
    }
    
    public func recordPuzzleSynonyms(_ puzzle: Puzzle) {
        var recentSynonyms = self.db.getStringArray(SynonymHistoryActiveState.DB_NAME)
        
        for sp in puzzle.solution.solutionParts {
            recentSynonyms.append(sp.encodedWord)
            recentSynonyms.append(sp.decodedWord)
        }
        
        while recentSynonyms.count > SynonymHistoryActiveState.MAX_HISTORY {
            recentSynonyms.remove(at: 0)
        }
        
        self.db.setStringArray(SynonymHistoryActiveState.DB_NAME, value: recentSynonyms)
    }
    
    public func clearHistory() {
        self.db.setStringArray(SynonymHistoryActiveState.DB_NAME, value: [String]())
    }
    
    
}

class SynonymHistoryPassiveState: SynonymHistoryState {
    func puzzleContainsRecentSynonyms(_ puzzle: Puzzle) -> Bool {
        return false
    }
    
    func recordPuzzleSynonyms(_ puzzle: Puzzle) {
        return
    }
    
    public func clearHistory() {
        return
    }
    
}
