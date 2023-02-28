//
//  Stats.swift
//  cozcuk
//
//  Created by Dr. Kerem Koseoglu on 27.08.2022.
//

enum StatisticType: String, CaseIterable {
    case solvedPuzzleCount      = "solvedPuzzleCount"
    case hintSolvedPuzzleCount  = "hintSolvedPuzzleCount"
    case gaveUpPuzzleCount      = "gaveUpPuzzleCount"
    case puzzleAttemptCount     = "puzzleAttemptCount"
    case hintGiveUpClickCount   = "hintGiveUpClickCount"
    case unknown                = "unknown"
    
    public var description: String {
        get {
            if self == .solvedPuzzleCount {return "Doğrudan çözülen"}
            if self == .hintSolvedPuzzleCount {return "İpucu ile çözülen"}
            if self == .gaveUpPuzzleCount {return "Pes edilen"}
            if self == .puzzleAttemptCount {return "Deneme"}
            return ""
        }
    }
    
    public var pastDescription: String {
        get {
            if self == .solvedPuzzleCount {return "soru doğrudan çözüldü"}
            if self == .hintSolvedPuzzleCount {return "soru ipucu ile çözüldü"}
            if self == .gaveUpPuzzleCount {return "soruda pes edildi"}
            if self == .puzzleAttemptCount {return "soru denendi"}
            return ""
        }
    }
    
    public var icon: String {
        get {
            if self == .solvedPuzzleCount {return "🟢"}
            if self == .hintSolvedPuzzleCount {return "🟡"}
            if self == .gaveUpPuzzleCount {return "🔴"}
            if self == .puzzleAttemptCount {return "🧩"}
            return ""
        }
    }
    
    public var persistent: Bool {
        return self == .hintGiveUpClickCount
    }
}

struct Statistic {
    var type    : StatisticType
    var value   : Int32
}

struct PuzzleSolutionFlags {
    public var hintShown    : Bool  = false
    public var puzzleSolved : Bool  = false
    public var gaveUp       : Bool  = false
    public var statsUpdated : Bool  = false
    public var playDuration : Int   = 0
    
    public var statisticType: StatisticType {
        if self.gaveUp { return StatisticType.gaveUpPuzzleCount }
        
        if self.puzzleSolved {
            if self.hintShown { return StatisticType.hintSolvedPuzzleCount }
            return StatisticType.solvedPuzzleCount
        }
        
        return StatisticType.unknown
    }
}
