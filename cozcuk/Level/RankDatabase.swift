//
//  RankDatabase.swift
//  cozcuk
//
//  Created by Dr. Kerem Koseoglu on 11.02.2023.
//

import Foundation

class RankDatabase {
    private static let DB_FILE_NAME : String    = "rank"
    private static let LEVEL_KEY    : String    = "UserRankLevel"
    private static let SCORE_KEY    : String    = "UserRankScore"
    private static let SEPARATOR    : String    = ";"
    private static var SINGLETON    : RankDatabase?
    
    private var _ranks: [Rank]
    
    public static func getInstance() throws -> RankDatabase {
        if RankDatabase.SINGLETON == nil {
            try RankDatabase.SINGLETON = RankDatabase()
        }
        return RankDatabase.SINGLETON!
    }
    
    public var ranks: [Rank] {
        get {return self._ranks}
    }
    
    public var userRank: UserRank {
        get {
            let result = UserRank(level: UserDefaults.standard.integer(forKey: RankDatabase.LEVEL_KEY),
                                  score: UserDefaults.standard.integer(forKey: RankDatabase.SCORE_KEY),
                                  ranks: self.ranks)
            
            return result
        }
        
        set (newRank) {
            UserDefaults.standard.set(newRank.level, forKey: RankDatabase.LEVEL_KEY)
            UserDefaults.standard.set(newRank.score, forKey: RankDatabase.SCORE_KEY)
        }
    }
    
    private init() throws {
        self._ranks = [Rank]()
        try loadRanks()
    }
    
    private func loadRanks() throws {
        let txtReader = TextFileReader.getInstance()
        let strArray  = try txtReader.read(fileName: RankDatabase.DB_FILE_NAME)
        
        for pair in strArray {
            let split = pair.components(separatedBy: RankDatabase.SEPARATOR)
            var newRank = Rank(level                            : Int(split[0])!,
                               requiredScore                    : Int(split[1])!,
                               name                             : split[2],
                               puzzleDifficultyLevelPercentages : [PuzzleDifficultyLevel:Int]())
            
            newRank.puzzleDifficultyLevelPercentages[.easy]     = Int(split[3]);
            newRank.puzzleDifficultyLevelPercentages[.medium]   = Int(split[4]);
            newRank.puzzleDifficultyLevelPercentages[.hard]     = Int(split[5]);
            
            self._ranks.append(newRank)
        }
    }
    
}
