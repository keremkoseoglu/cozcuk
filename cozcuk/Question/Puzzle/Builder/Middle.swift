//
//  Middle.swift
//  cozcuk
//
//  Created by Dr. Kerem Koseoglu on 20.11.2022.
//

class MiddlePuzzleBuilder: PuzzleBuilder {
    private static var directions: [HorizontalPuzzleDirection] =
        [RightToLeftPuzzleBuilder(), LeftToRightPuzzleBuilder()]
    
    func buildPuzzle(word: String) throws -> Puzzle {
        let stool = StringToolkit.getInstance()
        let halfWordCount = word.count / 2
        var cutCount = halfWordCount - 1
        var preLetters = ""
        var midLetters = ""
        var sufLetters = ""
        var midPuzzle: Puzzle?
        
        while cutCount > 0  {
            preLetters = stool.substring(word: word, from: 0, to: cutCount-1)
            
            midLetters = stool.substring(word   : word,
                                         from   : cutCount,
                                         to     : word.count-1-cutCount)
            
            sufLetters = stool.substring(word   : word,
                                         from   : word.count-cutCount,
                                         to     : word.count-1)
            
            MiddlePuzzleBuilder.directions.shuffle()
            
            midPuzzle = try HorizontalPuzzleBuilder.getInstance().buildPuzzle(
                                  word        : midLetters,
                                  direction   : MiddlePuzzleBuilder.directions[0])
            
            if midPuzzle!.built {
                break
            }
            cutCount -= 1
        }
        
        var solParts = [PuzzleSolutionPart]()
        
        MiddlePuzzleBuilder.directions.shuffle()
        let prePuzzle = try HorizontalPuzzleBuilder.getInstance().buildPuzzle(
                                word        : preLetters,
                                direction   : MiddlePuzzleBuilder.directions[0])
        
        for preSolPart in prePuzzle.solution.solutionParts {solParts.append(preSolPart)}
        
        if midPuzzle != nil {
            for midSolPart in midPuzzle!.solution.solutionParts {
                solParts.append(midSolPart)
            }
        }
        
        MiddlePuzzleBuilder.directions.shuffle()
        let sufPuzzle = try HorizontalPuzzleBuilder.getInstance().buildPuzzle(
                                word        : sufLetters,
                                direction   : MiddlePuzzleBuilder.directions[0])
        
        for sufSolPart in sufPuzzle.solution.solutionParts {solParts.append(sufSolPart)}
        
        let question = prePuzzle.question + (midPuzzle?.question ?? "") + sufPuzzle.question
        
        let built = prePuzzle.built || (midPuzzle?.built ?? false) || sufPuzzle.built
        
        let repCount = prePuzzle.replacementCount +
                       (midPuzzle?.replacementCount ?? 0) +
                       sufPuzzle.replacementCount
        
        let fullPuzzle = Puzzle(question        : question,
                                answer          : word,
                                solution        : PuzzleSolution(solutionParts: solParts),
                                built           : built,
                                replacementCount: repCount)
        
        return fullPuzzle
    }
    
    
}
