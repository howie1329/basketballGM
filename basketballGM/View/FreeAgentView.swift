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
    @State var freeAgentBool = true
    var body: some View {
        VStack{
            Text("Free Agents")
            HStack{
                Picker("New Team", selection: $newTeam) {
                    ForEach(model.currentLeague.teams){
                        Text($0.name)
                            .tag($0.name)
                    }
                }
                
                if freeAgentBool == false{
                    Text("Player Could Not Be Added")
                    Text("Not Enough Cap Room")
                }
            }
            
            List{
                ForEach(model.currentLeague.freeAgents){player in
                    Button {
                       freeAgentBool = model.currentLeague.addFreeAgent(free: player, newTeam: newTeam)
                    } label: {
                        VStack{
                            HStack{
                                Text(player.playerName)
                                Text("Cap Hit: \(player.capHit)")
                            }
                            HStack{
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
}

struct FreeAgentView_Previews: PreviewProvider {
    static var previews: some View {
        FreeAgentView()
            .environmentObject(DataModel())
    }
}
