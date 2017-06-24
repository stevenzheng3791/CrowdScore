//
//  PlayerTableViewCell.swift
//  CrowdScore
//
//  Created by Steven Zheng on 5/17/17.
//  Copyright © 2017 szzheng. All rights reserved.
//

import UIKit

class PlayerTableViewCell: UITableViewCell {

    var profilePicture: ProfileImageView!
    var name: UILabel!
    var desc: UILabel!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        profilePicture = ProfileImageView(frame: CGRect(x: 20, y: self.frame.height - 20, width: 40, height: 40))
        self.addSubview(profilePicture)
        
        desc = UILabel(frame: CGRect(x: self.frame.width - 40, y: self.frame.height - 20, width: 20, height: 40))
        self.addSubview(desc)
        
        name = UILabel(frame: CGRect(x: 60, y: self.frame.height - 20, width: self.frame.width - 60 - 40, height: 40))
        self.addSubview(name)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
