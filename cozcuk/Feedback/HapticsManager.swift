//
//  HapticsManager.swift
//  cozcuk
//
//  Created by Dr. Kerem Koseoglu on 15.10.2022.
//

import UIKit

class HapticsManager {
    private static var SINGLETON: HapticsManager?
    private var impactGenerator: UIImpactFeedbackGenerator
    private var selectionGenerator: UISelectionFeedbackGenerator
    private var notificationGenerator: UINotificationFeedbackGenerator
    
    public static func getInstance() -> HapticsManager {
        if HapticsManager.SINGLETON == nil {
            HapticsManager.SINGLETON = HapticsManager()
        }
        
        return HapticsManager.SINGLETON!
    }
    
    public var hapticsActive: Bool {
        get {
            return AudioManager.getInstance().soundIsOn
        }
    }
    
    public func impact() {
        if !self.hapticsActive {return}
        self.impactGenerator.impactOccurred()
        self.impactGenerator.prepare()
    }
    
    public func selection() {
        if !self.hapticsActive {return}
        self.selectionGenerator.selectionChanged()
        self.selectionGenerator.prepare()
    }
    
    public func error() {
        if !self.hapticsActive {return}
        self.notificationGenerator.notificationOccurred(.error)
        self.notificationGenerator.prepare()
    }
    
    public func success() {
        if !self.hapticsActive {return}
        self.notificationGenerator.notificationOccurred(.success)
        self.notificationGenerator.prepare()
    }
    
    private init() {
        self.impactGenerator = UIImpactFeedbackGenerator()
        self.selectionGenerator = UISelectionFeedbackGenerator()
        self.notificationGenerator = UINotificationFeedbackGenerator()
        
        self.impactGenerator.prepare()
        self.selectionGenerator.prepare()
        self.notificationGenerator.prepare()
    }
}
