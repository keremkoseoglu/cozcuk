//
//  AchievementManager.swift
//  cozcuk
//
//  Created by Dr. Kerem Koseoglu on 9.02.2023.
//

struct Achievement {
    var name                : String
    var multiplier          : Int = 2
    var questionRelated     : Bool
}

protocol AchievementGenerator {
    var maxMultiplier       : Int {get}
    var questionRelated     : Bool {get}
    func generateAchievements(puzzle: Puzzle, flags: PuzzleSolutionFlags) -> [Achievement]
}

class AchievementManager: AchievementGenerator {
    public          var maxMultiplier                    : Int
    public          var questionRelated                  : Bool
    private static  var SINGLETON                        : AchievementManager?
    private         var generators                       : [AchievementGenerator]
    private         var _questionRelatedMultiplierSum    : Int

    
    public static func getInstance() -> AchievementManager {
        if AchievementManager.SINGLETON == nil {
            self.SINGLETON = AchievementManager()
        }
        return self.SINGLETON!
    }
    
    public var questionRelatedMultiplerSum: Int {
        get {
            if self._questionRelatedMultiplierSum == 0 {
                for generator in generators {
                    guard generator.questionRelated else {continue}
                    self._questionRelatedMultiplierSum += generator.maxMultiplier
                }
            }
            return self._questionRelatedMultiplierSum
        }
    }
    
    public func generateAchievements(puzzle: Puzzle, flags: PuzzleSolutionFlags) -> [Achievement] {
        var result = [Achievement]()
        
        for generator in generators {
            let genAchievements = generator.generateAchievements(puzzle: puzzle, flags: flags)
            for genAchievement in genAchievements {result.append(genAchievement)}
        }

        return result
    }
    
    private init() {
        self.generators = [LongQuestionAchievement()        ,
                           ManyEncodedWordsAchievement()    ,
                           ManyReverseWordsAchievement()    ,
                           FastSolutionAchievement()]
        
        self.maxMultiplier = 1
        for generator in self.generators {
            self.maxMultiplier = self.maxMultiplier * generator.maxMultiplier
        }
        
        self.questionRelated = false
        self._questionRelatedMultiplierSum = 0
    }
}

class LongQuestionAchievement: AchievementGenerator {
    private static  let minMultiplier       : Int   = 2
    private static  let midMultiplier       : Int   = 3
    public          var maxMultiplier       : Int   = 4
    public          var questionRelated   : Bool  = true
    
    func generateAchievements(puzzle: Puzzle, flags: PuzzleSolutionFlags) -> [Achievement] {
        var result = [Achievement]()
        
        if puzzle.question.count >= 19 {
            result.append(Achievement(name              : "Upuzun soru",
                                      multiplier        : self.maxMultiplier,
                                      questionRelated   : self.questionRelated))
        } else if puzzle.question.count >= 15 {
            result.append(Achievement(name              : "Çok uzun soru",
                                      multiplier        : LongQuestionAchievement.midMultiplier,
                                      questionRelated   : self.questionRelated))
        } else if puzzle.question.count >= 11 {
            result.append(Achievement(name              : "Uzun soru",
                                      multiplier        : LongQuestionAchievement.minMultiplier,
                                      questionRelated   : self.questionRelated))
        }

        return result
    }
}

class ManyEncodedWordsAchievement: AchievementGenerator {
    private static  let minMultiplier       : Int   = 2
    private static  let midMultiplier       : Int   = 3
    public          var maxMultiplier       : Int   = 4
    public          var questionRelated   : Bool  = true
    
    func generateAchievements(puzzle: Puzzle, flags: PuzzleSolutionFlags) -> [Achievement] {
        var result = [Achievement]()
        
        if puzzle.solution.solutionParts.count >= 6 {
            result.append(Achievement(name              : "Paramparça soru",
                                      multiplier        : self.maxMultiplier,
                                      questionRelated   : self.questionRelated))
        } else if puzzle.solution.solutionParts.count >= 5 {
            result.append(Achievement(name              : "Çok parçalı soru",
                                      multiplier        : ManyEncodedWordsAchievement.midMultiplier,
                                      questionRelated   : self.questionRelated))
        } else if puzzle.solution.solutionParts.count >= 4 {
            result.append(Achievement(name              : "Parçalı soru",
                                      multiplier        : ManyEncodedWordsAchievement.minMultiplier,
                                      questionRelated   : self.questionRelated))
        }
        
        return result
    }
}

class ManyReverseWordsAchievement: AchievementGenerator {
    private static  let minMultiplier       : Int   = 2
    private static  let midMultiplier       : Int   = 3
    public          var maxMultiplier       : Int   = 4
    public          var questionRelated   : Bool  = true
    
    func generateAchievements(puzzle: Puzzle, flags: PuzzleSolutionFlags) -> [Achievement] {
        var result = [Achievement]()
        
        if puzzle.reversedSolutionPartCount >= 4 {
            result.append(Achievement(name              : "Ters köşe soru",
                                      multiplier        : self.maxMultiplier,
                                      questionRelated   : self.questionRelated))
        } else if puzzle.reversedSolutionPartCount >= 3 {
            result.append(Achievement(name              : "Çok ters soru",
                                      multiplier        : ManyReverseWordsAchievement.midMultiplier,
                                      questionRelated   : self.questionRelated))
        } else if puzzle.reversedSolutionPartCount >= 2 {
            result.append(Achievement(name              : "Ters soru",
                                      multiplier        : ManyReverseWordsAchievement.minMultiplier,
                                      questionRelated   : self.questionRelated))
        }
            
        return result
    }
}

class FastSolutionAchievement: AchievementGenerator {
    private static  let minMultiplier       : Int   = 2
    private static  let midMultiplier       : Int   = 3
    public          var maxMultiplier       : Int   = 4
    public          var questionRelated   : Bool  = false
    
    func generateAchievements(puzzle: Puzzle, flags: PuzzleSolutionFlags) -> [Achievement] {
        var result = [Achievement]()
        
        if flags.playDuration > 0 {
            if flags.playDuration <= 10 {
                result.append(Achievement(name              : "Yıldırım çözüm",
                                          multiplier        : self.maxMultiplier,
                                          questionRelated   : self.questionRelated))
            } else if flags.playDuration <= 20 {
                result.append(Achievement(name              : "Çok hızlı çözüm",
                                          multiplier        : FastSolutionAchievement.midMultiplier,
                                          questionRelated   : self.questionRelated))
            } else if flags.playDuration <= 30 {
                result.append(Achievement(name              : "Hızlı çözüm",
                                          multiplier        : FastSolutionAchievement.minMultiplier,
                                          questionRelated   : self.questionRelated))
            }
        }

        return result
    }
}
