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
    
    public var fallbackLevel: PuzzleDifficultyLevel {
        switch self {
        case .medium: return .easy
        default: return .medium
        }
    }
}

enum PuzzleDifficultyCompetency: String {
    case beginner       = "Başlangıç"
    case novice         = "Kolay"
    case intermediate   = "Orta"
    case advanced       = "İleri"
    case expert         = "Uzman"
}

struct PuzzleDifficulty {
    public          var questionRelatedAchievementMultiplierSum     : Int   = 0
    private static  let LEVEL_COUNT                                 : Int   = 3
    private static  let COMPETENCY_COUNT                            : Int   = 5
    private static  var _levelMultiplierStep                        : Int   = 0
    private static  var _competencyMultiplierStep                   : Int   = 0
    private static  var _questionRelatedMultiplierSum               : Int   = 0
    
    public var level: PuzzleDifficultyLevel {
        get {
            var multiplierCursor    = PuzzleDifficulty.questionRelatedMultiplierSum
            var iter                = 1
            
            while (true) {
                multiplierCursor -= PuzzleDifficulty.levelMultiplierStep
                
                if self.questionRelatedAchievementMultiplierSum > multiplierCursor {
                    switch (iter) {
                    case 1  : return PuzzleDifficultyLevel.hard
                    case 2  : return PuzzleDifficultyLevel.medium
                    default : return PuzzleDifficultyLevel.easy
                    }
                }
                
                iter += 1
                if iter > PuzzleDifficulty.LEVEL_COUNT {return PuzzleDifficultyLevel.easy}
            }
        }
    }
    
    public var competency: PuzzleDifficultyCompetency {
        get {
            var multiplierCursor    = PuzzleDifficulty.questionRelatedMultiplierSum
            let multiplierStep      = multiplierCursor / PuzzleDifficulty.LEVEL_COUNT
            var iter                = 1
            
            while (true) {
                multiplierCursor -= multiplierStep
                
                if self.questionRelatedAchievementMultiplierSum > multiplierCursor {
                    switch (iter) {
                    case 1  : return PuzzleDifficultyCompetency.expert
                    case 2  : return PuzzleDifficultyCompetency.advanced
                    case 3  : return PuzzleDifficultyCompetency.intermediate
                    case 4  : return PuzzleDifficultyCompetency.novice
                    default : return PuzzleDifficultyCompetency.beginner
                    }
                }
                
                iter += 1
                if iter > PuzzleDifficulty.COMPETENCY_COUNT {return PuzzleDifficultyCompetency.beginner}
            }
        }
    }
    
    private static var levelMultiplierStep: Int {
        get {
            if PuzzleDifficulty._levelMultiplierStep == 0 {
                let multiplierCursor        = PuzzleDifficulty.questionRelatedMultiplierSum
                self._levelMultiplierStep   = multiplierCursor / PuzzleDifficulty.LEVEL_COUNT
            }
            return PuzzleDifficulty._levelMultiplierStep
        }
    }
    
    private static var competencyMultiplierStep: Int {
        get {
            if PuzzleDifficulty._competencyMultiplierStep == 0 {
                let multiplierCursor            = PuzzleDifficulty.questionRelatedMultiplierSum
                self._competencyMultiplierStep  = multiplierCursor / PuzzleDifficulty.COMPETENCY_COUNT
            }
            return PuzzleDifficulty._competencyMultiplierStep
        }
    }
    
    private static var questionRelatedMultiplierSum: Int {
        get {
            if PuzzleDifficulty._questionRelatedMultiplierSum == 0 {
                PuzzleDifficulty._questionRelatedMultiplierSum = AchievementManager.getInstance().questionRelatedMultiplerSum
            }
            return PuzzleDifficulty._questionRelatedMultiplierSum
        }
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
        
        let rankResult = rankManager.handlePuzzleSolution(
                            puzzle      : puzzle,
                            flags       : PuzzleDifficultyCalculator.PUZZLE_SOLUTION_FLAGS,
                            calcOnly    : true)
        
        let puzzleDifficulty = PuzzleDifficulty(questionRelatedAchievementMultiplierSum: rankResult.questionRelatedMultiplierSum)
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
