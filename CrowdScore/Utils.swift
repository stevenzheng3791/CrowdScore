//
//  Utils.swift
//  CrowdScore
//
//  Created by Steven Zheng on 5/17/17.
//  Copyright © 2017 szzheng. All rights reserved.
//

import Foundation
import UIKit

func positionViewBelow(bottomView: UIView, topView: UIView, distance: CGFloat) {
    var f = bottomView.frame
    f.origin.y = topView.frame.origin.y + topView.frame.height + distance
    bottomView.frame = f
}
