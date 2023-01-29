//
//  PuzzleBuilderManager.swift
//  cozcuk
//
//  Created by Dr. Kerem Koseoglu on 13.11.2022.
//

protocol PuzzleBuilder {
    func buildPuzzle(word: String) throws -> Puzzle
}

class PuzzleBuilderManager {
    private static var SINGLETON: PuzzleBuilderManager?
    private var builders: [PuzzleBuilder]
    
    public static func getInstance() -> PuzzleBuilderManager {
        if PuzzleBuilderManager.SINGLETON == nil {
            PuzzleBuilderManager.SINGLETON = PuzzleBuilderManager()
        }
        return PuzzleBuilderManager.SINGLETON!
    }
    
    public func buildRandomPuzzle(word: String) throws -> Puzzle {
        self.builders.shuffle()
        var result = Puzzle(question        : word,
                            answer          : "",
                            solution        : PuzzleSolution(),
                            built           : false,
                            replacementCount: 0)
        
        for builder in self.builders {
            result = try builder.buildPuzzle(word: word)
            if !result.built {continue}
            return result
        }
        
        return result
    }
    
    private init() {
        self.builders = [LeftToRightPuzzleBuilder(),
                         RightToLeftPuzzleBuilder(),
                         MiddlePuzzleBuilder()]
    }
}
