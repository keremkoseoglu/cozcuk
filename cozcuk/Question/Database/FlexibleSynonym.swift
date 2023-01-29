//
//  FlexibleSynonym.swift
//  cozcuk
//
//  Created by Dr. Kerem Koseoglu on 23.06.2022.
//

struct FlexibleSynonym {
    var synonym : String    = ""
    var reversed: Bool      = false
    var found   : Bool      = false
}

protocol FlexibleSynonymFinder {
    func find(word: String, db: SynonymDatabase) -> FlexibleSynonym
}

class StraightSynonymFinder: FlexibleSynonymFinder {
    func find(word: String, db: SynonymDatabase) -> FlexibleSynonym {
        var result      = FlexibleSynonym()
        result.synonym  = db.getSynonym(word: word)
        result.found    = result.synonym != ""
        return result
    }
}

class ReverseSynonymFinder: FlexibleSynonymFinder {
    func find(word: String, db: SynonymDatabase) -> FlexibleSynonym {
        var result      = FlexibleSynonym()
        result.synonym  = db.getSynonym(word: String(word.reversed()))
        if result.synonym != "" {
            result.synonym  = String(result.synonym.reversed())
            result.found    = true
            result.reversed = true
        }
        return result
    }
}

class FlexibleSynonymManager {
    private static var SINGLETON: FlexibleSynonymManager?
    private var finders: [FlexibleSynonymFinder]
    
    public static func getInstance() -> FlexibleSynonymManager {
        if FlexibleSynonymManager.SINGLETON == nil {
            FlexibleSynonymManager.SINGLETON = FlexibleSynonymManager()
        }
        return FlexibleSynonymManager.SINGLETON!
    }
    
    public func getRandomFlexibleSynonym(word   : String,
                                         db     : SynonymDatabase) -> FlexibleSynonym {
        self.finders.shuffle()
        var result = FlexibleSynonym()
        
        for finder in self.finders {
            result = finder.find(word: word, db: db)
            if !result.found {continue}
            if result.synonym == word {
                result.found = false
                continue
            }
            return result
        }
        
        return result
    }
    
    private init() {
        self.finders = [StraightSynonymFinder(), ReverseSynonymFinder()]
    }
}
