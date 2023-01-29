//
//  StringToolkitTest.swift
//  cozcuk
//
//  Created by Dr. Kerem Koseoglu on 23.06.2022.
//

class StringToolkitTest {
    public func execute() {
        print("String toolkit test")
        let toolkit = StringToolkit.getInstance()
        print("KEREM, 1, 2 = \(toolkit.substring(word: "KEREM", from: 1, to: 2))")
    }
}
