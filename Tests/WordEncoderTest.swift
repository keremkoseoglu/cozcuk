//
//  WordEncoderTest.swift
//  cozcuk
//
//  Created by Dr. Kerem Koseoglu on 23.06.2022.
//

class WordEncoderTest {
    public func execute() {
        print("Word encoder test")
        
        do {
            let encoder = WordEncoder()
            
            print("Hard coded words")
            var puzzle = try encoder.encode(word: "TEKİR")
            print("TEKİR - \(puzzle.answer)")
            puzzle = try encoder.encode(word: "TEKE")
            print("TEKE - \(puzzle.answer)")
            
            print("Word file randoms")
            let wordDB = try WordDatabase.getInstance()
            
            for _ in 0...3 {
                let randomWord = wordDB.popRandomWord()
                let rndPuzzle = try encoder.encode(word: randomWord)
                print("\(randomWord) - \(rndPuzzle.answer)")
            }
            
        } catch {
            print("Unexpected error: \(error).")
        }
    }
}
