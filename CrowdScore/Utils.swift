//
//  Utils.swift
//  CrowdScore
//
//  Created by Steven Zheng on 5/17/17.
//  Copyright © 2017 szzheng. All rights reserved.
//

import Foundation
import UIKit

func positionViewBelow(bottomView: UIView, topView: UIView, distance: CGFloat) {
    var f = bottomView.frame
    f.origin.y = topView.frame.origin.y + topView.frame.height + distance
    bottomView.frame = f
}

func getYOrigin(topView: UIView, distance: CGFloat) -> CGFloat {
    return topView.frame.origin.y + topView.frame.height + distance
}

func getYCenter(view: UIView, topView: UIView, distance: CGFloat) -> CGFloat {
    return getYOrigin(topView: topView, distance: distance) + view.frame.height/2
}

func nameToEmail(name: String) -> String {
    return name.replacingOccurrences(of: " ", with: "_") + "@crowdscore.com"    
}


class Score {
    
    var observers: [MatchViewController]!
    var playerScore: [Int]!
    var challengerScore: [Int]!
    var playerSets: Int
    var challengerSets: Int
    var currentSet: Int
    var isFinished: Bool
        
    init(numSets: Int) {
        playerScore = Array(repeating: 0, count: numSets + 1)
        challengerScore = Array(repeating: 0, count: numSets + 1)
        currentSet = 1
        playerSets = 0
        challengerSets = 0
        isFinished = false
    }
    
    /*
    func setScore(playerScore: [Int], challengerScore: [Int], playerSets: Int, challengerSets: Int, currentSet: Int, isFinished: Bool) {
        self.playerScore = playerScore
        self.challengerScore = challengerScore
        self.playerSets = playerSets
        self.challengerSets = challengerSets
        self.currentSet = currentSet
        self.isFinished = isFinished
    }
    */
}
