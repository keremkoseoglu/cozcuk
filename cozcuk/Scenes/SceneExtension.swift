//
//  SceneExtension.swift
//  cozcuk
//
//  Created by Dr. Kerem Koseoglu on 16.08.2022.
//

import SpriteKit

protocol CozcukScene {
    static func moveToView(_ view: SKView)
}

extension SKScene {
    public  static  let COZCUK_WIDTH  : CGFloat   = 750
    public  static  let COZCUK_HEIGHT : CGFloat   = 1334
    private static  let COZCUK_TRANS  = SKTransition.doorway(withDuration: TimeInterval(1))
    
    public var cozcukScaleX: CGFloat {
        return self.size.width / SKScene.COZCUK_WIDTH
    }
    
    public var cozcukScaleY: CGFloat {
        return self.size.height / SKScene.COZCUK_HEIGHT
    }
    
    public var cozcukScaleMax: CGFloat {
        let scaleX = self.cozcukScaleX
        let scaleY = self.cozcukScaleY
        return scaleX < scaleY ? scaleX : scaleY
    }
    
    public func cozcukShowInView(_ view: SKView) {
        self.scaleMode = .aspectFit
        view.presentScene(self, transition: SKScene.COZCUK_TRANS)
    }
}
