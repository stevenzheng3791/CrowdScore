//
//  ScoringSystem.swift
//  CrowdScore
//
//  Created by Steven Zheng on 5/22/17.
//  Copyright © 2017 szzheng. All rights reserved.
//

import Foundation

class ScoringSystem {
    /* Handler for updating a score */
    var adScoring: Bool
    var games: Int
    var sets: Int
    var superTiebreak: Bool
    var superTiebreakPoints: Int
    var tiebreakPoints: Int
    var tiebreakStart: Int
    var winByTwoGames: Bool
    var winByTwoPointsSuperTiebreak: Bool
    var winByTwoPointsTiebreak: Bool
    
    init(adScoring: Bool = true, games: Int = 6, sets: Int = 2, superTiebreak: Bool = false, superTiebreakPoints: Int = 10,
         tiebreakPoints: Int = 7, tiebreakStart: Int = 6, winByTwoGames: Bool = true, winByTwoPointsSuperTiebreak: Bool = false,
         winByTwoPointsTiebreak: Bool = true) {
        self.adScoring = adScoring
        self.games = games
        self.sets = sets
        self.superTiebreak = superTiebreak
        self.superTiebreakPoints = superTiebreakPoints
        self.tiebreakPoints = tiebreakPoints
        self.tiebreakStart = tiebreakStart
        self.winByTwoGames = winByTwoGames
        self.winByTwoPointsSuperTiebreak = winByTwoPointsSuperTiebreak
        self.winByTwoPointsTiebreak = winByTwoPointsTiebreak
    }
    
    
    /* player wins point */
    func awardPointToPlayer(score: Score) {
        if (score.inProgress) {
            if (isTiebreak(score: score)) {
                updateTiebreak(score: score, winnerIsPlayer: true)
            } else if (isSuperTiebreak(score: score)) {
                updateSuperTiebreak(score: score, winnerIsPlayer: true)
            } else {
                updateGame(score: score, winnerIsPlayer: true)
            }
        }
    }
    
    /* challenger wins point */
    func awardPointToChallenger(score: Score) {
        if (score.inProgress) {
            if (isTiebreak(score: score)) {
                updateTiebreak(score: score, winnerIsPlayer: false)
            } else if (isSuperTiebreak(score: score)) {
                updateSuperTiebreak(score: score, winnerIsPlayer: false)
            } else {
                updateGame(score: score, winnerIsPlayer: false)
            }
        }
    }
    
    /* update score for normal game */
    func updateGame(score: Score, winnerIsPlayer: Bool) {
        var winnerScore : Int
        var loserScore : Int
        
        if (winnerIsPlayer) {
            winnerScore = score.playerScore[0]
            loserScore = score.challengerScore[0]
        } else {
            winnerScore = score.challengerScore[0]
            loserScore = score.playerScore[0]
        }
        
        // calculate new score
        if (winnerScore == 0) {
            winnerScore = 15
        } else if (winnerScore == 15) {
            winnerScore = 30
        } else if (winnerScore == 30) {
            winnerScore = 40
        } else if (winnerScore == 40 && loserScore == 40 && adScoring == true) { // deuce
            winnerScore = 45
        } else if (winnerScore == 40 && loserScore == 45 && adScoring == true) { // ad out
            loserScore = 40
        } else {
            winnerScore = 0
            loserScore = 0
            score.playerIsServing = !score.playerIsServing
            updateSet(score: score, winnerIsPlayer: winnerIsPlayer)
        }
        
        // update score
        if (winnerIsPlayer) {
            score.playerScore[0] = winnerScore
            score.challengerScore[0] = loserScore
        } else {
            score.playerScore[0] = loserScore
            score.challengerScore[0] = winnerScore
        }
    }
        
    /* update score for normal game */
    func updateTiebreak(score: Score, winnerIsPlayer: Bool) {
        var winnerScore : Int
        var loserScore : Int
        
        if (winnerIsPlayer) {
            winnerScore = score.playerScore[0]
            loserScore = score.challengerScore[0]
        } else {
            winnerScore = score.challengerScore[0]
            loserScore = score.playerScore[0]
        }
        
        // calculate new score
        winnerScore += 1
        
        if (winnerScore >= tiebreakPoints && winnerScore >= (loserScore + 2)) {
            winnerScore = 0
            loserScore = 0
            score.playerServedFirstInSet = !score.playerServedFirstInSet
            score.playerIsServing = score.playerServedFirstInSet
            updateSet(score: score, winnerIsPlayer: winnerIsPlayer)
        } else {
            if ((winnerScore + loserScore) % 2) == 1 {
                score.playerIsServing = !score.playerIsServing
            }
        }
        
        // update score
        if (winnerIsPlayer) {
            score.playerScore[0] = winnerScore
            score.challengerScore[0] = loserScore
        } else {
            score.playerScore[0] = loserScore
            score.challengerScore[0] = winnerScore
        }
    }
    
