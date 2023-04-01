//
//  leagueModel.swift
//  basketballGM
//
//  Created by Howard Thomas on 3/27/23.
//

import Foundation

struct days:Identifiable{
    
    var id: UUID
    var dayNumber:Int
    var scheduledGames:[game]
}

/// League class which holds an array of teams and a array of games
class league: ObservableObject{
    var teams: [team]
    var games:[game]
    var freeAgents:[player]
    var currentDay:Int
    var endDay:Int
    @Published var schedule: [days] = []
    
    init(teams: [team], freeAgent: [player] = []) {
        self.teams = teams
        self.games = [game]()
        self.freeAgents = freeAgent
        currentDay = 0
        endDay = 0
        setSchedule()
    }
    
    func showTeams(){
        for team in teams{
            print(team.name)
        }
    }
    
    func playTodaysGames(){
        if currentDay != endDay{
            var todaysGames = schedule[currentDay].scheduledGames
            
            for g in todaysGames{
                if g.playedGame == false{
                    g.runGame()
                }
            }
            currentDay += 1
        }else{
            setSchedule()
        }
    }
    
    func simSeason(){
        if currentDay != endDay{
            for i in currentDay..<endDay{
                print("test \(i)")
                var todaysGames = schedule[i].scheduledGames
                for g in todaysGames{
                    if g.playedGame == false{
                        g.runGame()
                    }
                }
                currentDay += 1
            }
        }
        else{
            setSchedule()
        }
    }
    
    func setSchedule(){
        var newDay:[days] = []
        for day in 0...72{
            var dayGame:[game] = []
            var finalDay:days = days(id: UUID(), dayNumber: 0, scheduledGames: [])
            for games in 0...10{
                var newGame = setUpGames()
                dayGame.append(newGame)
                finalDay = days(id: UUID(), dayNumber: day, scheduledGames: dayGame)
            }
            newDay.append(finalDay)
        }
        schedule = newDay
        currentDay = 0
        endDay = schedule.count
        
        
        for schGame in schedule{
            print("Day:\(schGame.dayNumber) \(schGame.scheduledGames)")
        }
    }
    
    /// Takes two random teams and runs a game agaisnt each other
    func setUpGames() -> game{
        let team1 = teams[Int.random(in: 0..<teams.count)]
        let team2 = teams[Int.random(in: 0..<teams.count)]
        if team1.name != team2.name{
            let games = game(homeTeam: team1, awayTeam: team2)
            return games
            //game.runGame()
        }else{
            return setUpGames()
        }
    }
    /// Takes two teams and runs a game against eachother
    /// - Parameter team1: takes the first team
    /// - Parameter team2: takes in the second team must be different then first team
    /// - Returns: A tuple with an array of UUID:player stats, homescore, and awayscore
    func customGameSim(team1:team,team2:team) -> ([UUID:playerStats], Int ,Int){
        let game = game(homeTeam: team1, awayTeam: team2)
        let value = game.runGame()
        
        return value
    }
    
    func addFreeAgent(free:player, newTeam:String)-> Bool{
        let index = freeAgents.firstIndex { player in
            player.id == free.id
        }
        let teamIndex = teams.firstIndex { team in
            team.name == newTeam
        }
        let team = teams[teamIndex!]
        let teamCapSpace = team.capRoom
        if (teamCapSpace - free.capHit) >= 0{
            freeAgents.remove(at: index!)
            team.roster.append(free)
            team.updateStats()
            return true
        }else{
            return false
        }
        
    }
}

/// Creates a new league
/// - Returns: League
func makeLeague() -> league{
    var tempTeamArr = [team]()
    var tempAgents = [player]()
    
    for i in 1...30{
        var team = makeTeam(name: "Team \(i)")
        tempTeamArr.append(team)
    }
    
    for i in 1...200{
        var agent = makePlayer(name: "FreeAgent \(i)")
        tempAgents.append(agent)
        
    }
    
    
    return league(teams: tempTeamArr, freeAgent: tempAgents)
}


