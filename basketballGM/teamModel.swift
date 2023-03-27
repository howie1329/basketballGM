//
//  teamModel.swift
//  basketballGM
//
//  Created by Howard Thomas on 3/27/23.
//

import Foundation

class team{
    
    var name:String
    var offense:Int
    var defense:Int
    var roster: [player]
    
    init(name: String, offense: Int, defense: Int, roster: [player]) {
        self.name = name
        self.offense = offense
        self.defense = defense
        self.roster = roster
    }
}

func makeTeam(name:String) -> team{
    
    var tempRoster = [player]()
    var offenseTeamRating = 0
    var defenseTeamRating = 0
    
    for _ in 1...5{
        var tempPlayer = makePlayer(name: name)
        tempRoster.append(tempPlayer)
    }
    
    for item in tempRoster{
        offenseTeamRating += item.offenseRating
        defenseTeamRating += item.defensiveRating
    }

    
    offenseTeamRating = offenseTeamRating/5
    defenseTeamRating = defenseTeamRating/5
    
    return team(name: name, offense: offenseTeamRating, defense: defenseTeamRating, roster: tempRoster)
    
}
