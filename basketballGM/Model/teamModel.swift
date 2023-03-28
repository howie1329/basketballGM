//
//  teamModel.swift
//  basketballGM
//
//  Created by Howard Thomas on 3/27/23.
//

import Foundation

class team: Identifiable{
    
    var name:String
    var offense:Int
    var defense:Int
    var passing:Int
    var insideScoring: Int
    var outsideScoring: Int
    var insideDefense:Int
    var outsideDefense:Int
    var roster: [player]
    
    
    
    init(name: String, offense: Int, defense: Int, passing: Int, insideScoring: Int, outsideScoring: Int, insideDefense: Int, outsideDefense: Int, roster: [player]) {
        self.name = name
        self.offense = offense
        self.defense = defense
        self.passing = passing
        self.insideScoring = insideScoring
        self.outsideScoring = outsideScoring
        self.insideDefense = insideDefense
        self.outsideDefense = outsideDefense
        self.roster = roster
    }
    
    func showRoster(){
        for player in roster{
            print(player.playerName)
            print(player.buildName)
            print(player.offenseRating)
            print(player.defensiveRating)
        }
    }
}

func makeTeam(name:String) -> team{
    
    var tempRoster = [player]()
    var offenseTeamRating = 0
    var defenseTeamRating = 0
    var passing = 0
    var insideScoring = 0
    var outsideScoring = 0
    var insideDefense = 0
    var outsideDefense = 0
    
    for i in 1...5{
        let tempPlayer = makePlayer(name: "Player \(i)")
        tempRoster.append(tempPlayer)
    }
    
    for item in tempRoster{
        offenseTeamRating += item.offenseRating
        defenseTeamRating += item.defensiveRating
        passing += item.passRating
        insideScoring += item.insideShotRating
        outsideScoring += item.outsideShotRating
        insideDefense += item.insideDefense
        outsideDefense += item.outsideDefense
    }

    
    offenseTeamRating = offenseTeamRating/5
    defenseTeamRating = defenseTeamRating/5
    passing = passing/5
    insideScoring = insideScoring / 5
    outsideScoring = outsideScoring / 5
    insideDefense = insideDefense / 5
    outsideDefense = outsideDefense / 5
    
    return team(name: name, offense: offenseTeamRating, defense: defenseTeamRating,passing: passing,insideScoring: insideScoring,outsideScoring: outsideScoring, insideDefense: insideDefense,outsideDefense: outsideDefense, roster: tempRoster)
    
}
