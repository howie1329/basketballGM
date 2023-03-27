//
//  leagueModel.swift
//  basketballGM
//
//  Created by Howard Thomas on 3/27/23.
//

import Foundation

class league{
    var teams: [team]
    var games:[game]
    
    init(teams: [team]) {
        self.teams = teams
        self.games = [game]()
    }
    
    func showTeams(){
        for team in teams{
            print(team.name)
        }
    }
    
    func setUpGames(){
        var team1 = teams[Int.random(in: 0...10)]
        var team2 = teams[Int.random(in: 0...10)]
        if team1.name != team2.name{
            var game = game(homeTeam: team1, awayTeam: team2)
            game.runGame()
        }else{
            setUpGames()
        }
    }
    
    
}

func makeLeague() -> league{
    var tempTeamArr = [team]()
    
    for i in 1...10{
        var team = makeTeam(name: "Team \(i)")
        tempTeamArr.append(team)
    }
    
    return league(teams: tempTeamArr)
}


