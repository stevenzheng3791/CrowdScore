//
//  FirebaseClient.swift
//  CrowdScore
//
//  Created by Steven Zheng on 5/24/17.
//  Copyright © 2017 szzheng. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase
import FirebaseAuth

var rootRef: DatabaseReference = Database.database().reference()


func createTeam(name: String, password: String) {
    let email = name.replacingOccurrences(of: " ", with: "_") + "@crowdscore.com"
    Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
        print("user created with email \(email) and password \(password)")
        //print("HELLO")
        administrateTeam(name: name, password: password)
    }
}

func administrateTeam(name: String, password: String) {
    let email = name.replacingOccurrences(of: " ", with: "_") + "@crowdscore.com"
    Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
        print("user log in with email \(email) and password \(password)")
        //print(getCurrentUser()?.email)
    }
}

func getCurrentUser() -> User? {
    return Auth.auth().currentUser
}

/* use this function to keep your scoring system updated */
func observeScoringSystem(scoringSystem: ScoringSystem) {
    
    rootRef.observe(.value, with: { (snapshot) in
        
        print("observe scoring system")
        
        let adScoring = (snapshot.value as! NSDictionary)["adScoring"] as! Bool
        let games = (snapshot.value as! NSDictionary)["games"] as! Int
        let matches = (snapshot.value as! NSDictionary)["matches"] as! Int
        let sets = (snapshot.value as! NSDictionary)["sets"] as! Int
        let superTiebreak = (snapshot.value as! NSDictionary)["superTiebreak"] as! Bool
        let superTiebreakPoints = (snapshot.value as! NSDictionary)["superTiebreakPoints"] as! Int
        let tiebreakPoints = (snapshot.value as! NSDictionary)["tiebreakPoints"] as! Int
        let tiebreakStart = (snapshot.value as! NSDictionary)["tiebreakStart"] as! Int
        let winByTwoGames = (snapshot.value as! NSDictionary)["winByTwoGames"] as! Bool
        let winByTwoPointsSuperTiebreak = (snapshot.value as! NSDictionary)["winByTwoPointsSuperTiebreak"] as! Bool
        let winByTwoPointsTiebreak = (snapshot.value as! NSDictionary)["winByTwoPointsTiebreak"] as! Bool
        
        
        scoringSystem.adScoring = adScoring
        scoringSystem.games = games
        scoringSystem.matches = matches
        scoringSystem.sets = sets
        scoringSystem.superTiebreak = superTiebreak
        scoringSystem.superTiebreakPoints = superTiebreakPoints
        scoringSystem.tiebreakPoints = tiebreakPoints
        scoringSystem.tiebreakStart = tiebreakStart
        scoringSystem.winByTwoGames = winByTwoGames
        scoringSystem.winByTwoPointsSuperTiebreak = winByTwoPointsSuperTiebreak
        scoringSystem.winByTwoPointsTiebreak = winByTwoPointsTiebreak
        
    }) { (error) in
        print(error.localizedDescription)
    }
}

/* use this function to save your scoring system */
func saveScoringSystem(scoringSystem: ScoringSystem, singles: Bool) {
    
    var ref : DatabaseReference
    if (singles) {
        ref = rootRef.child("singlesScoringSystem")
    } else {
        ref = rootRef.child("doublesScoringSystem")
    }
        
    ref.setValue(["adScoring" : scoringSystem.adScoring, "games" : scoringSystem.games, "matches" : scoringSystem.matches, "sets" : scoringSystem.sets, "superTiebreak" : scoringSystem.superTiebreak, "superTiebreakPoints" : scoringSystem.superTiebreakPoints, "tiebreakPoints" : scoringSystem.tiebreakPoints, "tiebreakStart" : scoringSystem.tiebreakStart, "winByTwoGames" : scoringSystem.winByTwoGames, "winByTwoPointsSuperTiebreak" : scoringSystem.winByTwoPointsSuperTiebreak, "winByTwoPointsTiebreak" : scoringSystem.winByTwoPointsTiebreak])
}

/* use this function to upload a score to Firebase */
func uploadScore(score: Score) {
    
    print ("Upload score")
    var playerScore = [String : Int]()
    for x in 0..<score.playerScore.count {
        playerScore[String(x)] = score.playerScore[x]
    }
    rootRef.child("score/playerScore").setValue(playerScore)
    rootRef.child("score/playerSets").setValue(score.playerSets)
    
    var challengerScore = [String : Int]()
    for x in 0..<score.challengerScore.count {
        challengerScore[String(x)] = score.challengerScore[x]
    }
    rootRef.child("score/challengerScore").setValue(challengerScore)
    rootRef.child("score/challengerSets").setValue(score.challengerSets)
    
    
    rootRef.child("score/currentSet").setValue(score.currentSet)
    rootRef.child("score/isFinished").setValue(score.isFinished)
}

/* use this function to observe a score from Firebase*/
func observeScore(observer: MatchViewController) {
    
    rootRef.child("score").observe(.value, with: { (snapshot) in
        print("Observe score")

        var playerScore = [Int]()
        let playerScoreDict = (snapshot.value as! NSDictionary)["playerScore"] as! [Int]
        print("playerScoreDict count is \(playerScoreDict.count)")
        print(playerScoreDict)
        for x in 0..<playerScoreDict.count {
            playerScore.append(playerScoreDict[(x)])
        }
        let playerSets = (snapshot.value as! NSDictionary)["playerSets"] as! Int
        
        var challengerScore = [Int]()
        let challengerScoreDict = (snapshot.value as! NSDictionary)["challengerScore"] as! [Int]
        for x in 0..<challengerScoreDict.count {
            challengerScore.append(challengerScoreDict[(x)])
        }
        let challengerSets = (snapshot.value as! NSDictionary)["challengerSets"] as! Int
        
        let currentSet = (snapshot.value as! NSDictionary)["currentSet"] as! Int
        let isFinished = (snapshot.value as! NSDictionary)["isFinished"] as! Bool
        
        observer.score.playerScore = playerScore
        observer.score.playerSets = playerSets
        observer.score.challengerScore = challengerScore
        observer.score.challengerSets = challengerSets
        observer.score.currentSet = currentSet
        observer.score.isFinished = isFinished
        
        observer.scoreboard.displayScore(score: observer.score)
        
    }) { (error) in
        print(error.localizedDescription)
    }
}

/*
func saveTeam() {
    ref.child("users").child(user.uid).setValue(["username": username])

}
 */
