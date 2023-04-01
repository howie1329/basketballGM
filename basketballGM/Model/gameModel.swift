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
class game: Identifiable, ObservableObject{
    
    var id:UUID
    @Published var homeScore:Int
    @Published var awayScore:Int
    var homeTeam:team
    var awayTeam:team
    @Published var boxScore: [UUID:playerStats]
    @Published var playedGame:Bool = false
    
    init(homeTeam: team, awayTeam: team) {
        id = UUID()
        homeScore = 0
        awayScore = 0
        boxScore = [:]
        self.homeTeam = homeTeam
        self.awayTeam = awayTeam
    }
    
    func getPossession(offTeam:team, defTeam:team) -> Int{
        var offPlayer = offTeam.roster.randomElement()!
        var defPlayer = defTeam.roster.randomElement()!
        
        var choice = Int.random(in: 0...2)
        
        switch choice {
        case 0:
            if offPlayer.insideShotRating > defPlayer.insideDefense{
                boxScore[offPlayer.id]?.twoPointers += 1
                boxScore[offPlayer.id]?.updatePoints()
                return 2
            }
        case 1:
            if offPlayer.outsideShotRating > defPlayer.outsideShotRating{
                boxScore[offPlayer.id]?.threePointers += 1
                boxScore[offPlayer.id]?.updatePoints()
                return 3
            }
        case 2:
            if offPlayer.passRating > defPlayer.defensiveRating{
                var res = getPossession(offTeam: offTeam, defTeam: defTeam)
                if res > 0{
                    boxScore[offPlayer.id]?.assist += 1
                    boxScore[offPlayer.id]?.updatePoints()
                }
            }
        default:
            getPossession(offTeam: offTeam, defTeam: defTeam)
        }
        return 0
    }
    
    func updateRecord(){
        if homeScore > awayScore{
            homeTeam.winRecord += 1
            awayTeam.loseRecord += 1
        }else{
            awayTeam.winRecord += 1
            homeTeam.loseRecord += 1
        }
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
        
        for _ in 0...100{
            homeScore += getPossession(offTeam: homeTeam, defTeam: awayTeam)
            awayScore += getPossession(offTeam: awayTeam, defTeam: homeTeam)
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
        
        playedGame = true
        updateRecord()
        
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



