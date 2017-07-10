//
//  MatchesViewController.swift
//  CrowdScore
//
//  Created by Steven Zheng on 7/4/17.
//  Copyright © 2017 szzheng. All rights reserved.
//

import UIKit

class MatchesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var matches = [String]()
    var tableView: UITableView!
    let firebaseClient = FirebaseClient()
    let matchClient = MatchClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let baseView = BaseView(frame: CGRect(origin: CGPoint(), size: self.view.frame.size))
        self.view.addSubview(baseView)
        
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: baseView.frame.width, height: baseView.frame.height))
        tableView.frame.origin.y = getYOrigin(topView: baseView.navBar, distance: 0)
        baseView.addSubview(tableView)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MatchCell")
        tableView.dataSource = self
        tableView.delegate = self
        
        firebaseClient.observeMatches(observer: self)
        baseView.navBar.topItem?.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(generateNewMatch))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateMatchesList() {
        /* Update the table view with the current list of matches */
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let matchVC = MatchViewController()
        matchVC.matchID = matches[indexPath.row]
        self.present(matchVC, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matches.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MatchCell", for: indexPath as IndexPath)
        cell.textLabel!.text = "\(matches[indexPath.row])"
        return cell
    }
    
    func generateNewMatch() {
        let id = UUID().uuidString
        let playerName = "Arya Stark"
        let opponentName = "Opponent"
        let matchName = "Match Name"
        matchClient.createMatch(id: id, playerName: playerName, opponentName: opponentName, matchName: matchName)
        //firebaseClient.uploadMatch(matchID: id, matchName: name)
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
