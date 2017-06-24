//
//  MenuViewController.swift
//  CrowdScore
//
//  Created by Steven Zheng on 5/17/17.
//  Copyright © 2017 szzheng. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var menuLabel: UILabel!
    var menu: UITableView!
    var adminMenuLabel: UILabel!
    var adminMenu: UITableView!
    var options : [String]!
    var adminOptions : [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view = BaseView(frame: self.view.frame)
        let baseView = self.view as! BaseView
        
        options = ["TEAMS","SCORES","PLAYERS","SCHEDULE"]
        adminOptions = ["START MATCH SESSION","MANAGE ROSTER","MANAGE LINEUP","MANAGE SCHEDULE","MANAGE SUBSCRIPTION","MANAGE TEAM SETTINGS"]
        
        menuLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 40))
        menuLabel.textAlignment = NSTextAlignment.left
        menuLabel.textColor = whiteColor
        menuLabel.backgroundColor = UIColor.clear
        positionViewBelow(bottomView: menuLabel, topView: baseView.navBar, distance: 0)
        menuLabel.text = "MENU"
        self.view.addSubview(menuLabel)
        
        menu = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 3 * cellHeight))
        positionViewBelow(bottomView: menu, topView: menuLabel, distance: 0)
        menu.register(PlayerTableViewCell.self, forCellReuseIdentifier: "PlayerTableViewCell")
        menu.dataSource = self
        menu.delegate = self
        self.view.addSubview(menu)
        
        adminMenuLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 40))
        adminMenuLabel.textAlignment = NSTextAlignment.left
        adminMenuLabel.textColor = whiteColor
        adminMenuLabel.backgroundColor = UIColor.clear
        adminMenuLabel.text = "ADMIN MENU"
        positionViewBelow(bottomView: adminMenuLabel, topView: menu, distance: 0)
        self.view.addSubview(adminMenuLabel)
        
        
        adminMenu = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 6 * cellHeight))
        positionViewBelow(bottomView: adminMenu, topView: adminMenuLabel, distance: 0)
        adminMenu.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        adminMenu.dataSource = self
        adminMenu.delegate = self
        self.view.addSubview(adminMenu)
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("didSelectRowAtIndexPath + \(indexPath.row)")
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (tableView == menu) {
            return options.count
        } else {
            return adminOptions.count
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (tableView == menu) {
            let cell = menu.dequeueReusableCell(withIdentifier: "PlayerTableViewCell", for: indexPath as IndexPath) as! PlayerTableViewCell
            cell.name.text = options[indexPath.row]
            cell.profilePicture.image = UIImage(named: "Arya Stark.jpg")
            cell.desc.text = "10"
            
            print(cell.name.frame.origin.y)
            print(cell.profilePicture.frame.origin.y)
            print(cell.desc.frame.origin.y)
            return cell
        } else {
            let cell = adminMenu.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath)
            cell.textLabel!.text = adminOptions[indexPath.row]
            return cell
        }
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
