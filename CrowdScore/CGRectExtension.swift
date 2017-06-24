//
//  CGRectExtension.swift
//  CrowdScore
//
//  Created by Steven Zheng on 5/20/17.
//  Copyright © 2017 szzheng. All rights reserved.
//

import Foundation
import UIKit

extension CGRect {
    init(center: CGPoint, size: CGSize) {
        let o = CGPoint(x: center.x - size.width/2, y: center.y - size.height/2)
        self.init(origin: o, size: size)
    }
}
