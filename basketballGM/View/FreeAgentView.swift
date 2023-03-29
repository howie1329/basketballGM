//
//  FreeAgentView.swift
//  basketballGM
//
//  Created by Howard Thomas on 3/29/23.
//

import SwiftUI

struct FreeAgentView: View {
    @EnvironmentObject var model:DataModel
    @State var newTeam:String = "Team 1"
    var body: some View {
        VStack{
            Text("Free Agents")
            Picker("New Team", selection: $newTeam) {
                ForEach(model.currentLeague.teams){
                    Text($0.name)
                        .tag($0.name)
                }
            }
            List{
                ForEach(model.currentLeague.freeAgents){player in
                    Button {
                        model.currentLeague.addFreeAgent(free: player, newTeam: newTeam)
                    } label: {
                        HStack{
                            Text(player.playerName)
                            Text("Off: \(player.offenseRating)")
                            Text("Def: \(player.defensiveRating)")
                            Text("\(player.buildName.capitalized)")
                        }
                        .frame(maxWidth:.infinity,alignment: .center)
                    }
                    
                    
                }
            }
        }
    }
}

struct FreeAgentView_Previews: PreviewProvider {
    static var previews: some View {
        FreeAgentView()
            .environmentObject(DataModel())
    }
}
