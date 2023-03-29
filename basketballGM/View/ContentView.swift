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
            VStack {
                List{
                    ForEach(model.currentLeague.teams){item in
                        NavigationLink {
                            TeamRosterView(currentTeam: item)
                        } label: {
                            VStack(alignment:.center){
                                Text(item.name)
                                    .font(.headline)
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
            }
            .onAppear(perform: {
                model.update()
            })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(DataModel())
    }
}
