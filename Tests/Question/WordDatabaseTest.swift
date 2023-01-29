//
//  WordDatabaseTest.swift
//  cozcuk
//
//  Created by Dr. Kerem Koseoglu on 23.06.2022.
//

class WordDatabaseTest {
    func execute() {
        print("Word database test")
        
        do {
            let db      = try WordDatabase.getInstance()
            let words   = db.allWords
            
            if words.isEmpty {
                print("No words loaded")
                return
            }
            
            print("First word: \(words[0])")
            print("Fresh word count: \(db.freshWordCount)")
            print("Popped random word: \(db.popRandomWord())")
            print("Fresh word count: \(db.freshWordCount)")
            
            while db.freshWordCount > 1 {_ = db.popRandomWord()}
            print("Popping last word")
            _ = db.popRandomWord()
            print("Popping on empty word list")
            _ = db.popRandomWord()
            print("Fresh word count should be big: \(db.freshWordCount)")
            
        } catch {
            print("Unexpected error: \(error).")
        }
    }
}
