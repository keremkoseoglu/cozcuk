//
//  SynonymDatabase.swift
//  cozcuk
//
//  Created by Dr. Kerem Koseoglu on 23.06.2022.
//


class SynonymDatabase {
    private static let DB_FILE_NAME                         : String    = "synonym"
    private static let SEPARATOR                            : String    = ";"
    private static let MIN_WORD_LENGTH                      : Int       = 2
    private static let SHORT_WORD_LENGTH_DIFF_TOLERANCE     : Int       = 4
    private static var SINGLETON                            : SynonymDatabase?
    
    private var synonyms: [String: [String]]
    
    public static func getInstance() throws -> SynonymDatabase {
        if SynonymDatabase.SINGLETON == nil {
            try SynonymDatabase.SINGLETON = SynonymDatabase()
        }
        return SynonymDatabase.SINGLETON!
    }
    
    public var allSynonyms: [String: [String]] {get {return self.synonyms}}
    
    public func getSynonym(word: String) -> String {
        var synonyms = self.synonyms[word.uppercased()]
        
        if synonyms == nil {return ""}
        synonyms!.shuffle()
        return synonyms![0]
    }
    
    public func getFlexibleSynonym(word: String) -> FlexibleSynonym {
        return FlexibleSynonymManager.getInstance().getRandomFlexibleSynonym(
                    word    : word,
                    db      : self)
    }
    
    private init() throws {
        self.synonyms = [:]
        try loadSynonyms()
    }
    
    private func loadSynonyms() throws {
        let txtReader = TextFileReader.getInstance()
        let strArray  = try txtReader.read(fileName: SynonymDatabase.DB_FILE_NAME)
        
        for pair in strArray {
            let split = pair.components(separatedBy: SynonymDatabase.SEPARATOR)
            if !isSynonymCollectable(word1: split[0], word2: split[1]) {continue}
            collectSynonym(word1: split[0], word2: split[1])
        }
    }
    
    private func isSynonymCollectable(word1: String, word2: String) -> Bool {
        if word1 == "" || word2 == "" {return false}
        if word1 == word2 {return false}
        if word1.count == word2.count {return true}
        
        if word1.count <= SynonymDatabase.MIN_WORD_LENGTH || word2.count <= SynonymDatabase.MIN_WORD_LENGTH {
            
            let len_diff = abs(word1.count - word2.count)
            
            if len_diff > SynonymDatabase.SHORT_WORD_LENGTH_DIFF_TOLERANCE {
                return false
            }
        }
        
        return true
    }
    
    private func collectSynonym(word1: String, word2: String) {
        collectSynonymIntoSynonyms(word1: word1, word2: word2)
        collectSynonymIntoSynonyms(word1: word2, word2: word1)
    }
    
    private func collectSynonymIntoSynonyms(word1: String, word2: String) {
        if self.synonyms[word1] == nil {self.synonyms[word1] = [String]()}
        if !self.synonyms[word1]!.contains(word2) {self.synonyms[word1]!.append(word2)}
    }
}
