//
//  GameView.swift
//  basketballGM
//
//  Created by Howard Thomas on 3/28/23.
//

import SwiftUI

struct GameView: View {
    @EnvironmentObject var model:DataModel
    @State var homeTeam:String = "Team 1"
    @State var awayTeam:String = "Team 2"
    @State var team1:team? = nil
    @State var team2:team? = nil
    @State var gameStats:([UUID:playerStats], Int, Int)? = nil
    var body: some View {
        VStack{
            HStack{
                Section(header:Text("Home Team")){
                    Picker("homeTeam", selection: $homeTeam) {
                        ForEach(model.currentLeague.teams){
                            Text($0.name)
                                .tag($0.name)
                        }
                    }
                }
                Section(header:Text("Away Team")){
                    Picker("AwayTeam",selection: $awayTeam){
                        ForEach(model.currentLeague.teams){
                            Text($0.name)
                                .tag($0.name)
                        }
                    }
                }
            }
            if let gameStats = gameStats{
                VStack{
                    Section(header:Text("HomeScore: \(gameStats.1)")){
                        List{
                            ForEach(team1!.roster){player in
                                VStack{
                                    Text("Total: \(gameStats.0[player.id]!.totalPoints)")
                                    Text("Twos: \(gameStats.0[player.id]!.twoPointers)")
                                    Text("Threes: \(gameStats.0[player.id]!.threePointers)")
                                    Text("Assist: \(gameStats.0[player.id]!.assist)")
                                }
                                
                            }
                        }
                    }
                    Section(header:Text("AwayScore: \(gameStats.2)")){
                        List{
                            ForEach(team2!.roster){player in
                                VStack{
                                    Text("Total: \(gameStats.0[player.id]!.totalPoints)")
                                    Text("Twos: \(gameStats.0[player.id]!.twoPointers)")
                                    Text("Threes: \(gameStats.0[player.id]!.threePointers)")
                                    Text("Assist: \(gameStats.0[player.id]!.assist)")
                                }
                                
                            }
                        }
                    }
                }
            }
            
            Button {
                team1 = model.currentLeague.teams.first { team in
                    team.name == homeTeam
                    
                }
                
                team2 = model.currentLeague.teams.first { team in
                    team.name == awayTeam
                }
                
                gameStats = model.currentLeague.customGameSim(team1: team1!, team2: team2!)
            } label: {
                Text("Play Game")
            }

        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
            .environmentObject(DataModel())
    }
}
