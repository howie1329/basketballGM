//
//  leaugeView.swift
//  basketballGM
//
//  Created by Howard Thomas on 3/31/23.
//

import SwiftUI

struct leaugeView: View {
    @EnvironmentObject var model:DataModel
    @State var gamePlayError = false
    var body: some View {
        VStack{
            Text("Day Counter: \(model.currentLeague.currentDay) / \(model.currentLeague.endDay)")
            if gamePlayError == true{
                Text("Game Can't Be Played Until Later")
            }
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
                                        if day.dayNumber == model.currentLeague.currentDay{
                                            gamess.runGame()
                                            gamePlayError = false
                                            model.update()
                                        }else{
                                            gamePlayError = true
                                        }
                                        
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
