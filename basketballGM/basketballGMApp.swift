//
//  basketballGMApp.swift
//  basketballGM
//
//  Created by Howard Thomas on 3/26/23.
//

import SwiftUI

@main
struct basketballGMApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(DataModel())
        }
    }
}
