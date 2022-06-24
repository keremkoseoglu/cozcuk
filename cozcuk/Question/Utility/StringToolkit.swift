//
//  StringToolkit.swift
//  cozcuk
//
//  Created by Dr. Kerem Koseoglu on 23.06.2022.
//

class StringToolkit {
    private static var SINGLETON: StringToolkit?
    
    public static func getInstance() -> StringToolkit {
        if StringToolkit.SINGLETON == nil {StringToolkit.SINGLETON = StringToolkit()}
        return StringToolkit.SINGLETON!
    }
    
    public func substring(word: String, from: Int, to: Int) -> String {
        #warning("string toolkit defensive programming")
         let start  = word.index(word.startIndex, offsetBy: from)
         let end    = word.index(word.startIndex, offsetBy: to)
         let range  = start...end
         return String(word[range])
    }
}
