//
//  TabView.swift
//  basketballGM
//
//  Created by Howard Thomas on 3/28/23.
//

import SwiftUI

struct MainTabView: View {
    @EnvironmentObject var model:DataModel
    var body: some View {
        TabView{
            ContentView()
                .tabItem {
                    Image(systemName: "house")
                }
            GameView()
                .tabItem {
                    Image(systemName: "basketball")
                }
            FreeAgentView()
                .tabItem {
                    Image(systemName: "basket")
                    Text("Free Agents")
                }
            leaugeView()
                .tabItem {
                    Image(systemName: "list.bullet")
                    Text("Schedule")
                }
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
            .environmentObject(DataModel())
    }
}
