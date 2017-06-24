//
//  PlayerUtils.swift
//  CrowdScore
//
//  Created by Steven Zheng on 6/3/17.
//  Copyright © 2017 szzheng. All rights reserved.
//

import Foundation
import UIKit

class Player {
    var name : String!
    var picture : UIImage!
    
    var aces : Int!
    var wins : Int!
    var position: Int!
    
    init(name: String = "Arya Stark", picture: UIImage = UIImage(named: "Arya Stark.jpg")!, aces: Int = 0, wins: Int = 0, position: Int = Int.max) {
        
        self.name = name
        self.picture = picture
        
        self.aces = aces
        self.wins = wins
        self.position = position
    }
}

enum PlayerDescriptor {
    case aces
    case wins
    case position
}

/* Player comparators */
func sorterForAces(this:Player, that:Player) -> Bool {
    return this.aces > that.aces
}

func sorterForWins(this:Player, that:Player) -> Bool {
    return this.wins > that.wins
}

func sorterForPosition(this:Player, that:Player) -> Bool {
    return this.position < that.position
}
/* END - Player comparators */
