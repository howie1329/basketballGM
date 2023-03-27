//
//  playerModel.swift
//  basketballGM
//
//  Created by Howard Thomas on 3/27/23.
//

import Foundation

class playerTend{
    
    var insideShot: Range<Int>
    var outsideShot: Range<Int>
    var passToShot: Range<Int>
    
    init(playerBuild:String){
        if playerBuild == "inside"{
            insideShot = 0..<85
            outsideShot = 85..<100
            passToShot  = 95..<100
        }else if playerBuild == "outside"{
            insideShot = 0..<35
            outsideShot = 35..<90
            passToShot  = 90..<100
        }else if playerBuild == "balanced"{
            insideShot = 0..<40
            outsideShot = 40..<80
            passToShot  = 80..<100
        }else if playerBuild == "point"{
            insideShot = 0..<40
            outsideShot = 40..<60
            passToShot = 60..<100
        }else{
            insideShot = 0..<50
            outsideShot = 50..<90
            passToShot  = 90..<100
        }
    }
}

class player{
    
    var id: UUID
    var offenseRating: Int
    var insideShotRating: Int
    var outsideShotRating: Int
    var passRating:Int
    var defensiveRating:Int
    var insideDefense:Int
    var outsideDefense:Int
    var playerName:String
    var playerTends: playerTend
    var buildName:String
    
    
    
    init(id: UUID, offenseRating: Int, insideShotRating: Int, outsideShotRating: Int,passRating:Int, defensiveRating: Int,insideDefense:Int,outsideDefense:Int, playerName: String) {
        self.id = id
        self.offenseRating = offenseRating
        self.insideShotRating = insideShotRating
        self.outsideShotRating = outsideShotRating
        self.passRating = passRating
        self.defensiveRating = defensiveRating
        self.playerName = playerName
        var choice = Int.random(in: 0...4)
        var build = buildFinder(choice: choice)
        self.buildName = build
        self.playerTends = playerTend(playerBuild: build)
        self.insideDefense = insideDefense
        self.outsideDefense = outsideDefense
    }
    
}

func buildFinder(choice:Int) -> String{
    switch choice{
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

func makePlayer(name:String) -> player{
    
    let id = UUID()
    let inside = Int.random(in: 1...99)
    let outside = Int.random(in: 1...99)
    let pass = Int.random(in: 1...99)
    let offense = (inside + outside) / 2
    let insideDefense = Int.random(in: 1...99)
    let outsideDefense = Int.random(in: 1...99)
    let defense = (insideDefense + outsideDefense) / 2
    
    return player(id: UUID(), offenseRating: offense, insideShotRating: inside, outsideShotRating: outside, passRating: pass, defensiveRating: defense,insideDefense: insideDefense,outsideDefense: outsideDefense, playerName: name)
}
