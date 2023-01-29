//
//  GameFullSuccessWidget.swift
//  cozcuk
//
//  Created by Dr. Kerem Koseoglu on 15.08.2022.
//

import SpriteKit

class GameFullSuccessWidget: GameInfoWidget {
    private static let ICON_IMG : String    = "Smile_Cool"
    
    override func getProps() -> GameInfoWidgetProps {
        return GameInfoWidgetProps(icon : GameFullSuccessWidget.ICON_IMG)
    }
}

class GameHintSuccessWidget: GameInfoWidget {
    private static let ICON_IMG : String    = "Smile_Normal"
    
    override func getProps() -> GameInfoWidgetProps {
        return GameInfoWidgetProps(icon : GameHintSuccessWidget.ICON_IMG)
    }
}

class GameFailWidget: GameInfoWidget {
    private static let ICON_IMG : String    = "Smile_Sad-1"
    
    override func getProps() -> GameInfoWidgetProps {
        return GameInfoWidgetProps(icon : GameFailWidget.ICON_IMG)
    }
}
