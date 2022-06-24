//
//  WordEncoder.swift
//  cozcuk
//
//  Created by Dr. Kerem Koseoglu on 23.06.2022.
//

class WordEncoder {
    private static var SINGLETON: WordEncoder?
    
    public static func getInstance() -> WordEncoder {
        if WordEncoder.SINGLETON == nil {WordEncoder.SINGLETON = WordEncoder()}
        return WordEncoder.SINGLETON!
    }
    
    public func encode(word: String) throws -> Puzzle {
        #warning("encode")
        /*
         aşağıda soldan başlıyoruz. halbuki sağdan da başlayabiliriz.
         flexible synonym'de olduğu gibi; protokoller yapıp, random
         bir tanesiyle hareket edelim aşağıda.
         TEKİR çözülürken hep BİRİR diyor, halbuki TELEKE de gelebilmeli.
         akabinde; word encoder testlerini biraz daha yapıp gözlemleyelim.
         */
        
        let synDB       = try SynonymDatabase.getInstance()
        let strToolkit  = StringToolkit.getInstance()
        var result      = Puzzle()
        result.question = word
        var remainWord  = word
        
        while remainWord.count > 0 {
            var endPos = remainWord.count - 1
            if word == remainWord {endPos -= 1} // Don't encode full debut word
            let prevRemainWord  = remainWord
            
            while endPos >= 0 && endPos < remainWord.count {
                let subString = strToolkit.substring(word: remainWord,
                                                     from: 0,
                                                     to  : endPos)
                
                let flexSyn = synDB.getFlexibleSynonym(word: subString)
                
                if flexSyn.found {
                    result.built = true
                    result.answer += flexSyn.synonym
                    
                    result.solution.solutionParts.append(
                        PuzzleSolutionPart(encodedWord  : flexSyn.synonym,
                                           decodedWord  : subString,
                                           isReversed   : flexSyn.reversed,
                                           isPuzzled    : true))

                    if endPos == remainWord.count - 1 {
                        remainWord = ""
                    } else {
                        remainWord = strToolkit.substring(word: remainWord,
                                                          from: endPos+1,
                                                          to  : remainWord.count-1)
                    }
                    
                    endPos = 9999
                    
                } else {endPos -= 1}
            }
            
            if prevRemainWord == remainWord {
                let letter = strToolkit.substring(word: remainWord,
                                                  from: 0,
                                                  to  : 0)
                
                result.answer += letter
                
                result.solution.solutionParts.append(
                    PuzzleSolutionPart(encodedWord  : letter,
                                       decodedWord  : letter,
                                       isReversed   : false,
                                       isPuzzled    : false))
            
                if remainWord.count == 1 {
                    remainWord = ""
                } else {
                    remainWord = strToolkit.substring(word: remainWord,
                                                      from: 1,
                                                      to  : remainWord.count-1)
                }
            }
        }
        
        #warning("encoder result iyileştirme")
        /*
         result içerisinde peş peşe münferit anlamsız kelimeler varsa,
         onları birleştir
         
         mesela:
         SARIKEDİ
         SAR I K ED İ
         olarak gruplandıysa, I ve K birleşebilir
         
         I ve K'de, puzzled = False olacaktır
         */
        
        return result
    }
    
}
