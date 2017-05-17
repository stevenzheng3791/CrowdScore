//
//  BaseView.swift
//  CrowdScore
//
//  Created by Steven Zheng on 5/14/17.
//  Copyright © 2017 szzheng. All rights reserved.
//

import UIKit

class BaseView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    var backButton : UIButton!
    var editButton : UIButton!
    
    func setup() {
        self.backgroundColor = darkGrayColor
        backButton = UIButton(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: 80))
        self.addSubview(backButton)
        backButton.setTitleColor(whiteColor, for: .normal)
        backButton.setTitle("Back", for: .normal)
        backButton.contentHorizontalAlignment = .left
    }
    override func awakeFromNib() {
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
