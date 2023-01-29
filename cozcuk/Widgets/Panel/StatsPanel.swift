//
//  StatsPanel.swift
//  cozcuk
//
//  Created by Dr. Kerem Koseoglu on 16.08.2022.
//

import SpriteKit

class StatsPanel {
    private var scene       : SKScene
    private var zPosition   : CGFloat
    private var db          : Database
    private var plaque      : WelcomePlaque
    private var buttons     : DoubleFooterButtons
    private var statLabel   : SKLabelNode?
    
    init(scene: SKScene, zPosition: CGFloat = 1, observer: DoubleFooterButtonsObserver?) {
        self.scene      = scene
        self.zPosition  = zPosition
        self.db         = Database.getInstance()
        self.plaque     = WelcomePlaque(scene: scene, zPosition: 9, text: WelcomePanelButtonFactory.STAT_TEXT)
        
        self.buttons    = DoubleFooterButtons(scene: scene,
                                              zPosition: zPosition + 1,
                                              leftText: "Çıkış",
                                              rightText: "Sıfırla",
                                              observer: observer)
        
        self.setupStatLabel()
    }
    
    public func touchesBegan(_ touches: Set<UITouch>) {
        self.buttons.touchesBegan(touches)
    }
    
    public func putFreshStatsIntoStatLabel() {
        self.statLabel!.text = ""
        self.statLabel!.numberOfLines = 0
        
        appendStatTypeToStatLabel(.puzzleAttemptCount)
        appendStatTypeToStatLabel(.solvedPuzzleCount)
        appendStatTypeToStatLabel(.hintSolvedPuzzleCount)
        appendStatTypeToStatLabel(.gaveUpPuzzleCount)
    }
    
    
    private func setupStatLabel() {
        self.statLabel                          = SKLabelNode(text: "")
        self.statLabel!.zPosition               = self.zPosition
        self.statLabel!.position                = CGPoint(x: 0, y: 0)
        self.statLabel!.horizontalAlignmentMode = .center
        self.statLabel!.verticalAlignmentMode = .center
        self.scene.addChild(self.statLabel!)
        self.putFreshStatsIntoStatLabel()
    }
    
    private func appendStatTypeToStatLabel(_ statType: StatisticType) {
        let statistic = self.db.getStatistic(type: statType)
        appendStatToStatLabel(statistic)
    }
    
    private func appendStatToStatLabel(_ stat: Statistic) {
        appendTextToStatLabel(String(stat.value) + " " + stat.type.pastDescription, icon: stat.type.icon)
    }
    
    private func appendTextToStatLabel(_ text: String, icon: String = "") {
        if self.statLabel!.text != "" {self.statLabel!.text! += "\n"}
        if icon != "" {self.statLabel!.text! += icon + " "}
        self.statLabel!.text! += text
        self.statLabel!.numberOfLines += 1
    }
}
