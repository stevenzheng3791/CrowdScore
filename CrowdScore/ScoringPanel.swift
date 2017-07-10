//
//  ScoringPanel.swift
//  CrowdScore
//
//  Created by Steven Zheng on 5/21/17.
//  Copyright © 2017 szzheng. All rights reserved.
//

import UIKit

class ScoringPanel: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    var vc : MatchViewController!
    var pointPanel : SegmentedControlPanel!
    var submitButton : StandardButton!
    var ace : ToggleButton!
    var winner : ToggleButton!
    var otherW : ToggleButton!
    var doubleFault : ToggleButton!
    var unforcedError : ToggleButton!
    var otherL : ToggleButton!
    
    var servicePanel : SegmentedControlPanel!
    var firstService : ToggleButton!
    var secondService : ToggleButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let buttonWidth = 150.0 as CGFloat
        let buttonHeight = 40.0 as CGFloat
        
        servicePanel = SegmentedControlPanel(frame: CGRect(x: 0, y: 0, width: 2 * buttonWidth + 30, height: buttonHeight))
        servicePanel.frame.origin.x = self.frame.width/2 - servicePanel.frame.width/2
        self.addSubview(servicePanel)
        firstService = ToggleButton(frame: CGRect(x: 0, y: 0, width: buttonWidth, height: buttonHeight))
        secondService = ToggleButton(frame: CGRect(x: buttonWidth + 30, y: 0, width: buttonWidth, height: buttonHeight))
        firstService.setTitle(title: "First")
        secondService.setTitle(title: "Second")
        firstService.segmentedControlPanel = servicePanel
        secondService.segmentedControlPanel = servicePanel
        servicePanel.addSubview(firstService)
        servicePanel.addSubview(secondService)
        firstService.toggleOn()
        servicePanel.onButton = firstService
        
        pointPanel = SegmentedControlPanel(frame: CGRect(x: 0, y: 0, width: 2 * buttonWidth + 30, height: 3 * buttonHeight + 30))
        pointPanel.frame.origin.x = self.frame.width/2 - pointPanel.frame.width/2
        pointPanel.frame.origin.y = getYOrigin(topView: servicePanel, distance: 30)
        self.addSubview(pointPanel)
        ace = ToggleButton(frame: CGRect(x: 0, y: 0, width: buttonWidth, height: buttonHeight))
        winner = ToggleButton(frame: CGRect(x: 0, y: getYOrigin(topView: ace, distance: 15), width: buttonWidth, height: buttonHeight))
        otherW = ToggleButton(frame: CGRect(x: 0, y: getYOrigin(topView: winner, distance: 15), width: buttonWidth, height: buttonHeight))
        doubleFault = ToggleButton(frame: CGRect(x: buttonWidth + 30, y: 0, width: buttonWidth, height: buttonHeight))
        unforcedError = ToggleButton(frame: CGRect(x: buttonWidth + 30, y: getYOrigin(topView: doubleFault, distance: 15), width: buttonWidth, height: buttonHeight))
        otherL = ToggleButton(frame: CGRect(x: buttonWidth + 30, y: getYOrigin(topView: unforcedError, distance: 15), width: buttonWidth, height: buttonHeight))
        ace.setTitle(title: "ace")
        winner.setTitle(title: "winner")
        otherW.setTitle(title: "other (W)")
        doubleFault.setTitle(title: "doubleFault")
        unforcedError.setTitle(title: "unforced error")
        otherL.setTitle(title: "other (L)")
        ace.segmentedControlPanel = pointPanel
        winner.segmentedControlPanel = pointPanel
        otherW.segmentedControlPanel = pointPanel
        doubleFault.segmentedControlPanel = pointPanel
        unforcedError.segmentedControlPanel = pointPanel
        otherL.segmentedControlPanel = pointPanel
        pointPanel.addSubview(ace)
        pointPanel.addSubview(winner)
        pointPanel.addSubview(otherW)
        pointPanel.addSubview(doubleFault)
        pointPanel.addSubview(unforcedError)
        pointPanel.addSubview(otherL)
        ace.toggleOn()
        pointPanel.onButton = ace
        
        submitButton = StandardButton(frame: CGRect(origin: CGPoint(), size: largeButtonSize))
        submitButton.frame.origin.x = self.frame.width/2 - submitButton.frame.width/2
        submitButton.frame.origin.y = getYOrigin(topView: pointPanel, distance: 40)
        submitButton.setTitle(title: "Submit")
        submitButton.addTarget(self, action: #selector(submit), for: .touchUpInside)
        self.addSubview(submitButton)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func submit() {
        if (ace.isOn || winner.isOn || otherW.isOn) {
            vc.awardPointToPlayer()
        } else {
            vc.awardPointToChallenger()
        }
    }
}
