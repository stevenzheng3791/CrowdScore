//
//  ButtonExtension.swift
//  CrowdScore
//
//  Created by Steven Zheng on 5/13/17.
//  Copyright © 2017 szzheng. All rights reserved.
//

import Foundation
import UIKit

extension UIButton {
    
    func disable() {
        self.isEnabled = false
        self.alpha = 0.3
    }
    
    func enable() {
        self.isEnabled = true
        self.alpha = 1.0
    }
}
