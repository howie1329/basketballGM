//
//  playerModel.swift
//  basketballGM
//
//  Created by Howard Thomas on 3/27/23.
//

import Foundation


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
    var buildName:String
    
    
    
    init(id: UUID, offenseRating: Int, insideShotRating: Int, outsideShotRating: Int,passRating:Int, defensiveRating: Int,insideDefense:Int,outsideDefense:Int, playerName: String, build:String) {
        self.id = id
        self.offenseRating = offenseRating
        self.insideShotRating = insideShotRating
        self.outsideShotRating = outsideShotRating
        self.passRating = passRating
        self.defensiveRating = defensiveRating
        self.playerName = playerName
        self.buildName = build
        self.insideDefense = insideDefense
        self.outsideDefense = outsideDefense
    }
    
}

func buildFinder() -> String{
    var randomNumber = Int.random(in: 0...4)
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

func makePlayer(name:String) ->player{
    let id = UUID()
    
    let build = buildFinder()
    
    switch build{
    case "outside":
        return player(id: id, offenseRating: Int.random(in: 0...100), insideShotRating: Int.random(in: 0...30), outsideShotRating: Int.random(in: 60...100), passRating: Int.random(in: 0...50), defensiveRating: Int.random(in: 0...75), insideDefense: Int.random(in: 0...35), outsideDefense: Int.random(in: 0...100), playerName: name, build: build)
    case "inside":
        return player(id: id, offenseRating: Int.random(in: 0...100), insideShotRating: Int.random(in: 60...100), outsideShotRating: Int.random(in: 0...30), passRating: Int.random(in: 0...20), defensiveRating: Int.random(in: 70...100), insideDefense: Int.random(in: 75...100), outsideDefense: Int.random(in: 50...100), playerName: name, build: build)
    case "balanced":
        return player(id: id, offenseRating: Int.random(in: 0...100), insideShotRating: Int.random(in: 25...75), outsideShotRating: Int.random(in: 25...75), passRating: Int.random(in: 25...75), defensiveRating: Int.random(in: 0...100), insideDefense: Int.random(in: 25...75), outsideDefense: Int.random(in: 25...75), playerName: name, build: build)
    case "point":
        return player(id: id, offenseRating: Int.random(in: 0...100), insideShotRating: Int.random(in: 25...40), outsideShotRating: Int.random(in: 30...85), passRating: Int.random(in: 70...100), defensiveRating: Int.random(in: 0...100), insideDefense: Int.random(in: 0...50), outsideDefense: Int.random(in: 30...100), playerName: name, build: build)
    default:
        return player(id: id, offenseRating: Int.random(in: 0...100), insideShotRating: Int.random(in: 25...75), outsideShotRating: Int.random(in: 25...75), passRating: Int.random(in: 25...75), defensiveRating: Int.random(in: 0...100), insideDefense: Int.random(in: 25...75), outsideDefense: Int.random(in: 25...75), playerName: name, build: build)
    }
    
}
