//
//  SynonymDatabase.swift
//  cozcuk
//
//  Created by Dr. Kerem Koseoglu on 23.06.2022.
//


class SynonymDatabase {
    private static let DB_FILE_NAME : String = "synonym"
    private static let SEPARATOR    : String = ";"
    private static var SINGLETON    : SynonymDatabase?
    
    private var synonyms: [String: String]
    
    public static func getInstance() throws -> SynonymDatabase {
        if SynonymDatabase.SINGLETON == nil {
            try SynonymDatabase.SINGLETON = SynonymDatabase()
        }
        return SynonymDatabase.SINGLETON!
    }
    
    public var allSynonyms: [String: String] {get {return self.synonyms}}
    
    public func getSynonym(word: String) -> String {
        let synonym = self.synonyms[word.uppercased()]
        let result: String = synonym == nil ? "" : synonym!
        return result
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
            collectSynonym(word1: split[0], word2: split[1])
        }
    }
    
    private func collectSynonym(word1: String, word2: String) {
        #warning("collect synonym")
        /*
         iyelik eklerini de dene; TELE -> KABLOYA, yumuşamalara dikkat İTE KÖPEĞE
         başka başka stratejiler için todo eklenebilir
         ama nasıl ayıracağız? YAPIŞ - YAPIŞTAN gibi anlamsız şeylere varmayalım?
         */
        
        if self.synonyms[word1] == nil {self.synonyms[word1] = word2}
        if self.synonyms[word2] == nil {self.synonyms[word2] = word1}
    }
}
