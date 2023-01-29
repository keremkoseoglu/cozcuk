//
//  AnswerCheckerTest.swift
//  cozcuk
//
//  Created by Dr. Kerem Koseoglu on 24.06.2022.
//

class AnswerCheckerTest {
    public func execute() {
        print("Answer checker test")
        check("kerem"   , "karem")
        check("kerem"   , "kerem")
        check("alaçatı" , "alacati")
        check("alacati" , "alaçatı")
        check("alaçatı" , "alecati")
    }
    
    private func check(_ puzzleAnswer: String, _ userAnswer: String) {
        let checker = AnswerChecker.getInstance()
        let result = checker.checkAnswer(puzzleAnswer: puzzleAnswer, userAnswer: userAnswer)
        print("\(puzzleAnswer) - \(userAnswer): \(result)")
    }
}
