//
//  NavigationBar.swift
//  CrowdScore
//
//  Created by Steven Zheng on 5/20/17.
//  Copyright © 2017 szzheng. All rights reserved.
//

import UIKit

class NavigationBar: UINavigationBar {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
        self.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.shadowImage = UIImage()
        self.isTranslucent = true
        self.backgroundColor = UIColor.clear
        self.tintColor = UIColor.white
        let topItem = UINavigationItem(title: "Title")
        let leftItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.cancel, target: nil, action: nil)
        let rightItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.edit, target: nil, action: nil)
        topItem.leftBarButtonItem = leftItem
        topItem.rightBarButtonItem = rightItem
        self.setItems([topItem], animated: false)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func removeBarButtonItems() {
        self.topItem?.leftBarButtonItem = nil
        self.topItem?.rightBarButtonItem = nil
    }
}
