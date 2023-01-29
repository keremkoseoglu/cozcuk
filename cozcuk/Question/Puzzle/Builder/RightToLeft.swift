//
//  RightToLeft.swift
//  cozcuk
//
//  Created by Dr. Kerem Koseoglu on 20.11.2022.
//

class RightToLeftPuzzleBuilder: PuzzleBuilder, HorizontalPuzzleDirection {
    func appendSolutionPart(solParts        : inout [PuzzleSolutionPart],
                            newSolPart      : PuzzleSolutionPart,
                            question        : inout String,
                            newQuestionPart : String) {
        question = newQuestionPart + question
        solParts.insert(newSolPart, at: 0)
    }
    
    func remainWordNotChanged(remainWord: inout String, elimLetter: inout String) {
        let strToolkit  = StringToolkit.getInstance()
        
        elimLetter = strToolkit.substring(word: remainWord,
                                          from: remainWord.count-1,
                                          to  : remainWord.count-1)
        
        if remainWord.count == 1 {
            remainWord = ""
        } else {
            remainWord = strToolkit.substring(word: remainWord,
                                              from: 0,
                                              to  : remainWord.count-2)
        }
    }
    
    func getInfinitePos() -> SubPos {
        return SubPos(begin: -9999, end: 0)
    }
    
    func synFound(pos          : inout SubPos,
                  remainWord   : inout String) {
        if pos.begin == 0 {
            remainWord = ""
        }
        else {
            let strToolkit  = StringToolkit.getInstance()
            remainWord = strToolkit.substring(word: remainWord,
                                              from: 0,
                                              to  : pos.begin-1)
        }
        
        pos.begin = -9999
        pos.end   = 0
    }
    
    func synNotFound(pos: inout SubPos) {
        pos.begin -= 1
    }
    
    func shouldKeepSearching(pos: SubPos, remainWord: String) -> Bool {
        return remainWord.count > 0 && pos.begin >= 0
    }
    
    func getInitialSubPos(word: String, remainWord: String) -> SubPos {
        var beginPos = remainWord.count - 1
        if word == remainWord {beginPos -= 1} // Don't encode full debut word
        return SubPos(begin: beginPos, end: remainWord.count - 1)
    }
    
    func buildPuzzle(word: String) throws -> Puzzle {
        return try HorizontalPuzzleBuilder.getInstance().buildPuzzle(
                        word        : word,
                        direction   : self)
    }
}
