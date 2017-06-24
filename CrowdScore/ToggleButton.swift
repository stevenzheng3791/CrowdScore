
//
//  ToggleButton.swift
//  CrowdScore
//
//  Created by Steven Zheng on 5/21/17.
//  Copyright © 2017 szzheng. All rights reserved.
//
//  Button that functions as on or off, and toggles on press

import UIKit

class ToggleButton: UIButton {

    var segmentedControlPanel : SegmentedControlPanel!
    var isOn : Bool!
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addTarget(self, action: #selector(toggleOn), for: .touchUpInside)
        toggleOff()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    /* toggle on the button */
    func toggleOn() {
        segmentedControlPanel.turnOffCurrentButton()
        segmentedControlPanel.onButton = self
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 2
        self.backgroundColor = UIColor.white
        self.setTitleColor(darkGrayColor, for: .normal)
        isOn = true
    }
    
    /* toggle off the button */
    func toggleOff() {
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.borderWidth = 2
        self.backgroundColor = darkGrayColor
        self.setTitleColor(UIColor.white, for: .normal)
        isOn = false
    }

}
