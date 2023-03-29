//
//  gameModel.swift
//  basketballGM
//
//  Created by Howard Thomas on 3/27/23.
//

import Foundation

/// Holds player stats
struct playerStats{
    
    /// Two pointers made
    var twoPointers = 0
    /// Three pointers made
    var threePointers = 0
    /// holds total points  - ``twoPointers`` * ``threePointers``
    var totalPoints = 0
    /// Assists
    var assist = 0
    
    init(twoPointers: Int = 0, threePointers: Int = 0, assist:Int = 0) {
        self.twoPointers = twoPointers
        self.threePointers = threePointers
        self.assist = assist
        self.totalPoints = (twoPointers * 2) + (threePointers * 3)
    }
    
    /// Updates total points
    mutating func updatePoints(){
        totalPoints = (twoPointers * 2) + (threePointers * 3)
    }
    
    
}

/// Game class
///  - Holds home and away teams and handles simulation of game
class game{
    
    var homeScore:Int
    var awayScore:Int
    var homeTeam:team
    var awayTeam:team
    var boxScore: [UUID:playerStats]
    
    init(homeTeam: team, awayTeam: team) {
        homeScore = 0
        awayScore = 0
        boxScore = [:]
        self.homeTeam = homeTeam
        self.awayTeam = awayTeam
    }
    
    /// Simulate game
    ///
    /// - Returns:  A tuple that includes an array that holds all players UUID and playerStats, homeScore, awayScore
    func runGame() -> ([UUID:playerStats], Int , Int){
        
        for item in homeTeam.roster{
            boxScore[item.id] = playerStats()
            boxScore[item.id] = playerStats()
        }
        for item in awayTeam.roster{
            boxScore[item.id] = playerStats()
            boxScore[item.id] = playerStats()
        }
        
        
        for player in homeTeam.roster{
            boxScore[player.id] = findPlayerBoxScore(offTeam: homeTeam, defTeam: awayTeam, player: player)
            homeScore += boxScore[player.id]!.totalPoints
        }
        for player in awayTeam.roster{
            boxScore[player.id] = findPlayerBoxScore(offTeam: awayTeam, defTeam: homeTeam, player: player)
            awayScore += boxScore[player.id]!.totalPoints
        }
        
        print("Game Finished: \n \(homeTeam.name): \(homeScore) \n \(awayTeam.name): \(awayScore)")
        print("HomeTeam: Off:\(homeTeam.offense) Def:\(homeTeam.defense) --- AwayTeam: Off:\(awayTeam.offense) Def:\(awayTeam.defense)")
        print("Home Team Stats")
        for player in homeTeam.roster{
            print("\(boxScore[player.id])\n \(player.insideShotRating) \(player.outsideShotRating) \n \(player.buildName)")
        }
        print("Away Team Stats")
        for player in awayTeam.roster{
            print("\(boxScore[player.id])\n \(player.insideShotRating) \(player.outsideShotRating)")
        }
        
        return (boxScore , homeScore ,awayScore)
        
    }
}

/// Takes players ratings and finds stat for a game
///
/// - Parameter offTeam: takes in offense team on possesion
/// - Parameter defTeam: takes in Defensive team on possesion
/// - Parameter player:  Takes a player for creating box score for
/// - Returns: playerStats
func findPlayerBoxScore(offTeam: team,defTeam:team,player: player) -> playerStats{
    let insideFieldGoal = (player.insideShotRating + offTeam.passing - defTeam.insideDefense) / 10
    let outsideFieldGoal = (player.outsideShotRating + offTeam.passing - defTeam.outsideDefense) / 11
    let assistValue = (player.passRating + offTeam.insideScoring + offTeam.outsideScoring - defTeam.insideDefense - defTeam.outsideDefense) / 10
    
    let inside = insideFieldGoal > 0 ? insideFieldGoal : 0
    let outside = outsideFieldGoal > 0 ? outsideFieldGoal : 0
    let assist = assistValue > 0 ? assistValue : 0
    
    print("\(inside) \(outside) \(assist)")
    
    return playerStats(twoPointers: inside,threePointers: outside,assist: assist)
}



