//
//  StandardButton.swift
//  CrowdScore
//
//  Created by Steven Zheng on 5/20/17.
//  Copyright © 2017 szzheng. All rights reserved.
//

import UIKit

class StandardButton: RoundedButton {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = blueButtonColor
        self.setTitleColor(whiteColor, for: .normal)
        self.titleLabel?.font = UIFont(name: "Helvetica", size: 20)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
