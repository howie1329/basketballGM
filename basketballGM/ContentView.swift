//
//  ContentView.swift
//  basketballGM
//
//  Created by Howard Thomas on 3/26/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundColor(.accentColor)
            Text("Hello, world!")
        }
        .onAppear(perform: {
            var league = makeLeague()
            league.showTeams()
            for _ in 0...5{
                league.setUpGames()
            }
            
            
            /*for team in league.teams{
                team.showRoster()
                print("-----------")
            } */
            
           /* for _ in 1...2{
                let team1 = makeTeam(name: "Warriors")
                let team2 = makeTeam(name:"Cavs")
                
                let game = game(homeTeam: team1, awayTeam: team2)
                game.runGame()
            } */
            
        })
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
