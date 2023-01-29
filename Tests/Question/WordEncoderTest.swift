//
//  WordEncoderTest.swift
//  cozcuk
//
//  Created by Dr. Kerem Koseoglu on 23.06.2022.
//

class WordEncoderTest {
    private let encoder: WordEncoder
    
    init() {
        self.encoder = WordEncoder()
    }
    
    public func execute() {
        print("Word encoder test")
        
        do {
            //try testHardCoded()
            //try testWordFile(count: 20)
            try testWordFileOnlySuccess(count: 20)
            //try testWordFileOnlyFailure(count: 20)
            
        } catch {
            print("Unexpected error: \(error).")
        }
    }
    
    private func testHardCoded() throws {
        print("Hard coded words")
        try encodeAndPrint("KALINLAŞTIRMA")
        try encodeAndPrint("EFLATUNİ")
        try encodeAndPrint("AYDEMİR")
        try encodeAndPrint("ÇATPAT")
        try encodeAndPrint("SONUÇ")
    }
    
    private func testWordFile(count: Int) throws {
        print("Word file randoms")
        let wordDB = try WordDatabase.getInstance()
        
        for _ in 0...count-1 {try encodeAndPrint(wordDB.popRandomWord())}
    }
    
    private func testWordFileOnlySuccess(count: Int) throws {
        try testWordFileOnlyBool(count: count, success: true)
    }
    
    private func testWordFileOnlyFailure(count: Int) throws {
        try testWordFileOnlyBool(count: count, success: false)
    }
    
    private func testWordFileOnlyBool(count: Int, success: Bool) throws {
        print("Word file randoms")
        let wordDB = try WordDatabase.getInstance()
        var resultCount = 0
        
        while true {
            let randomWord = wordDB.popRandomWord()
            let puzzle = try encoder.encode(word: randomWord)
            if puzzle.built != success {continue}
            printPuzzle(puzzle)
            
            resultCount += 1
            
            if resultCount >= count {return}
        }
        
        for _ in 0...count-1 {try encodeAndPrint(wordDB.popRandomWord())}
    }
    
    private func encodeAndPrint(_ word: String) throws {
        let rndPuzzle = try encoder.encode(word: word)
        printPuzzle(rndPuzzle)
    }
    
    private func printPuzzle(_ puzzle: Puzzle) {
        print("\(puzzle.question) - \(puzzle.answer) : \(puzzle.built)")
    }
}