    /* update score for normal game */
    func updateSuperTiebreak(score: Score, winnerIsPlayer: Bool) {
        var winnerScore : Int
        var loserScore : Int
        
        if (winnerIsPlayer) {
            winnerScore = score.playerScore[0]
            loserScore = score.challengerScore[0]
        } else {
            winnerScore = score.challengerScore[0]
            loserScore = score.playerScore[0]
        }
        
        // calculate new score
        winnerScore += 1
        
        if (winnerScore >= superTiebreakPoints && winnerScore >= (loserScore + 2)) {
            winnerScore = 0
            loserScore = 0
            updateSuperTiebreakSet(score: score, winnerIsPlayer: winnerIsPlayer)
        } else {
            if ((winnerScore + loserScore) % 2) == 1 {
                score.playerIsServing = !score.playerIsServing
            }
        }
        
        // update score
        if (winnerIsPlayer) {
            score.playerScore[0] = winnerScore
            score.challengerScore[0] = loserScore
        } else {
            score.playerScore[0] = loserScore
            score.challengerScore[0] = winnerScore
        }
    }
    
    func updateSet(score: Score, winnerIsPlayer: Bool) {
        var winnerScore: Int
        var loserScore: Int
        
        if (winnerIsPlayer) {
            winnerScore = score.playerScore[score.currentSet]
            loserScore = score.challengerScore[score.currentSet]
        } else {
            winnerScore = score.challengerScore[score.currentSet]
            loserScore = score.playerScore[score.currentSet]
        }
        
        // calculate new score
        winnerScore += 1
        
        // update score
        if (winnerIsPlayer) {
            score.playerScore[score.currentSet] = winnerScore
        } else {
            score.challengerScore[score.currentSet] = winnerScore
        }
        
        //end of set handling
        if ((winnerScore == games && winnerScore >= (loserScore + 2)) || (winnerScore > games)) {
            nextSet(score: score)
            updateMatch(score: score, winnerIsPlayer: winnerIsPlayer)
        }
        
    }
        
    func updateSuperTiebreakSet(score: Score, winnerIsPlayer: Bool) {
        var winnerScore: Int
        
        if (winnerIsPlayer) {
            winnerScore = score.playerScore[score.currentSet]
        } else {
            winnerScore = score.challengerScore[score.currentSet]
        }
        
        // calculate new score
        winnerScore += 1
        
        // update score
        if (winnerIsPlayer) {
            score.playerScore[score.currentSet] = winnerScore
        } else {
            score.challengerScore[score.currentSet] = winnerScore
        }
        
        nextSet(score: score)
        updateMatch(score: score, winnerIsPlayer: winnerIsPlayer)
    }
    
    
    func updateMatch(score: Score, winnerIsPlayer: Bool) {
        var winnerScore: Int
        if (winnerIsPlayer) {
            winnerScore = score.playerSets
        } else {
            winnerScore = score.challengerSets
        }
        
        // calculate new score
        winnerScore += 1
        
        // update score
        if (winnerIsPlayer) {
            score.playerSets = winnerScore
        } else {
            score.challengerSets = winnerScore
        }
        
        updateMatchStatus(score: score)
    }
    
    
    /* Helper functions */
    func nextSet(score: Score) {
        score.currentSet += 1
    }
    
    func isTiebreak(score: Score) -> Bool {
        return (score.playerScore[score.currentSet] == games && score.challengerScore[score.currentSet] == games)
    }
    
    func isSuperTiebreak(score: Score) -> Bool {
        return (score.currentSet == (sets * 2 - 1)) && superTiebreak
    }
    
    func getMaxSets() -> Int {
        /* Get the maximum number of sets played possible */
        return sets * 2 - 1
    }
    
    func getCurrentSet(score: Score) -> Int {
        /* Get the current set in progress */
        return score.playerSets + score.challengerSets + 1
    }
    
    func updateMatchStatus(score: Score) {
        /* Updates the match status based on the current set score */
        if score.playerSets == sets {
            score.playerWon = true
            score.challengerWon = false
            score.inProgress = false
        } else if score.challengerSets == sets {
            score.playerWon = false
            score.challengerWon = true
            score.inProgress = false
        } else {
            score.playerWon = false
            score.challengerWon = false
            score.inProgress = true
        }
    }
    
}
