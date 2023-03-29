//
//  teamModel.swift
//  basketballGM
//
//  Created by Howard Thomas on 3/27/23.
//

import Foundation

/// A team class
class team: Identifiable{
    
    var name:String
    /// Offensive Ratings for Team
    var offense:Int
    var defense:Int
    var passing:Int
    var insideScoring: Int
    var outsideScoring: Int
    /// Defensive Rating for Team
    var insideDefense:Int
    var outsideDefense:Int
    /// Roster of team... an array filled with ``player`` classes
    var roster: [player]
    var capRoom: Int
    
    
    
    init(name: String, offense: Int, defense: Int, passing: Int, insideScoring: Int, outsideScoring: Int, insideDefense: Int, outsideDefense: Int, roster: [player], capRoom:Int) {
        self.name = name
        self.offense = offense
        self.defense = defense
        self.passing = passing
        self.insideScoring = insideScoring
        self.outsideScoring = outsideScoring
        self.insideDefense = insideDefense
        self.outsideDefense = outsideDefense
        self.roster = roster
        self.capRoom = capRoom
    }
    
    /// prints ``roster`` to the console
    func showRoster(){
        for player in roster{
            print(player.playerName)
            print(player.buildName)
            print(player.offenseRating)
            print(player.defensiveRating)
        }
    }
    
    func updateStats(){
        
        var totalOffense = 0
        var totalDefense = 0
        var totalPassing = 0
        var totalInside = 0
        var totalOutside = 0
        var totalInsideDef = 0
        var totalOutsideDef = 0
        
        for player in roster{
            totalOffense += player.offenseRating
            totalDefense += player.defensiveRating
            totalPassing += player.passRating
            totalInside += player.insideShotRating
            totalOutside += player.outsideShotRating
            totalInsideDef += player.insideDefense
            totalOutsideDef += player.outsideDefense
        }
        self.passing = totalPassing / roster.count
        self.insideScoring = totalInside / roster.count
        self.outsideScoring = totalOutside / roster.count
        self.insideDefense = totalInsideDef / roster.count
        self.outsideDefense = totalOutsideDef / roster.count
        
        self.offense = totalOffense / roster.count
        self.defense = totalDefense / roster.count
        
        print("Total Offense: \(totalOffense)")
        print("Total Defense: \(totalDefense)")
        print("Roster Count: \(roster.count)")
        print(" NEW OFFENSE: \(offense)")
        
        
    }
}
/// Creates a team
///
/// - Parameter name : takes a name for the team
/// - Returns: a team class
func makeTeam(name:String) -> team{
    
    var tempRoster = [player]()
    var offenseTeamRating = 0
    var defenseTeamRating = 0
    var passing = 0
    var insideScoring = 0
    var outsideScoring = 0
    var insideDefense = 0
    var outsideDefense = 0
    var capSpace = 14
    
    for i in 1...5{
        var tempCap = capSpace
        let tempPlayer = makePlayer(name: "Player \(i)")
        if (tempCap - tempPlayer.capHit) > 0{
            tempRoster.append(tempPlayer)
            capSpace = capSpace - tempPlayer.capHit
            print("\(name): Current Cap: \(capSpace) New Player: \(tempPlayer.capHit) Roster Size:\(tempRoster.count)")
        }else{
            makeTeam(name: name)
        }
        
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
    
    
    
    return team(name: name, offense: offenseTeamRating, defense: defenseTeamRating,passing: passing,insideScoring: insideScoring,outsideScoring: outsideScoring, insideDefense: insideDefense,outsideDefense: outsideDefense, roster: tempRoster, capRoom: capSpace)
    
}
