//
//  PuzzleQueue.swift
//  cozcuk
//
//  Created by Dr. Kerem Koseoglu on 24.06.2022.
//

#warning("kolay / orta / zor soru döndürebilecek bir destek olsun question queue içerisinde (PuzzleDifficulty.swift)") /*
tamamla
appdelegate.swift
*/

enum PuzzleQueueError: Error {
    case tooManyRandomWordAttempts
    case noPuzzleGenerated
}

struct PuzzleQueueDimensions {
    var size    : Int   = 30
    var safety  : Int   = 10
}

class PuzzleQueue {
    private static  let MAX_ATTEMPT     : Int       = 100
    private static  let QUEUE_LABEL     : String    = "PuzzleQueue"
    private static  var SINGLETON       : PuzzleQueue?
    public          var dimensions      : PuzzleQueueDimensions
    private         var wordDB          : WordDatabase
    private         var encoder         : WordEncoder
    private         var puzzles         : [Puzzle]
    //private         var competencyPuzzles   : [PuzzleDifficultyCompetency:[Puzzle]]
    
    public static func getInstance() throws -> PuzzleQueue {
        if PuzzleQueue.SINGLETON == nil {
            PuzzleQueue.SINGLETON = try PuzzleQueue()
        }
        return PuzzleQueue.SINGLETON!
    }
    
    public var queuedPuzzleCount: Int {get {return self.puzzles.count}}
    
    public func getNextPuzzle() throws -> Puzzle {
        if self.puzzles.count <= self.dimensions.safety {refillQueue()}
        if self.puzzles.isEmpty {throw PuzzleQueueError.noPuzzleGenerated}
        
        let result = self.puzzles[0]
        self.puzzles.remove(at: 0)
        return result
    }
    
    private init() throws {
        self.wordDB         = try WordDatabase.getInstance()
        self.encoder        = WordEncoder.getInstance()
        self.puzzles        = [Puzzle]()
        self.dimensions     = PuzzleQueueDimensions()
    }
    
    private func generatePuzzles(count: Int) throws {
        if count <= 0 {return}
        
        for _ in 0...count-1 {
            let puzzle = try generateRandomPuzzle()
            self.puzzles.append(puzzle)
        }
    }
    
    private func generateRandomPuzzle() throws -> Puzzle {
        let synonymHistory          = SynonymHistory.getInstance()
        var result                  = Puzzle()
        var attempts        : Int   = 0
        var historyCleared  : Bool  = false
        
        while !result.built {
            let randomWord  = self.wordDB.popRandomWord()
            result          = try self.encoder.encode(word: randomWord)
            
            attempts += 1
            if attempts > PuzzleQueue.MAX_ATTEMPT {
                if !historyCleared {
                    synonymHistory.clearHistory()
                    historyCleared = true
                    attempts = 0
                    continue
                }
                
                throw PuzzleQueueError.tooManyRandomWordAttempts
            }
        }
        
        synonymHistory.recordPuzzleSynonyms(result)
        return result
    }
    
    private func refillQueue() {
        do {
            let missingPuzzleCount = self.dimensions.size - self.puzzles.count
            if missingPuzzleCount <= 0 {return}
            try self.generatePuzzles(count: missingPuzzleCount)
        } catch {print(error)}
    }
}
