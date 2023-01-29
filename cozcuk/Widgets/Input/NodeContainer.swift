//
//  NodeContainer.swift
//  cozcuk
//
//  Created by Dr. Kerem Koseoglu on 17.08.2022.
//

import SpriteKit

protocol NodeContainer {
    var position: CGPoint {get}
    func isOwnNode(_ node: SKNode) -> Bool
}
