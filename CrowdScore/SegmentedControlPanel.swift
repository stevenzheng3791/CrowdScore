//
//  SegmentedControlPanel.swift
//  CrowdScore
//
//  Created by Steven Zheng on 5/21/17.
//  Copyright © 2017 szzheng. All rights reserved.
//

import UIKit

class SegmentedControlPanel: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    var toggleButtons : [ToggleButton]!
    var onButton : ToggleButton?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        toggleButtons = []
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func turnOffCurrentButton() {
        if let x = onButton {
            x.toggleOff()
        }
    }

}
