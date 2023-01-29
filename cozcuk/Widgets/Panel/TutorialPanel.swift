//
//  TutorialPanel.swift
//  cozcuk
//
//  Created by Dr. Kerem Koseoglu on 10.01.2023.
//

import SpriteKit

class TutorialPanel {
    public  var buttons     : DoubleFooterButtons?
    private var scene       : SKScene
    private var observer    : DoubleFooterButtonsObserver?
    
    init(scene: SKScene, observer: DoubleFooterButtonsObserver?, zPosition: CGFloat = 1) {
        self.scene      = scene
        self.observer   = observer
        
        self.buttons    =
            DoubleFooterButtons(scene    : self.scene,
                                zPosition: zPosition,
                                leftText : "Çıkış",
                                rightText: "Geç",
                                observer : self.observer)
    }
    
    func touchesBegan(_ touches: Set<UITouch>) {
        self.buttons?.touchesBegan(touches)
    }
}
