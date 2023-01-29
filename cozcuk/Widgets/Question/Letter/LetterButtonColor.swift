//
//  LetterButtonColor.swift
//  cozcuk
//
//  Created by Dr. Kerem Koseoglu on 14.08.2022.
//

import SpriteKit

enum LetterButtonColor {
    private static let BLUE_BUTTON_IMG          = "Cub_Blue"
    private static let GREY_BUTTON_IMG          = "Cub_Grey"
    private static let PINK_BUTTON_IMG          = "Cub_Pink"
    private static let VIOLET_BUTTON_IMG        = "Cub_Viol"
    private static let OVAL_BLUE_BUTTON_IMG     = "Button_Little_Blue"
    private static let OVAL_GREEN_BUTTON_IMG    = "Button_Little_Green"
    private static let OVAL_ORANGE_BUTTON_IMG   = "Button_Little_Orange"
    private static let OVAL_PINK_BUTTON_IMG     = "Button_Little_Pink"
    private static let REGULAR_COLOR_COUNT      = 4
    
    case blue
    case grey
    case pink
    case violet
    case ovalBlue
    case ovalGreen
    case ovalOrange
    case ovalPink
    
    var imageName: String {
        get {
            switch self {
            case .blue          : return LetterButtonColor.BLUE_BUTTON_IMG
            case .grey          : return LetterButtonColor.GREY_BUTTON_IMG
            case .pink          : return LetterButtonColor.PINK_BUTTON_IMG
            case .violet        : return LetterButtonColor.VIOLET_BUTTON_IMG
            case .ovalBlue      : return LetterButtonColor.OVAL_BLUE_BUTTON_IMG
            case .ovalGreen     : return LetterButtonColor.OVAL_GREEN_BUTTON_IMG
            case .ovalOrange    : return LetterButtonColor.OVAL_ORANGE_BUTTON_IMG
            case .ovalPink      : return LetterButtonColor.OVAL_PINK_BUTTON_IMG
            }
        }
    }
    
    public static func getRegularColorAtIndex(index: Int) -> LetterButtonColor {
        switch index {
        case 0  : return LetterButtonColor.blue
        case 1  : return LetterButtonColor.grey
        case 2  : return LetterButtonColor.pink
        case 3  : return LetterButtonColor.violet
        default : assert(false, "Invalid color index")
        }
    }
    
    public static func getRegularColorIndex(color: LetterButtonColor) -> Int {
        var index = 0
        
        while true {
            if getRegularColorAtIndex(index: index) == color {return index}
            index += 1
        }
    }
    
    public static func getFirstRegularColor() -> LetterButtonColor {
        return getRegularColorAtIndex(index: 0)
    }
    
    public static func getNextRegularColor(prev: LetterButtonColor) -> LetterButtonColor {
        let prevIndex = LetterButtonColor.getRegularColorIndex(color: prev)
        let nextIndex = prevIndex >= (LetterButtonColor.REGULAR_COLOR_COUNT-1) ? 0 : prevIndex + 1
        return getRegularColorAtIndex(index: nextIndex)
    }
    
    public static func getRandomRegularColor(excludes: [LetterButtonColor]) -> LetterButtonColor {
        while true {
            let randomIndex = Int.random(in: 0..<LetterButtonColor.REGULAR_COLOR_COUNT)
            let randomColor = getRegularColorAtIndex(index: randomIndex)
            var resultValid = true
            
            for excludedColor in excludes {
                if randomColor == excludedColor {
                    resultValid = false
                    break
                }
            }
            
            if resultValid {return randomColor}
        }
    }
}
