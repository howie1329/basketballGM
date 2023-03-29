//
//  playerModel.swift
//  basketballGM
//
//  Created by Howard Thomas on 3/27/23.
//

import Foundation

/// A class that represents a player
class player: Identifiable{
    
    /// ID: the unique id for each player
    var id: UUID
    /// Offenseive Rating
    var offenseRating: Int
    /// Inside Shot Rating - Effects shots made
    var insideShotRating: Int
    /// Outside Shot Rating - Effects threes made
    var outsideShotRating: Int
    /// Passing Rating - Effects Assist Number
    var passRating:Int
    /// Overall Defensive Rating
    var defensiveRating:Int
    /// Inside Defense
    var insideDefense:Int
    /// Outside Defense
    var outsideDefense:Int
    /// The player name
    var playerName:String
    /// Build of player
    var buildName:String
    var overallRating:Int
    var capHit:Int
    
    
    
    init(id: UUID, insideShotRating: Int, outsideShotRating: Int,passRating:Int, insideDefense:Int,outsideDefense:Int, playerName: String, build:String) {
        self.id = id
        self.offenseRating = (insideShotRating + outsideShotRating + passRating) / 3
        self.insideShotRating = insideShotRating
        self.outsideShotRating = outsideShotRating
        self.passRating = passRating
        self.defensiveRating = (insideDefense + outsideDefense) / 2
        self.playerName = playerName
        self.buildName = build
        self.insideDefense = insideDefense
        self.outsideDefense = outsideDefense
        self.overallRating = (self.offenseRating + self.defensiveRating) / 2
        self.capHit = findCapHit(playerOverall: self.overallRating)
    }
    
}

func findCapHit(playerOverall:Int) -> Int{
    
    switch playerOverall{
    case 0...25:
        return 1
    case 26...50:
        return 2
    case 51...80:
        return 3
    case 81...100:
        return 4
    default:
        return 1
    }
}

///  Take a random number between 1 - 4 and gives a String repesenting a build type
///
/// - Returns: A String which is equal to a build type
func buildFinder() -> String{
    /// Creates a random number to choice from
    var randomNumber = Int.random(in: 0...4)
    /// Takes random number and returns a string of a player build
    switch randomNumber{
    case 1:
        return "outside"
    case 2:
        return "inside"
    case 3:
        return "balanced"
    case 4:
        return "point"
    default:
        return "balanced"
    }
}

/// Creates a player
///
/// - Parameter name: A string that respsents a players name
/// - Returns: A new player class
func makePlayer(name:String) ->player{
    let id = UUID()
    
    /// takes  return of ``buildFinder()``  and uses result to find player and ratings
    let build = buildFinder()
    
    switch build{
    case "outside":
        return player(id: id, insideShotRating: Int.random(in: 0...50), outsideShotRating: Int.random(in: 75...100), passRating: Int.random(in: 0...65), insideDefense: Int.random(in: 0...50), outsideDefense: Int.random(in: 30...100), playerName: name, build: build)
    case "inside":
        return player(id: id, insideShotRating: Int.random(in: 75...100), outsideShotRating: Int.random(in: 0...50), passRating: Int.random(in: 0...30), insideDefense: Int.random(in: 75...100), outsideDefense: Int.random(in: 65...100), playerName: name, build: build)
    case "balanced":
        return player(id: id,  insideShotRating: Int.random(in: 25...100), outsideShotRating: Int.random(in: 25...100), passRating: Int.random(in: 25...100), insideDefense: Int.random(in: 25...100), outsideDefense: Int.random(in: 25...100), playerName: name, build: build)
    case "point":
        return player(id: id,  insideShotRating: Int.random(in: 25...40), outsideShotRating: Int.random(in: 30...85), passRating: Int.random(in: 70...100),  insideDefense: Int.random(in: 0...50), outsideDefense: Int.random(in: 30...100), playerName: name, build: build)
    default:
        return player(id: id,  insideShotRating: Int.random(in: 25...75), outsideShotRating: Int.random(in: 25...75), passRating: Int.random(in: 25...75), insideDefense: Int.random(in: 25...75), outsideDefense: Int.random(in: 25...75), playerName: name, build: build)
    }
    
}
