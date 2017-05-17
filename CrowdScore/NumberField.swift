//
//  NumberField.swift
//  CrowdScore
//
//  Created by Steven Zheng on 5/14/17.
//  Copyright © 2017 szzheng. All rights reserved.
//

import UIKit

class NumberField: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    var number : UITextField!
    var caption : UILabel!
    var preCaption: UILabel!
    
    func setup() {
        
        preCaption = UILabel(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 20))
        preCaption.textColor = whiteColor
        preCaption.textAlignment = NSTextAlignment.center
        preCaption.font = UIFont(name: "Helvetica", size: 20)
        preCaption.text = "Pre-caption"
        self.addSubview(preCaption)
            
        number = UITextField(frame: CGRect(x: 0, y: 20, width: self.frame.width, height: self.frame.height - 40))
        number.textColor = whiteColor
        number.backgroundColor = UIColor.clear
        number.textAlignment = NSTextAlignment.center
        number.font = UIFont(name: "Helvetica", size: 30)
        number.text = "--"
        self.addSubview(number)
        
        caption = UILabel(frame: CGRect(x: 0, y: self.frame.height - 20, width: self.frame.width, height: 20))
        caption.textColor = whiteColor
        caption.textAlignment = NSTextAlignment.center
        caption.font = UIFont(name: "Helvetica", size: 20)
        caption.text = "Caption"
        self.addSubview(caption)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
