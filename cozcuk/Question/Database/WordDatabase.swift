//
//  WordDatabase.swift
//  cozcuk
//
//  Created by Dr. Kerem Koseoglu on 23.06.2022.
//

class WordDatabase {
    private static let DB_FILE_NAME : String = "word"
    private static var SINGLETON    : WordDatabase?
    private var allWords: [String]
    private var freshWords: [String]
    
    public static func getInstance() throws -> WordDatabase {
        if WordDatabase.SINGLETON == nil {
            try WordDatabase.SINGLETON = WordDatabase()
        }
        return WordDatabase.SINGLETON!
    }
    
    public var freshWordCount: Int {get {return freshWords.count}}
    
    public func getAllWords() -> [String] {
        return self.allWords
    }
    
    public func popRandomWord() -> String {
        if self.freshWords.isEmpty {initFreshWords()}
        let randomIndex = Int.random(in: 0..<self.freshWords.count)
        let result = self.freshWords[randomIndex]
        self.freshWords.remove(at: randomIndex)
        return result
    }
    
    private init() throws {
        self.allWords = [String]()
        self.freshWords = [String]()
        try loadWords()
        initFreshWords()
    }
    
    private func loadWords() throws {
        let txtReader = TextFileReader.getInstance()
        self.allWords    = try txtReader.read(fileName: WordDatabase.DB_FILE_NAME)
    }
    
    private func initFreshWords() {
        self.freshWords = [String]()
        for word in self.allWords {self.freshWords.append(word)}
    }
}
