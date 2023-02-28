//
//  PuzzleDifficulty.swift
//  cozcuk
//
//  Created by Dr. Kerem Koseoglu on 27.02.2023.
//

enum PuzzleDifficultyLevel: String {
    case easy       = "Kolay"
    case medium     = "Orta"
    case hard       = "Zor"
}

enum PuzzleDifficultyCompetency: String {
    case beginner       = "Başlangıç"
    case novice         = "Kolay"
    case intermediate   = "Orta"
    case advanced       = "İleri"
    case expert         = "Uzman"
}

struct PuzzleDifficulty {
    public          var score               : Int   = 0
    private static  let LEVEL_COUNT         : Int   = 3
    private static  let COMPETENCY_COUNT    : Int   = 3
    private static  var _LEVEL_WIDTH        : Int   = 0
    private static  var _COMPETENCY_WIDTH   : Int   = 0
    
    public var level: PuzzleDifficultyLevel {
        get {
            var iter    = 1
            var width   = PuzzleDifficulty.LEVEL_WIDTH
            
            while (true) {
                if self.score < width {
                    switch (iter) {
                    case 1  : return PuzzleDifficultyLevel.easy
                    case 2  : return PuzzleDifficultyLevel.medium
                    default : return PuzzleDifficultyLevel.hard
                    }
                }
                
                iter += 1
                width += width
            }
        }
    }
    
    public var competency: PuzzleDifficultyCompetency {
        get {
            var iter    = 1
            var width   = PuzzleDifficulty.COMPETENCY_WIDTH
            
            while (true) {
                if self.score < width {
                    switch (iter) {
                    case 1  : return PuzzleDifficultyCompetency.beginner
                    case 2  : return PuzzleDifficultyCompetency.novice
                    case 3  : return PuzzleDifficultyCompetency.intermediate
                    case 4  : return PuzzleDifficultyCompetency.advanced
                    default : return PuzzleDifficultyCompetency.expert
                    }
                }
                
                iter += 1
                width += width
            }
        }
    }
    
    private static var LEVEL_WIDTH: Int {
        get {
            if PuzzleDifficulty._LEVEL_WIDTH == 0 {
                do {
                    PuzzleDifficulty._LEVEL_WIDTH = try PuzzleDifficulty.calcWidth(stepCount: PuzzleDifficulty.LEVEL_COUNT)
                }
                catch {
                    print(error)
                    PuzzleDifficulty._LEVEL_WIDTH = 1
                }
            }
            
            return PuzzleDifficulty._LEVEL_WIDTH
        }
    }
    
    private static var COMPETENCY_WIDTH: Int {
        get {
            if PuzzleDifficulty._COMPETENCY_WIDTH == 0 {
                do {
                    PuzzleDifficulty._COMPETENCY_WIDTH = try PuzzleDifficulty.calcWidth(stepCount: PuzzleDifficulty.COMPETENCY_COUNT)
                }
                catch {
                    print(error)
                    PuzzleDifficulty._COMPETENCY_WIDTH = 1
                }
            }
            
            return PuzzleDifficulty._COMPETENCY_WIDTH
        }
    }
    
    private static func calcWidth(stepCount: Int) throws -> Int {
        let maxScore = try RankManager.getInstance().maxPossibleScoreWithoutCombo
        return maxScore / stepCount
    }
}

class PuzzleDifficultyCalculator {
    private static var SINGLETON                : PuzzleDifficultyCalculator?
    private static var _PUZZLE_SOLUTION_FLAGS   : PuzzleSolutionFlags?
    
    public static func getInstance() -> PuzzleDifficultyCalculator {
        if PuzzleDifficultyCalculator.SINGLETON == nil {
            PuzzleDifficultyCalculator.SINGLETON = PuzzleDifficultyCalculator()
        }
        
        return PuzzleDifficultyCalculator.SINGLETON!
    }
    
    public func calculateDifficulty(_ puzzle: Puzzle) throws -> PuzzleDifficulty {
        let rankManager = try RankManager.getInstance()
        
        var rankResult = rankManager.handlePuzzleSolution(
                            puzzle      : puzzle,
                            flags       : PuzzleDifficultyCalculator.PUZZLE_SOLUTION_FLAGS,
                            saveToDb    : false)
        
        var puzzleDifficulty = PuzzleDifficulty(score: rankResult.earnedScore)
        return puzzleDifficulty
    }
    
    private static var PUZZLE_SOLUTION_FLAGS: PuzzleSolutionFlags {
        if PuzzleDifficultyCalculator._PUZZLE_SOLUTION_FLAGS == nil {
            PuzzleDifficultyCalculator._PUZZLE_SOLUTION_FLAGS =
                PuzzleSolutionFlags(hintShown       : false ,
                                    puzzleSolved    : true  ,
                                    gaveUp          : false ,
                                    statsUpdated    : true  ,
                                    playDuration    : 1)
        }
        return PuzzleDifficultyCalculator._PUZZLE_SOLUTION_FLAGS!
    }
    
    private init() {}
}
