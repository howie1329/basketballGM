//
//  gameModel.swift
//  basketballGM
//
//  Created by Howard Thomas on 3/27/23.
//

import Foundation

struct playerStats{
   
    var twoPointers = 0
    var threePointers = 0
    var totalPoints = 0
    
    init(twoPointers: Int = 0, threePointers: Int = 0) {
        self.twoPointers = twoPointers
        self.threePointers = threePointers
        self.totalPoints = (twoPointers * 2) + (threePointers * 3)
    }
    
    mutating func updatePoints(){
        totalPoints = (twoPointers * 2) + (threePointers * 3)
    }
    
    
}

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
    
    func runGame(){
        
        for item in homeTeam.roster{
            boxScore[item.id] = playerStats()
            boxScore[item.id] = playerStats()
        }
        for item in awayTeam.roster{
            boxScore[item.id] = playerStats()
            boxScore[item.id] = playerStats()
        }
        
        for _ in 1...100{
            homeScore += gamePossesions(offTeam: homeTeam, defTeam: awayTeam)
            awayScore += gamePossesions(offTeam: awayTeam, defTeam: homeTeam)
        }
        
        print("Game Finished: \n \(homeTeam.name): \(homeScore) \n \(awayTeam.name): \(awayScore)")
        print("HomeTeam: Off:\(homeTeam.offense) Def:\(homeTeam.defense) --- AwayTeam: Off:\(awayTeam.offense) Def:\(awayTeam.defense)")
        print("Home Team Stats")
        for player in homeTeam.roster{
            print("\(boxScore[player.id])\n \(player.insideShotRating) \(player.outsideShotRating) \n \(player.buildName)")
        }
        print("Away Team Stats")
        for player in awayTeam.roster{
            print("\(boxScore[player.id])\n \(player.insideShotRating) \(player.outsideShotRating) \n \(player.playerTends.insideShot) \(player.playerTends.outsideShot)")
        }
        /*for item in boxScore{
            for pl in homeTeam.roster{
                if pl.id == item.key{
                    print("HomeTeam... \(item)")
                }
            }
        }
        for item in boxScore{
            for pl in awayTeam.roster{
                if pl.id == item.key{
                    print("AwayTeam... \(item)")
                }
            }
        } */
    }
    
    func gamePossesions(offTeam: team, defTeam:team) -> Int{
        var offPlayer = offTeam.roster.randomElement()!
        var defPlayer = defTeam.roster.randomElement()!
        
        //print("oFF Player: \(offPlayer.offenseRating) defPlayer \(defPlayer.defensiveRating)")
        
        let offMove = getOffMove(offPlayer: offPlayer)
        let defMove = getDefMove(defPlayer: defPlayer, offMove: offMove.0)
        
        if offMove.1 > defMove{
            switch offMove.0{
            case "insideShot":
                boxScore[offPlayer.id]!.twoPointers += 1
                boxScore[offPlayer.id]!.updatePoints()
                return 2
            case "outsideShot":
                boxScore[offPlayer.id]!.threePointers += 1
                boxScore[offPlayer.id]!.updatePoints()
                return 3
            case "passToShot":
                return gamePossesions(offTeam: offTeam, defTeam: defTeam)
            default:
                return gamePossesions(offTeam: offTeam, defTeam: defTeam)
            }
        }
        return 0
        
        /*if offPlayer.offenseRating > defPlayer.defensiveRating {
            var choice = Int.random(in: 0...100)
            
            if offPlayer.playerTends.insideShot.contains(choice){
                if offPlayer.insideShotRating > defPlayer.insideDefense{
                    boxScore[offPlayer.id]!.twoPointers += 1
                    boxScore[offPlayer.id]!.updatePoints()
                    return 2
                }
                return 0
                
            }else if offPlayer.playerTends.outsideShot.contains(choice){
                if offPlayer.outsideShotRating > defPlayer.outsideDefense{
                    boxScore[offPlayer.id]!.threePointers += 1
                    boxScore[offPlayer.id]!.updatePoints()
                    return 3
                }
                return 0
            }
            return 0
        }
        return 0 */
    }
}

func getOffMove(offPlayer:player) -> (String, Int){
    let choice = Int.random(in: 0...100)
    switch choice{
    case offPlayer.playerTends.insideShot:
        return ("insideShot", offPlayer.insideShotRating)
    case offPlayer.playerTends.outsideShot:
        return ("outsideShot", offPlayer.outsideShotRating)
    case offPlayer.playerTends.passToShot:
        return ("passToShot", offPlayer.passRating)
    default:
        return getOffMove(offPlayer: offPlayer)
        
    }
}

func getDefMove(defPlayer:player, offMove:String) -> Int{
    
    switch offMove{
    case "insideShot":
        return defPlayer.insideDefense
    case "outsideShot":
        return defPlayer.outsideDefense
    case "passToShot":
        return defPlayer.defensiveRating
    default:
        return getDefMove(defPlayer: defPlayer, offMove: offMove)
    }
}



