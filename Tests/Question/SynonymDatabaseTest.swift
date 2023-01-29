//
//  SynonymDatabaseTest.swift
//  cozcuk
//
//  Created by Dr. Kerem Koseoglu on 23.06.2022.
//

class SynonymDatabaseTest {
    private let pairs   : [String: String]
    private let rever: [String: String]
    
    init() {
        self.pairs = ["al"       : "KIRMIZI" ,
                      "kırmızı"  : "AL"      ,
                      "çatı"     : "DAM"     ,
                      "dam"      : "ÇATI"    ,
                      "AL"       : "KIRMIZI" ,
                      "KIRMIZI"  : "AL"      ,
                      "ÇATI"     : "DAM"     ,
                      "DAM"      : "ÇATI"    ]
        
        self.rever = ["la"       : "IZIMRIK" ,
                      "ızımrık"  : "LA"      ,
                      "ıtaç"     : "MAD"     ,
                      "mad"      : "ITAÇ"    ,
                      "LA"       : "IZIMRIK" ,
                      "IZIMRIK"  : "LA"      ,
                      "ITAÇ"     : "MAD"     ,
                      "MAD"      : "ITAÇ"    ]
    }
    
    public func execute() {
        print("SynonymDatabaseTest")
        
        do {
            let db = try SynonymDatabase.getInstance()
            
            print("Testing straights")
            for (word1, word2) in self.pairs {
                let answer = db.getSynonym(word: word1)
                let output: String = answer == word2 ? "OK" : "FAIL"
                print("\(word1) \(word2) \(answer) \(output)")
            }
            
            print("Testing reverses")
            for (word1, word2) in self.rever {
                let flexAnswer = db.getFlexibleSynonym(word: word1)
                print("\(word1) \(word2) \(flexAnswer.synonym) \(flexAnswer.found)")
            }
            
            
        } catch {
            print("Unexpected error: \(error).")
        }
    }
    
    public func testWord(word: String, expectedResult: String) {
        do {
            let db = try SynonymDatabase.getInstance()
            let answer = db.getSynonym(word: word)
            let output: String = answer == expectedResult ? "OK" : "FAIL"
            print(output)
        } catch {
            print("Unexpected error: \(error).")
        }
    }
}
