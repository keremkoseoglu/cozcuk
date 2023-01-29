//
//  LeftToRight.swift
//  cozcuk
//
//  Created by Dr. Kerem Koseoglu on 20.11.2022.
//

class LeftToRightPuzzleBuilder: PuzzleBuilder, HorizontalPuzzleDirection {
    func appendSolutionPart(solParts        : inout [PuzzleSolutionPart],
                            newSolPart      : PuzzleSolutionPart,
                            question        : inout String,
                            newQuestionPart : String) {
        question += newQuestionPart
        solParts.append(newSolPart)
    }
    
    func remainWordNotChanged(remainWord: inout String, elimLetter: inout String) {
        let strToolkit  = StringToolkit.getInstance()
        
        elimLetter = strToolkit.substring(word: remainWord,
                                          from: 0,
                                          to  : 0)
        
        if remainWord.count == 1 {
            remainWord = ""
        } else {
            remainWord = strToolkit.substring(word: remainWord,
                                              from: 1,
                                              to  : remainWord.count-1)
        }
    }
    
    func getInfinitePos() -> SubPos {
        return SubPos(begin: 0, end: 9999)
    }
    
    func synFound(pos          : inout SubPos,
                  remainWord   : inout String) {
        if pos.end == remainWord.count - 1 {
            remainWord = ""
        }
        else {
            let strToolkit  = StringToolkit.getInstance()
            remainWord = strToolkit.substring(word: remainWord,
                                              from: pos.end+1,
                                              to  : remainWord.count-1)
        }
        
        pos.begin = 0
        pos.end   = 9999
    }
    
    func synNotFound(pos: inout SubPos) {
        pos.begin = 0
        pos.end -= 1
    }
    
    func shouldKeepSearching(pos: SubPos, remainWord: String) -> Bool {
        return pos.end >= 0 && pos.end < remainWord.count
    }
    
    func getInitialSubPos(word: String, remainWord: String) -> SubPos {
        var endPos = remainWord.count - 1
        if word == remainWord {endPos -= 1} // Don't encode full debut word
        return SubPos(begin: 0, end: endPos)
    }
    
    func buildPuzzle(word: String) throws -> Puzzle {
        return try HorizontalPuzzleBuilder.getInstance().buildPuzzle(
                        word        : word,
                        direction   : self)
    }
}
