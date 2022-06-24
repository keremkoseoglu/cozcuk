//
//  PuzzleQueueTest.swift
//  cozcuk
//
//  Created by Dr. Kerem Koseoglu on 24.06.2022.
//

import Foundation

class PuzzleQueueTest {
    private static let SIZE     : Int = 5
    private static let SAFETY   : Int = 2
    
    public func execute() {
        do {
            print("Puzzle queue test")
            let queue = try PuzzleQueue.getInstance()
            queue.dimensions = PuzzleQueueDimensions(size   : PuzzleQueueTest.SIZE,
                                                     safety : PuzzleQueueTest.SAFETY)
            
            print("Size     : \(queue.dimensions.size)")
            print("Safety   : \(queue.dimensions.safety)")
            
            print("Testing without wait")
            test(queue: queue, waitInbetween: false)
            /*print("Testing with wait")
            test(queue: queue, waitInbetween: true)*/
            
        } catch{print("Unexpected error: \(error)")}
    }
    
    private func wait() {
        let deadline = Date().advanced(by: 1)
        Thread.sleep(until: deadline)
    }
    
    private func test(queue: PuzzleQueue, waitInbetween: Bool) {
        do {
            for _ in 0...queue.dimensions.safety*4 {
                let puzzle = try queue.getNextPuzzle()
                print("Puzzle: \(puzzle.question), queue count: \(queue.queuedPuzzleCount)")
                if waitInbetween {wait()}
            }
        } catch{print("Unexpected error: \(error)")}
    }
}
