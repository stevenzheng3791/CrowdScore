//
//  BackgroundView.swift
//  CrowdScore
//
//  Created by Steven Zheng on 5/20/17.
//  Copyright © 2017 szzheng. All rights reserved.
//
//  Background for all screens 

import UIKit

class BackgroundView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = darkGrayColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
