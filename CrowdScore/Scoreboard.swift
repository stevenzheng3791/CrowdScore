//
//  Scoreboard.swift
//  CrowdScore
//
//  Created by Steven Zheng on 5/20/17.
//  Copyright © 2017 szzheng. All rights reserved.
//

import UIKit

class Scoreboard: UIView {

    var title : UILabel!
    var player : UILabel!
    var challenger : UILabel!
    var scoreCards : (player:[UILabel], challenger:[UILabel])!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
    init(frame: CGRect, numSets: Int) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.white
        self.layer.cornerRadius = 20
        self.clipsToBounds = true
        
        // Default values
        title = UILabel(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: 0))
        title.textAlignment = NSTextAlignment.center
        title.text = "Title"
        title.frame.size.height = title.sizeThatFits(CGSize(width: title.frame.width, height: CGFloat.greatestFiniteMagnitude)).height
        self.addSubview(title)
        
        let scoresView = UIView(frame: CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height - title.frame.height))
        scoresView.frame.origin.y = getYOrigin(topView: title, distance: -5)
        self.addSubview(scoresView)
        
        // Dividers
        let horizontalDiv = UIView(frame: CGRect(x: 0, y: 0, width: scoresView.frame.width - 10, height: 1))
        horizontalDiv.frame.origin.x = scoresView.frame.width/2 - horizontalDiv.frame.width/2
        horizontalDiv.frame.origin.y = scoresView.frame.height/2 - horizontalDiv.frame.height/2
        horizontalDiv.backgroundColor = UIColor.lightGray
        scoresView.addSubview(horizontalDiv)
        var verticalDivs = [UIView]()
        var inset = scoresView.frame.width - 5
        for _ in 0..<numSets {
            inset -= (scoreCardWidth + 1)
            let verticalDiv = UIView(frame: CGRect(x: inset, y: 0, width: 1, height: scoresView.frame.height - 10))
            verticalDiv.frame.origin.y = scoresView.frame.height/2 - verticalDiv.frame.height/2
            verticalDiv.backgroundColor = UIColor.lightGray
            scoresView.addSubview(verticalDiv)
            verticalDivs.insert(verticalDiv, at: 0)
        }
        
        // Scorecards
        scoreCards = (player:[],challenger:[])
        inset = scoresView.frame.width - 5
        for _ in 0...numSets {
            inset -= scoreCardWidth
            let playerCard = UILabel(frame: CGRect(x: inset, y: 0, width: scoreCardWidth, height: scoresView.frame.height/2))
            playerCard.text = "0"
            playerCard.textAlignment = NSTextAlignment.center
            
            let challengerCard = UILabel(frame: CGRect(x: inset, y: scoresView.frame.height/2, width: scoreCardWidth, height: scoresView.frame.height/2))
            challengerCard.text = "0"
            challengerCard.textAlignment = NSTextAlignment.center
            
            scoresView.addSubview(playerCard)
            scoresView.addSubview(challengerCard)
            scoreCards.player.insert(playerCard, at: 0)
            scoreCards.challenger.insert(challengerCard, at: 0)
            inset -= 1
        }
        
        // set up players
        player = UILabel(frame: CGRect(x: 10, y: 0, width: inset + 1 - 10, height: scoresView.frame.height/2))
        player.textAlignment = NSTextAlignment.left
        player.text = "Player"
        scoresView.addSubview(player)
        challenger = UILabel(frame: CGRect(x: 10, y: scoresView.frame.height/2, width: inset + 1 - 10, height: scoresView.frame.height/2))
        challenger.textAlignment = NSTextAlignment.left
        challenger.text = "Opponent"
        scoresView.addSubview(challenger)
    }
    
    func displayScore(score: Score) {
        /* Update the display with the given score */
        for i in 0..<score.playerScore.count {
            if (score.playerScore[i] == 45) {
                scoreCards.player[i].text = "AD"
                scoreCards.challenger[i].text = ""
            } else if (score.challengerScore[i] == 45) {
                scoreCards.player[i].text = ""
                scoreCards.challenger[i].text = "AD"
            } else {
                scoreCards.player[i].text = String(score.playerScore[i])
                scoreCards.challenger[i].text = String(score.challengerScore[i])
            }
        }
        
        if (score.playerIsServing) {
            denotePlayerIsServing()
        } else {
            denoteOpponentIsServing()
        }
    }
    
    func displayContestants(playerName: String, opponentName: String) {
        /* Update the display with the given contestant names */
        player.text = playerName
        challenger.text = opponentName
    }
    
    func displayTitle(titleName: String) {
        /* Update the display with the given match title */
        title.text = titleName
    }
    
    func denotePlayerIsServing() {
        /* Mark that the player is serving and that the opponent is not serving */
        /* TODO */
        player.textAlignment = NSTextAlignment.center
        challenger.textAlignment = NSTextAlignment.left
    }
    
    func denoteOpponentIsServing() {
        /* Mark that the opponent is serving and that the player is not serving */
        /* TODO */
        challenger.textAlignment = NSTextAlignment.center
        player.textAlignment = NSTextAlignment.left
    }
}
