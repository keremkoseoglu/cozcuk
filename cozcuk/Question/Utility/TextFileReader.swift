//
//  TextFileReader.swift
//  cozcuk
//
//  Created by Dr. Kerem Koseoglu on 23.06.2022.
//

import Foundation

class TextFileReader {
    private static let DB_FILE_TYPE : String = "txt"
    private static let LINE_BREAK   : String = "\n"
    private static var SINGLETON    : TextFileReader?
    
    public static func getInstance() -> TextFileReader {
        if TextFileReader.SINGLETON == nil {
            TextFileReader.SINGLETON = TextFileReader()
        }
        return TextFileReader.SINGLETON!
    }
    
    public func read(fileName: String) throws -> [String] {
        let path = Bundle.main.path(forResource : fileName,
                                    ofType      : TextFileReader.DB_FILE_TYPE)!
        
        let strData = try String(contentsOfFile : path,
                                 encoding       : String.Encoding.utf8
                                ).uppercased()
        
        let strings: [String] = strData.components(separatedBy: TextFileReader.LINE_BREAK)
        
        var result = [String]()
        for str in strings {if str != "" {result.append(str)}}
        return result
    }
}
