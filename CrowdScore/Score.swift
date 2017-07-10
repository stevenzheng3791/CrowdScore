//
//  Score.swift
//  CrowdScore
//
//  Created by Steven Zheng on 7/2/17.
//  Copyright © 2017 szzheng. All rights reserved.
//

class Score {
    
    var playerScore: [Int]!
    var challengerScore: [Int]!
    var playerSets: Int
    var challengerSets: Int
    var currentSet: Int
    var playerIsServing: Bool!
    var playerServedFirstInSet: Bool!
    
    var playerWon: Bool!
    var challengerWon: Bool!
    var inProgress: Bool!
    
    var id: String!
    
    init(numSets: Int) {
        playerScore = Array(repeating: 0, count: numSets + 1)
        challengerScore = Array(repeating: 0, count: numSets + 1)
        currentSet = 1
        playerSets = 0
        challengerSets = 0
        playerIsServing = true
        playerServedFirstInSet = true
        
        playerWon = false
        challengerWon = false
        inProgress = true
    }
}
