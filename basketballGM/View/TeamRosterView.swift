//
//  TeamRosterView.swift
//  basketballGM
//
//  Created by Howard Thomas on 3/27/23.
//

import SwiftUI

struct TeamRosterView: View {
    @EnvironmentObject var model:DataModel
    var currentTeam:team
    var body: some View {
        VStack{
            HStack{
                Text(currentTeam.name)
                Text("Cap Space: \(currentTeam.capRoom)")
            }
            List{
                ForEach(currentTeam.roster){item in
                    Button {
                        // Will push to player info view
                    } label: {
                        VStack{
                            Text(item.playerName)
                            HStack{
                                Text("Type: \(item.buildName.capitalized)")
                                Text("Offense: \(item.offenseRating)")
                                Text("Defense: \(item.defensiveRating)")
                            }
                            .frame(maxWidth:.infinity)
                        }
                    }
                    .swipeActions {
                        Button(role:.destructive) {
                            var index = currentTeam.roster.firstIndex { player in
                                player.id == item.id
                            }
                            currentTeam.releasePlayer(playerIndex: index!)
                        } label: {
                            Image(systemName: "x.circle")
                        }

                    }

                    
                    
                }
            }
            .onAppear {
                currentTeam.updateStats()
            }
        }
    }
}
