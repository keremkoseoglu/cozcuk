//
//  ShootingStars.swift
//  cozcuk
//
//  Created by Dr. Kerem Koseoglu on 1.09.2022.
//

import SpriteKit

class ShootingStars {
    private static  let MIN_STAR_COUNT  : Int       = 3
    private static  let MAX_STAR_COUNT  : Int       = 7
    private static  let Y_FLUCT         : CGFloat   = 100
    private         var scene           : SKScene
    private         var zPosition       : CGFloat
    private         var stars           : [ShootingStar]?
    
    public init(scene: SKScene, zPosition: CGFloat) {
        self.scene      = scene
        self.zPosition  = zPosition
    }
    
    public func shootHorizontal(fromX: CGFloat, toX: CGFloat, midY: CGFloat, starCount: Int) {
        createStars(starCount: starCount)
        shootStarsParallel(fromX: fromX, toX: toX, midY: midY)
    }
    
    public func shootHorizontalRandom(fromX: CGFloat, toX: CGFloat, midY: CGFloat) {
        let starCount = Int.random(in: ShootingStars.MIN_STAR_COUNT..<ShootingStars.MAX_STAR_COUNT)
        createStars(starCount: starCount)
        shootStarsRandom(fromX: fromX, toX: toX, midY: midY)
    }
    
    public func removeFromParent() {
        if self.stars == nil {return}
        
        for star in self.stars! {
            star.removeFromParent()
        }
    }
    
    private func createStars(starCount: Int) {
        self.stars = [ShootingStar]()
        
        for _ in 0..<starCount {
            let newStar = ShootingStar(scene: self.scene, zPosition: self.zPosition)
            self.stars!.append(newStar)
        }
    }
    
    private func shootStarsRandom(fromX: CGFloat, toX: CGFloat, midY: CGFloat) {
        let plusFluct   = ShootingStars.Y_FLUCT * self.scene.cozcukScaleMax
        let minusFluct  = plusFluct * -1
        
        for star in self.stars! {
            let rndFluct = CGFloat.random(in: minusFluct..<plusFluct)
            let rndY     = midY + rndFluct
            
            star.shoot(from : CGPoint(x: fromX  , y: rndY),
                       to   : CGPoint(x: toX    , y: rndY))
        }
    }
    
    private func shootStarsParallel(fromX: CGFloat, toX: CGFloat, midY: CGFloat) {
        let moveSize    : CGFloat   = ShootingStars.Y_FLUCT / CGFloat(self.stars!.count)
        var starY       : CGFloat   = midY - (ShootingStars.Y_FLUCT / 2)
        
        for star in self.stars! {
            star.shoot(from : CGPoint(x: fromX  , y: starY),
                       to   : CGPoint(x: toX    , y: starY))
        
            starY += moveSize
        }
    }
}
