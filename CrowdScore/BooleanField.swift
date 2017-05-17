//
//  BooleanField.swift
//  CrowdScore
//
//  Created by Steven Zheng on 5/14/17.
//  Copyright © 2017 szzheng. All rights reserved.
//

import UIKit

class BooleanField: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    var optionOne : RoundedButton!
    var optionTwo : RoundedButton!
    
    func setup() {
        optionOne = RoundedButton(frame: CGRect(x: self.frame.size.width/2 - largeButtonSize.width/2, y: 0, width: largeButtonSize.width, height: largeButtonSize.height))
        optionOne.setTitle("Option One", for: .normal)
        optionOne.setTitleColor(whiteColor, for: .normal)
        optionOne.backgroundColor = blueButtonColor
        self.addSubview(optionOne)
        
        optionTwo = RoundedButton(frame: CGRect(x: self.frame.size.width/2 - largeButtonSize.width/2, y: self.frame.height - largeButtonSize.height, width: largeButtonSize.width, height: largeButtonSize.height))
        optionTwo.setTitle("Option Two", for: .normal)
        optionTwo.setTitleColor(whiteColor, for: .normal)
        optionTwo.backgroundColor = blueButtonColor
        self.addSubview(optionTwo)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
