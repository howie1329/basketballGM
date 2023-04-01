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
                ForEach(model.currentLeague.schedule, id:\.dayNumber){day in
                    Section(header:Text("\(day.dayNumber)")){
                        ForEach(day.scheduledGames){gamess in
                            Text("\(gamess.homeTeam.name) vs \(gamess.awayTeam.name)")
                        }
                    }
                }
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
