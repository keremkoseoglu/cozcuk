//
//  WordEncoder.swift
//  cozcuk
//
//  Created by Dr. Kerem Koseoglu on 23.06.2022.
//

class WordEncoder {
    private static var SINGLETON: WordEncoder?
    
    public static func getInstance() -> WordEncoder {
        if WordEncoder.SINGLETON == nil {WordEncoder.SINGLETON = WordEncoder()}
        return WordEncoder.SINGLETON!
    }
    
    public func encode(word: String) throws -> Puzzle {
        var result = try buildPuzzle(word: word)
        if !isPuzzleHighQuality(puzzle: result) {result.built = false}
        return result
    }
    
    private func buildPuzzle(word: String) throws -> Puzzle {
        return try PuzzleBuilderManager.getInstance().buildRandomPuzzle(word: word)
    }
    
    private func isPuzzleHighQuality(puzzle: Puzzle) -> Bool {
        if !puzzle.built {return false}
        if puzzle.question.contains(" ") {return false}
        if puzzle.question.contains("Â") {return false}
        if puzzle.answer.contains("Â") {return false}
        if puzzle.replacementCount < 2 {return false}
        if puzzle.question == puzzle.answer {return false}
        
        if SynonymHistory.getInstance().puzzleContainsRecentSynonyms(puzzle) {
            return false
        }
        
        return true
    }
    
}
