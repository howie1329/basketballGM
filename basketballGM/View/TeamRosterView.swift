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
            Text(currentTeam.name)
            List{
                ForEach(currentTeam.roster){item in
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
            }
        }
    }
}
