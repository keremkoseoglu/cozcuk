//
//  AnswerChecker.swift
//  cozcuk
//
//  Created by Dr. Kerem Koseoglu on 24.06.2022.
//

protocol AnswerCheckLogic {
    func checkAnswer(upperPuzzleAnswer: String, upperUserAnswer: String) -> Bool
}

class ExactAnswerCheck: AnswerCheckLogic {
    func checkAnswer(upperPuzzleAnswer: String, upperUserAnswer: String) -> Bool {
        return upperPuzzleAnswer == upperUserAnswer
    }
}

class TurkishTolerantAnswerCheck: AnswerCheckLogic {
    private static let turkishAlternatives =
        ["I": "İ",
         "İ": "I",
         "Ğ": "G",
         "Ü": "U",
         "Ş": "S",
         "Ö": "O",
         "Ç": "C"]
    
    private let stringToolkit = StringToolkit.getInstance()
    
    func checkAnswer(upperPuzzleAnswer: String, upperUserAnswer: String) -> Bool {
        var puzzlePos = -1
        for puzzleChar in upperPuzzleAnswer {
            puzzlePos += 1
            let puzzleLetter = String(puzzleChar)
            let userLetter = self.stringToolkit.substring(word  : upperUserAnswer,
                                                          from  : puzzlePos,
                                                          to    : puzzlePos)
            
            if puzzleLetter == userLetter {continue}
            
            var turkishFound = false
            for (l1, l2) in TurkishTolerantAnswerCheck.turkishAlternatives {
                turkishFound = puzzleLetter == l1 && userLetter == l2
                               ||
                               puzzleLetter == l2 && userLetter == l1
                
                if turkishFound {break}
            }
            if !turkishFound {return false}
        }
        
        return true
    }
}

class AnswerChecker {
    private static var SINGLETON: AnswerChecker?
    private var checkLogics: [AnswerCheckLogic]
    
    public static func getInstance() -> AnswerChecker {
        if AnswerChecker.SINGLETON == nil {
            AnswerChecker.SINGLETON = AnswerChecker()
        }
        return AnswerChecker.SINGLETON!
    }
    
    public func checkAnswer(puzzleAnswer: String, userAnswer: String) -> Bool {
        if puzzleAnswer.isEmpty || userAnswer.isEmpty {return false}
        if puzzleAnswer.count != userAnswer.count {return false}
        
        let upperPuzzleAnswer   = puzzleAnswer.uppercased()
        let upperUserAnswer     = userAnswer.uppercased()
        
        for checkLogic in self.checkLogics {
            if checkLogic.checkAnswer(upperPuzzleAnswer   : upperPuzzleAnswer,
                                      upperUserAnswer     : upperUserAnswer) {
                return true
            }
        }
        return false
    }
    
    private init() {
        self.checkLogics = [ExactAnswerCheck(),
                            TurkishTolerantAnswerCheck()]
    }
}
