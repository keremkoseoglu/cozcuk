//
//  PuzzleBuilder.swift
//  cozcuk
//
//  Created by Dr. Kerem Koseoglu on 13.11.2022.
//

struct SubPos {
    var begin: Int;
    var end: Int;
}

protocol HorizontalPuzzleDirection {
    func getInitialSubPos(word: String, remainWord: String) -> SubPos
    
    func shouldKeepSearching(pos: SubPos, remainWord: String) -> Bool
    
    func synNotFound(pos: inout SubPos)
    
    func synFound(pos          : inout SubPos,
                  remainWord   : inout String)
    
    func remainWordNotChanged(remainWord: inout String, elimLetter: inout String)
    
    func appendSolutionPart(solParts        : inout [PuzzleSolutionPart],
                            newSolPart      : PuzzleSolutionPart,
                            question        : inout String,
                            newQuestionPart : String)
}

class HorizontalPuzzleBuilder {
    private static var SINGLETON: HorizontalPuzzleBuilder?
    
    public static func getInstance() -> HorizontalPuzzleBuilder {
        if HorizontalPuzzleBuilder.SINGLETON == nil {
            HorizontalPuzzleBuilder.SINGLETON = HorizontalPuzzleBuilder()
        }
        return HorizontalPuzzleBuilder.SINGLETON!
    }
    
    func buildPuzzle(word: String, direction: HorizontalPuzzleDirection) throws -> Puzzle {
        let synDB       = try SynonymDatabase.getInstance()
        let strToolkit  = StringToolkit.getInstance()
        var result      = Puzzle()
        result.answer   = word
        var remainWord  = word
        
        while remainWord.count > 0 {
            var pos             = direction.getInitialSubPos(word: word, remainWord: remainWord)
            let prevRemainWord  = remainWord
            
            while direction.shouldKeepSearching(pos: pos, remainWord: remainWord) {
                let subString = strToolkit.substring(word: remainWord,
                                                     from: pos.begin,
                                                     to  : pos.end)
                
                let flexSyn = synDB.getFlexibleSynonym(word: subString)
                
                if !flexSyn.found {
                    direction.synNotFound(pos: &pos)
                    continue
                }
                
                result.built = true
                result.replacementCount += 1
                
                direction.appendSolutionPart(
                    solParts        : &result.solution.solutionParts,
                    newSolPart      : PuzzleSolutionPart(encodedWord  : flexSyn.synonym,
                                                         decodedWord  : subString,
                                                         isReversed   : flexSyn.reversed,
                                                         isPuzzled    : true),
                    question        : &result.question,
                    newQuestionPart : flexSyn.synonym)

                direction.synFound(pos: &pos, remainWord: &remainWord)
            }
            
            if prevRemainWord != remainWord {
                continue
            }
            
            var elimLetter = ""
            direction.remainWordNotChanged(remainWord: &remainWord, elimLetter: &elimLetter)
            
            direction.appendSolutionPart(
                solParts        : &result.solution.solutionParts,
                newSolPart      : PuzzleSolutionPart(encodedWord  : elimLetter,
                                                     decodedWord  : elimLetter,
                                                     isReversed   : false,
                                                     isPuzzled    : false),
                question        : &result.question,
                newQuestionPart : elimLetter)
        }
        
        return result
    }
    
    private init() {}
}
