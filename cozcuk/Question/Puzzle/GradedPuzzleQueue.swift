//
//  GradedPuzzleQueue.swift
//  cozcuk
//
//  Created by Dr. Kerem Koseoglu on 5.03.2023.
//

class GradedPuzzleQueue {
    private static  var SINGLETON   : GradedPuzzleQueue?
    
    public static func getInstance() -> GradedPuzzleQueue {
        if GradedPuzzleQueue.SINGLETON == nil {
            GradedPuzzleQueue.SINGLETON = GradedPuzzleQueue()
        }
        return GradedPuzzleQueue.SINGLETON!
    }
    
    public func getPuzzleDifficultyLevel() throws -> PuzzleDifficultyLevel {
        let userRank    = try RankManager.getInstance().userRank
        let random      = Int.random(in: 1...100)
        let difficulty  = try userRank.rank.getPuzzleDifficultyLevelForPercentage(random)
        return difficulty
    }
    
    public func getNextPuzzle() throws -> Puzzle {
        return try PuzzleQueue.getInstance().getNextPuzzle(level: self.getPuzzleDifficultyLevel())
    }
    
    private init() {}
}
