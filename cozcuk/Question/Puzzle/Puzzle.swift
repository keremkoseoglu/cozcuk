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
}

struct Puzzle {
    var question    : String            = ""
    var answer      : String            = ""
    var solution    : PuzzleSolution    = PuzzleSolution()
    var built       : Bool              = false
}
