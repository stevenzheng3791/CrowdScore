//
//  PlayersViewController.swift
//  CrowdScore
//
//  Created by Steven Zheng on 5/18/17.
//  Copyright © 2017 szzheng. All rights reserved.
//

import UIKit

class PlayersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var list : UITableView!
    var players : [Player]!
    var rosterDesc : PlayerDescriptor!
    var statPicker : UIButton!
    var segmentedCtrl: UISegmentedControl!
    var baseView: BaseView!
    
    func getPlayers() {
        players = [Player(name: "Arya Stark", aces: 5, wins: 2, position: 0),
                   Player(name: "Sansa Stark", aces: 4, wins: 2, position: 1),
                   Player(name: "Robb Stark", aces: 3, wins: 3, position: 2),
                   Player(name: "Bran Stark", aces: 2, wins: 4, position: 4),
                   Player(name: "Rickon Stark", aces: 1, wins: 5, position: 3)]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.title = "Players"
        
        
        baseView = BaseView(frame: self.view.frame)
        self.view.addSubview(baseView)
        
        setupNavbar()
        setupStatPicker()
        setupList()
        
        getPlayers()
        rosterDesc = .aces
        loadPlayers(desc: rosterDesc)
    }
    
    
    /* set up nav bar */
    func setupNavbar() {
        baseView.navBar.topItem?.leftBarButtonItem = nil
        baseView.navBar.topItem?.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(loadAddPlayerVC))
        //navbar.setTitle(title: "")
        baseView.navBar.topItem?.title = ""
        segmentedCtrl = UISegmentedControl(items: ["Roster","Lineup"])
        segmentedCtrl.frame.size = mediumButtonSize
        segmentedCtrl.center = baseView.navBar.center
        segmentedCtrl.center.y += UIApplication.shared.statusBarFrame.height/2
        segmentedCtrl.selectedSegmentIndex = 0
        segmentedCtrl.addTarget(self, action: #selector(switchView), for: .valueChanged)
        baseView.navBar.addSubview(segmentedCtrl)
    }
    
    /* set view list based on segmented control */
    func switchView() {
        switch segmentedCtrl.selectedSegmentIndex {
        case 0:
            loadRosterView()
        case 1:
            loadLineupView()
        default:
            return
        }
    }
    
    /* Load roster view needs to:
     * 1. show the stat picker 
     * 2. move down the player list just below the stat picker view
     * 3. order players based on the current stat descriptor
     */
    func loadRosterView() {
        loadPlayers(desc: rosterDesc)
    }
    
    /* Load lineup view needs to:
     * 1. hide the stat picker 
     * 2. move up the player list just below the nav bar 
     * 3. order players based on position
     */
    func loadLineupView() {
        loadPlayers(desc: .position)
    }
    
    /* set up stat picker */
    func setupStatPicker() {
        // Load helper views
        statPicker = UIButton(frame: CGRect(x: baseView.frame.width/2 - 100, y: getYOrigin(topView: baseView.navBar, distance: 0), width: 200, height: 40))
        statPicker.setTitleColor(UIColor.white, for: .normal)
        statPicker.setTitle(title: "Sort by: Aces")
        baseView.addSubview(statPicker)
    }
    
    /* set up list */
    func setupList() {
        list = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        positionViewBelow(bottomView: list, topView: statPicker, distance: 0)
        list.register(PlayerTableViewCell.self, forCellReuseIdentifier: "PlayerTableViewCell")
        list.dataSource = self
        list.delegate = self
        list.separatorColor = UIColor.clear
        baseView.addSubview(list)
    }
    
    /* Modify roster */
    func loadAddPlayerVC() {
        let vc = AddPlayerViewController()
        vc.delegate = self
        self.present(vc, animated: false, completion: nil)
    }
    
    func addPlayer(player:Player) {
        self.players.append(player)
        list.reloadData()
    }
    
    func loadPlayers(desc: PlayerDescriptor) {
        switch desc {
        case .aces:
            players.sort(by: sorterForAces)
        case .wins:
            players.sort(by: sorterForWins)
        case .position:
            players.sort(by: sorterForPosition)
        }
        
        list.reloadData()
    }
    
    func removePlayer(player:Player) {
        // IMPLEMENT THIS
    }
    /* END - Modify Roster */
    
    /* Modify lineup */
    /* END - Modify lineup */
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    /* table view delegate functions */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("didSelectRowAtIndexPath + \(indexPath.row)")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = list.dequeueReusableCell(withIdentifier: "PlayerTableViewCell", for: indexPath as IndexPath) as! PlayerTableViewCell
        cell.name.text = players[indexPath.row].name
        cell.profilePicture.image = players[indexPath.row].picture
        cell.desc.text = String(players[indexPath.row].aces)
        return cell

    }
    
    /* end table view delegate functions */
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
