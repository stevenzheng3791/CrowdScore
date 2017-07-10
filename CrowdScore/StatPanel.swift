//
//  StatPanel.swift
//  CrowdScore
//
//  Created by Steven Zheng on 7/8/17.
//  Copyright © 2017 szzheng. All rights reserved.
//

import UIKit

class StatPanel: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    var vc : MatchViewController!

    var statTable: UITableView!
    
    init(frame: CGRect, vc: MatchViewController) {
        super.init(frame: frame)
        self.vc = vc
        statTable = UITableView(frame: CGRect(origin: CGPoint(), size: self.frame.size))
        statTable.delegate = self.vc
        statTable.dataSource = self.vc
        statTable.register(UITableViewCell.self, forCellReuseIdentifier: "StatCell")
        self.addSubview(statTable)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
