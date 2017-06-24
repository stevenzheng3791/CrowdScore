//
//  ScoresViewController.swift
//  CrowdScore
//
//  Created by Steven Zheng on 5/23/17.
//  Copyright © 2017 szzheng. All rights reserved.
//

import UIKit

class ScoresViewController: UIViewController {

    var numMatchesComplete = 0
    var numMatchesUpcoming = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.title = "Scores"
        let baseView = BaseView(frame: self.view.frame)
        baseView.navBar.topItem?.title = ""
        baseView.navBar.removeBarButtonItems()
        view.addSubview(baseView)
        
        // load header
        let header = UIView(frame: CGRect(origin: CGPoint(), size: CGSize(width: baseView.frame.width, height: 200)))
        header.frame.origin.y = getYOrigin(topView: baseView.navBar, distance: 0)
        baseView.addSubview(header)
        
        let result = StandardLabel(frame: CGRect(origin: CGPoint(), size: CGSize(width: header.frame.width, height: 120)))
        result.text = "No results to show"
        header.addSubview(result)
        
        let upcoming = UIView(frame: CGRect(x: 0, y: 150, width: header.frame.width, height: 80))
        header.addSubview(upcoming)
        
        let upcomingCaption = StandardLabel(frame: CGRect(x: 0, y: 0, width: upcoming.frame.width, height: 20))
        upcomingCaption.text = "No upcoming matches"
        upcoming.addSubview(upcomingCaption)
        let startButton = StandardButton(frame: CGRect(origin: CGPoint(), size: largeButtonSize))
        startButton.frame.origin.x = upcoming.frame.width/2 - startButton.frame.width/2
        startButton.frame.origin.y = getYOrigin(topView: upcomingCaption, distance: 0)
        startButton.setTitle(title: "New match session")
        upcoming.addSubview(startButton)
        
        
        
        
        
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    
}
