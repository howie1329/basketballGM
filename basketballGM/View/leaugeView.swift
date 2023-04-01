//
//  leaugeView.swift
//  basketballGM
//
//  Created by Howard Thomas on 3/31/23.
//

import SwiftUI

struct leaugeView: View {
    @EnvironmentObject var model:DataModel
    var body: some View {
        VStack{
            List{
                ForEach(model.currentLeague.schedule, id:\.id){day in
                    Section(header:Text("\(day.dayNumber)")){
                        ForEach(day.scheduledGames, id:\.id){gamess in
                            if gamess.playedGame{
                                Text("\(gamess.homeTeam.name): \(gamess.homeScore) vs. \(gamess.awayTeam.name): \(gamess.awayScore)")
                            }else{
                                
                                HStack{
                                    Text("\(gamess.homeTeam.name) vs \(gamess.awayTeam.name)")
                                    Button {
                                        gamess.runGame()
                                        model.update()
                                    } label: {
                                        Image(systemName: "checkmark.circle")
                                    }
                                }
                                

                            }
                            
                        }
                    }
                }
            }
            .refreshable {
                model.update()
            }
        }
    }
}

struct leaugeView_Previews: PreviewProvider {
    static var previews: some View {
        leaugeView()
            .environmentObject(DataModel())
    }
}
