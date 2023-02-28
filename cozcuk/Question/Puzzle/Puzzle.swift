//
//  Puzzle.swift
//  cozcuk
//
//  Created by Dr. Kerem Koseoglu on 23.06.2022.
//

struct PuzzleSolutionPart {
    var encodedWord : String    = ""
    var decodedWord : String    = ""
    var isReversed  : Bool      = false
    var isPuzzled   : Bool      = false
}

struct PuzzleSolution {
    var solutionParts: [PuzzleSolutionPart] = [PuzzleSolutionPart]()
    
    public var length: Int {
        get {
            var result = 0
            for part in solutionParts {
                result += part.decodedWord.count
            }
            return result
        }
    }
}

struct Puzzle {
    var question            : String            = ""
    var answer              : String            = ""
    var solution            : PuzzleSolution    = PuzzleSolution()
    var built               : Bool              = false
    var replacementCount    : Int               = 0
    
    var reversedSolutionPartCount: Int {
        get {
            var result = 0
            
            for solutionPart in self.solution.solutionParts {
                if solutionPart.isReversed {result += 1}
            }
            
            return result
        }
    }
}
