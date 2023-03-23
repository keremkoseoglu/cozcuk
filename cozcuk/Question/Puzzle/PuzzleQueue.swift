//
//  PuzzleQueue.swift
//  cozcuk
//
//  Created by Dr. Kerem Koseoglu on 24.06.2022.
//

enum PuzzleQueueError: Error {
    case tooManyRandomWordAttempts
    case noPuzzleGenerated
}

struct PuzzleQueueDimensions {
    var size    : Int   = 30
    var safety  : Int   = 10
}

class PuzzleQueue {
    private static  let MAX_ATTEMPT             : Int       = 200
    private static  let QUEUE_LABEL             : String    = "PuzzleQueue"
    private static  var SINGLETON               : PuzzleQueue?
    public          var dimensions              : PuzzleQueueDimensions
    private         var wordDB                  : WordDatabase
    private         var encoder                 : WordEncoder
    private         var gradedPuzzles           : [PuzzleDifficultyLevel:[Puzzle]]
    private         var difficultyCalculator    : PuzzleDifficultyCalculator
    
    public static func getInstance() throws -> PuzzleQueue {
        if PuzzleQueue.SINGLETON == nil {
            PuzzleQueue.SINGLETON = try PuzzleQueue()
        }
        return PuzzleQueue.SINGLETON!
    }
    
    public func getQueuedPuzzleCount(level: PuzzleDifficultyLevel = .medium) -> Int {
        return self.gradedPuzzles[level]!.count
    }
    
    public func getNextPuzzle(level: PuzzleDifficultyLevel = .medium) throws -> Puzzle {
        var puzzleArray = self.gradedPuzzles[level]
        let nextPuzzle = try getNextPuzzleInArray(array  : &puzzleArray!,
                                                  level  : level)
        self.gradedPuzzles[level] = puzzleArray
        return nextPuzzle
    }
    
    private init() throws {
        self.wordDB         = try WordDatabase.getInstance()
        self.encoder        = WordEncoder.getInstance()
        self.dimensions     = PuzzleQueueDimensions()
        self.gradedPuzzles  = [.easy        : [Puzzle](),
                               .medium      : [Puzzle](),
                               .hard        : [Puzzle]()]
        self.difficultyCalculator = PuzzleDifficultyCalculator.getInstance()
    }
    
    private func generateRandomPuzzle(level: PuzzleDifficultyLevel?) throws -> Puzzle {
        let synonymHistory          = SynonymHistory.getInstance()
        var result                  = Puzzle()
        var attempts        : Int   = 0
        var historyCleared  : Bool  = false
        var levelMatch      : Bool  = false
        
        while !(result.built && levelMatch) {
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
                
                print("throwing too many random word attempts")
                throw PuzzleQueueError.tooManyRandomWordAttempts
            }
            
            if !result.built {continue}

            if (level == nil) {
                levelMatch = true
            } else {
                do {
                    let resultLevel = try self.difficultyCalculator.calculateDifficulty(result).level
                    levelMatch = resultLevel == level
                    
                    if !levelMatch {
                        self.gradedPuzzles[resultLevel]!.append(result)
                        synonymHistory.recordPuzzleSynonyms(result)
                    }
                }
                catch {levelMatch = false}
            }
        }
        
        synonymHistory.recordPuzzleSynonyms(result)
        return result
    }
    
    private func getNextPuzzleInArray(array: inout [Puzzle], level: PuzzleDifficultyLevel, isFallback: Bool = false) throws -> Puzzle {
        if array.count <= self.dimensions.safety {refillPuzzleArray(array   : &array,
                                                                    level   : level)}
        if array.isEmpty {
            guard !isFallback else {
                print("throwing no puzzle generated")
                throw PuzzleQueueError.noPuzzleGenerated
            }
            print("PuzzleQueue is falling back")
            return try getNextPuzzleInArray(array: &array, level: level.fallbackLevel, isFallback: true)
        }
        
        let result = array[0]
        array.remove(at: 0)
        return result
    }
    
    private func generatePuzzles(array: inout [Puzzle], count: Int, level: PuzzleDifficultyLevel) throws {
        if count <= 0 {return}
        
        for _ in 0...count-1 {
            let puzzle = try generateRandomPuzzle(level: level)
            array.append(puzzle)
        }
    }
    
    private func refillPuzzleArray(array: inout [Puzzle], level: PuzzleDifficultyLevel) {
        do {
            let missingPuzzleCount = self.dimensions.size - array.count
            if missingPuzzleCount <= 0 {return}
            try self.generatePuzzles(array  : &array,
                                     count  : missingPuzzleCount,
                                     level  : level)
        } catch {
            print("Refill puzzle array error: \(error)")
        }
    }
}
