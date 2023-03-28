//
//  DataModel.swift
//  basketballGM
//
//  Created by Howard Thomas on 3/27/23.
//

import Foundation

class DataModel: ObservableObject {
    
    var currentLeague: league
    
    init(){
        currentLeague = makeLeague()
    }
    
    
}
