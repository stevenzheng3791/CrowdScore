//
//  MatchViewController.swift
//  CrowdScore
//
//  Created by Steven Zheng on 5/20/17.
//  Copyright © 2017 szzheng. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class
MatchViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    /* View controller for the match */
    
    var matchID: String!
    var score: Score!  // Score data for the match
    var playerName: String!
    var opponentName: String!
    var matchTitle: String!
    var scoreboard: Scoreboard!  // View to display score
    var scoringPanel: ScoringPanel!  // View interface to update score
    var scoringSystem : ScoringSystem!  // Handler for score update
    
    var isBeingScored: Bool!
    
    var stats = ["Aces", "Winners", "Other(W)", "Double Faults", "Unforced Errors", "Other(L)"]
    
    var firebaseClient: FirebaseClient!  // Client to communicate with Firebase
    
    var statPanel: StatPanel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Match"
        let baseView = BaseView(frame: CGRect(origin: CGPoint(), size: self.view.frame.size))
        self.view.addSubview(baseView)
        
        scoringSystem = ScoringSystem()
        score = Score(numSets: scoringSystem.getMaxSets())
        playerName = "Player"
        opponentName = "Opponent"
        matchTitle = "Title"
        
        scoreboard = Scoreboard(frame: CGRect(x: 20, y: 0, width: baseView.frame.width - 40, height: 100), numSets: scoringSystem.getMaxSets())
        scoreboard.frame.origin.y = getYOrigin(topView: baseView.navBar, distance: 40)
        scoreboard.displayScore(score: score)
        scoreboard.displayContestants(playerName: playerName, opponentName: opponentName)
        scoreboard.displayTitle(titleName: matchTitle)
        baseView.addSubview(scoreboard)
        
        baseView.navBar.topItem?.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
        baseView.navBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(refresh))
        
        /* Display Panels */
        scoringPanel = ScoringPanel(frame: CGRect(x: 0, y: 0, width: baseView.frame.width, height: baseView.frame.height - getYOrigin(topView: scoreboard, distance: 15)))
        scoringPanel.frame.origin.y = getYOrigin(topView: scoreboard, distance: 15)
        scoringPanel.vc = self
        baseView.addSubview(scoringPanel)
        scoringPanel.isHidden = true
        
        statPanel = StatPanel(frame: CGRect(x: 0, y: 0, width: baseView.frame.width, height: baseView.frame.height - getYOrigin(topView: scoreboard, distance: 15)), vc: self)
        statPanel.frame.origin.y = getYOrigin(topView: scoreboard, distance: 15)
        baseView.addSubview(statPanel)
        statPanel.isHidden = true
        
        firebaseClient = FirebaseClient()
        observeFirebase()
        
        // testing
        /*
        let lockButton = UIButton(frame: CGRect(origin: CGPoint(), size: mediumButtonSize))
        lockButton.frame.origin.y = getYOrigin(topView: scoringPanel, distance: 0)
        lockButton.setTitle(title: "Lock")
        lockButton.addTarget(self, action: #selector(lock), for: .touchUpInside)
        baseView.addSubview(lockButton)
        let unlockButton = UIButton(frame: CGRect(origin: CGPoint(), size: mediumButtonSize))
        unlockButton.frame.origin.y = getYOrigin(topView: lockButton, distance: 0)
        unlockButton.setTitle(title: "Unlock")
        unlockButton.addTarget(self, action: #selector(unlock), for: .touchUpInside)
        baseView.addSubview(unlockButton)
        */
     }

    func observeFirebase() {
        //firebaseClient.observeScoringSystem(observer: self)
        firebaseClient.observeScore(observer: self)
        firebaseClient.observeMatchIsBeingScored(observer: self)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func cancel() {
        self.dismiss(animated: false, completion: nil)
    }
    
    func refresh() {
        score = Score(numSets: scoringSystem.getMaxSets())
        firebaseClient.uploadScore(matchID: matchID, score: score)
    }
    
    func lock() {
        isBeingScored = true
        firebaseClient.uploadMatchIsBeingScored(matchID: matchID, isBeingScored: isBeingScored)
    }
    
    func unlock() {
        isBeingScored = false
        firebaseClient.uploadMatchIsBeingScored(matchID: matchID, isBeingScored: isBeingScored)
    }
    
    func awardPointToPlayer() {
        /* Update score and upload it to Firebase with player point */
        scoringSystem.awardPointToPlayer(score: score)
        firebaseClient.uploadScore(matchID: matchID, score: score)
    }
    
    func awardPointToChallenger() {
        /* Update score and upload it to Firebase with challenger point */
        scoringSystem.awardPointToChallenger(score: score)
        firebaseClient.uploadScore(matchID: matchID, score: score)
    }
    
    
    func updateDisplayPanel() {
        /* Display the appropriate panel, scorekeeper or statviewer */
        if (isBeingScored) {
            scoringPanel.isHidden = true
            statPanel.isHidden = false
        } else {
            scoringPanel.isHidden = false
            statPanel.isHidden = true
        }
    }
    
    /* Functions that delegate to scoreboard */
    func updateScoreboardScore() {
        /* Update the scoreboard view with the current score */
        scoreboard.displayScore(score: score)
    }
    
    func updateScoreboardContestants() {
        /* Update the scoreboard view with the current contestant names */
        scoreboard.displayContestants(playerName: playerName, opponentName: opponentName)
    }
    
    func updateScoreboardTitle() {
        /* Update the scoreboard view with the current match name */
        scoreboard.displayTitle(titleName: matchTitle)
    }
    
    /* TableViewDelegate Protocol functions */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stats.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = statPanel.statTable.dequeueReusableCell(withIdentifier: "StatCell", for: indexPath as IndexPath)
        cell.textLabel!.text = "\(stats[indexPath.row])"
        return cell
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
