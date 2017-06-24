//
//  ProfileImageView.swift
//  CrowdScore
//
//  Created by Steven Zheng on 5/13/17.
//  Copyright © 2017 szzheng. All rights reserved.
//

import UIKit

class ProfileImageView: UIImageView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let length = min(self.frame.size.width,self.frame.size.height)
        
        let size = CGSize(width: length, height: length)
        
        self.frame = CGRect(x: self.center.x - size.width/2, y: self.center.y - size.height/2, width: size.width, height: size.height)
        self.layer.cornerRadius = length/2
        self.clipsToBounds = true
        self.layer.borderColor = whiteColor.cgColor
        self.layer.borderWidth = 2.0
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
