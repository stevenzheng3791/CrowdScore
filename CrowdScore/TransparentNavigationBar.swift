//
//  TransparentNavigationBar.swift
//  CrowdScore
//
//  Created by Steven Zheng on 5/14/17.
//  Copyright © 2017 szzheng. All rights reserved.
//

import UIKit

class TransparentNavigationBar: UINavigationBar {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override func awakeFromNib() {
        let transparentPixel = UIImage(named: "TransparentPixel")
        self.setBackgroundImage(transparentPixel, for: UIBarMetrics.default)
        self.shadowImage = transparentPixel
        self.backgroundColor = UIColor.clear
        self.isTranslucent = true
    }

}
