//
//  ContentView.swift
//  basketballGM
//
//  Created by Howard Thomas on 3/26/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var model: DataModel
    var body: some View {
        NavigationView{
            ZStack{
                VStack {
                    Text("Day Counter: \(model.currentLeague.currentDay) / \(model.currentLeague.endDay)")
                    List{
                        ForEach(model.currentLeague.teams){item in
                            NavigationLink {
                                TeamRosterView(currentTeam: item)
                            } label: {
                                VStack(alignment:.center){
                                    Text(item.name)
                                        .font(.headline)
                                    Text("\(item.winRecord) - \(item.loseRecord)")
                                    HStack{
                                        Text("Offense: \(item.offense)")
                                        Text("Defense: \(item.defense)")
                                        Text("Overall: \((item.offense + item.defense) / 2)")
                                    }
                                    .frame(maxWidth:.infinity)
                                }
                                
                            }
                        }
                    }
                    HStack{
                        Button{
                            model.currentLeague.playTodaysGames()
                            model.update()
                        } label: {
                            Text("Sim Day")
                                .frame(maxWidth:.infinity)
                        }
                        .buttonStyle(.borderedProminent)
                        .padding(.horizontal)
                        
                        Button{
                            model.currentLeague.simSeason()
                            model.update()
                        } label: {
                            Text("Sim Season")
                                .frame(maxWidth:.infinity)
                        }
                        .buttonStyle(.borderedProminent)
                        .padding(.horizontal)
                    }
                    
                }
                .onAppear(perform: {
                    model.update()
                })
                

            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(DataModel())
    }
}
