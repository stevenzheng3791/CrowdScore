
//
//  TabBarController.swift
//  
//
//  Created by Steven Zheng on 5/23/17.
//
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        /*
        let matchVC = MatchViewController()
        matchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 0)
        */
        let matchesVC = MatchesViewController()
        matchesVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 0)
        
        let scoresVC = ScoresViewController()
        scoresVC.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 1)
        
        let signupVC = SignUpViewController()
        signupVC.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 2)
        
        let playersVC = PlayersViewController()
        playersVC.tabBarItem = UITabBarItem(tabBarSystemItem: .downloads, tag: 3)
        
        
        let viewControllerList = [matchesVC,scoresVC,signupVC,playersVC]
        viewControllers = viewControllerList
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
