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

class FirebaseClient {
    var rootRef: DatabaseReference = Database.database().reference()

    func createTeam(name: String, password: String) {
        let email = name.replacingOccurrences(of: " ", with: "_") + "@crowdscore.com"
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            print("user created with email \(email) and password \(password)")
            //print("HELLO")
            self.administrateTeam(name: name, password: password)
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
    
    func observeScoringSystem(observer: MatchViewController) {
        /* Have a match view controller observe the team's scoring system */
        
        let scoringSystemRef = rootRef
        let scoringSystem = observer.scoringSystem!
        
        scoringSystemRef.observe(.value, with: { (snapshot) in
            let val = (snapshot.value as! NSDictionary)
            scoringSystem.adScoring = val["adScoring"] as! Bool
            scoringSystem.games = val["games"] as! Int
            scoringSystem.sets = val["sets"] as! Int
            scoringSystem.superTiebreak = val["superTiebreak"] as! Bool
            scoringSystem.superTiebreakPoints = val["superTiebreakPoints"] as! Int
            scoringSystem.tiebreakPoints = val["tiebreakPoints"] as! Int
            scoringSystem.tiebreakStart = val["tiebreakStart"] as! Int
            scoringSystem.winByTwoGames = val["winByTwoGames"] as! Bool
            scoringSystem.winByTwoPointsSuperTiebreak = val["winByTwoPointsSuperTiebreak"] as! Bool
            scoringSystem.winByTwoPointsTiebreak = val["winByTwoPointsTiebreak"] as! Bool
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
            
        ref.setValue(["adScoring" : scoringSystem.adScoring, "games" : scoringSystem.games, "sets" : scoringSystem.sets, "superTiebreak" : scoringSystem.superTiebreak, "superTiebreakPoints" : scoringSystem.superTiebreakPoints, "tiebreakPoints" : scoringSystem.tiebreakPoints, "tiebreakStart" : scoringSystem.tiebreakStart, "winByTwoGames" : scoringSystem.winByTwoGames, "winByTwoPointsSuperTiebreak" : scoringSystem.winByTwoPointsSuperTiebreak, "winByTwoPointsTiebreak" : scoringSystem.winByTwoPointsTiebreak])
    }

    /* Match score */
    func uploadScore(matchID: String, score: Score) {
        /* Use this function to have a match controller upload its score to Firebase */

        let scoreRef = rootRef.child("score/\(matchID)")
        
        /* upload player info */
        var playerScore = [String : Int]()
        for x in 0..<score.playerScore.count {
            playerScore[String(x)] = score.playerScore[x]
        }
        scoreRef.child("playerScore").setValue(playerScore)
        scoreRef.child("playerSets").setValue(score.playerSets)
        scoreRef.child("playerIsServing").setValue(score.playerIsServing)
        scoreRef.child("playerServedFirstInSet").setValue(score.playerServedFirstInSet)
        scoreRef.child("playerWon").setValue(score.playerWon)
        
        /* upload challenger info */
        var challengerScore = [String : Int]()
        for x in 0..<score.challengerScore.count {
            challengerScore[String(x)] = score.challengerScore[x]
        }
        scoreRef.child("challengerScore").setValue(challengerScore)
        scoreRef.child("challengerSets").setValue(score.challengerSets)
        scoreRef.child("challengerWon").setValue(score.challengerWon)
        
        /* upload any additional info that should be known about the score */
        scoreRef.child("currentSet").setValue(score.currentSet)
        scoreRef.child("inProgress").setValue(score.inProgress)
    }

    func observeScore(observer: MatchViewController) {
        /* Use this function to have a match controller observe and update its score from Firebase */
        
        let scoreRef = rootRef.child("score/\(observer.matchID!)")
        scoreRef.observe(.value, with: { (snapshot) in
            let val = (snapshot.value as! NSDictionary)
            
            /* observe player info */
            observer.score.playerScore = []
            let playerScoreDict = val["playerScore"] as! [Int]
            for x in 0..<playerScoreDict.count {
                observer.score.playerScore.append(playerScoreDict[(x)])
            }
            observer.score.playerSets = val["playerSets"] as! Int
            observer.score.playerIsServing = val["playerIsServing"] as! Bool
            observer.score.playerServedFirstInSet = val["playerServedFirstInSet"] as! Bool
            observer.score.playerWon = val["playerWon"] as! Bool
            
            /* observe challneger info */
            observer.score.challengerScore = []
            let challengerScoreDict = val["challengerScore"] as! [Int]
            for x in 0..<challengerScoreDict.count {
                observer.score.challengerScore.append(challengerScoreDict[(x)])
            }
            observer.score.challengerSets = val["challengerSets"] as! Int
            observer.score.challengerWon = val["challengerWon"] as! Bool

            /* observe any additional info that should be know about the score */
            observer.score.currentSet = val["currentSet"] as! Int
            observer.score.inProgress = val["inProgress"] as! Bool

            /* notify the match controller to update its scoreboard */
            observer.updateScoreboardScore()
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    /* Match isBeingScored Flag */
    func uploadMatchIsBeingScored(matchID: String, isBeingScored: Bool) {
        /* Upload the scorekeeping status of a match */
        let matchIsBeingScoredRef = rootRef.child("matchIsBeingScored/\(matchID)")
        matchIsBeingScoredRef.setValue(isBeingScored)
    }
    
    func observeMatchIsBeingScored(observer: MatchViewController) {
        /* Observe and update the scorekeeping status of a match */
        let matchIsBeingScoredRef = rootRef.child("matchIsBeingScored/\(observer.matchID!)")
        matchIsBeingScoredRef.observe(.value, with: { (snapshot) in
            observer.isBeingScored = snapshot.value as! Bool
            observer.updateDisplayPanel()
        })
    }
    
    /***** Matches ******/
    func uploadMatch(matchID: String, matchName: String) {
        /* Store a new match id and name to Firebase */
        let matchesRef = rootRef.child("matches")
        matchesRef.child(matchID).setValue(matchName)
    }
    
    func observeMatches(observer: MatchesViewController) {
        /* Read and update the list of matches (id and name) from Firebase */
        let matchesRef = rootRef.child("matches")
        matchesRef.observe(.value, with: { (snapshot) in
            observer.matches = []
            if !(snapshot.value is NSNull) {
                for item in (snapshot.value as! NSDictionary) {
                    observer.matches.append(item.key as! String)
                }
            }
            observer.updateMatchesList()
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    /***** Match Contestants ******/
    func observeMatchContestants(observer: MatchViewController) {
        /* Read and update the contestants for a match from Firebase */
        let matchContestantsRef = rootRef.child("matchContestants/\(observer.matchID!)")
        matchContestantsRef.observe(.value, with: { (snapshot) in
            let val = (snapshot.value as! NSDictionary)
            observer.playerName = val["player"] as! String
            observer.opponentName = val["opponent"] as! String
            observer.updateScoreboardContestants()
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    func uploadMatchContestants(matchID: String, playerName: String, opponentName: String) {
        /* Store the match contestants to Firebase */
        let matchContestantsRef = rootRef.child("matchContestants/\(matchID)")
        matchContestantsRef.child("player").setValue(playerName)
        matchContestantsRef.child("opponent").setValue(opponentName)
    }
    

    /*
    func saveTeam() {
        ref.child("users").child(user.uid).setValue(["username": username])
    }
     */
}
