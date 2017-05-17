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
    
    override func layoutSubviews() {
        let length = min(self.frame.size.width,self.frame.size.height)
        
        let origin = CGPoint(x: self.frame.origin.x + self.frame.size.width/2 - length/2, y: self.frame.origin.y + self.frame.size.height/2 - length/2)
        let size = CGSize(width: length, height: length)
        
        self.frame = CGRect(origin: origin, size: size)
        self.layer.cornerRadius = length/2
        self.clipsToBounds = true
        self.layer.borderColor = whiteColor.cgColor
        self.layer.borderWidth = 2.0
    }

}
