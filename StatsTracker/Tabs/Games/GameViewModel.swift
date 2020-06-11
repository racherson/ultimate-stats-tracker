//
//  GameViewModel.swift
//  StatsTracker
//
//  Created by Rachel Anderson on 6/9/20.
//  Copyright © 2020 Rachel Anderson. All rights reserved.
//

import Foundation

struct GameViewModel {
    
    //MARK: Properties
    let model: GameDataModel
    
    var tournament: String {
        return String(model.tournament)
    }
    
    var opponent: String {
        return String(model.opponent)
    }
    
    var finalScore: String {
        return String(model.finalScore.team) + "-" + String(model.finalScore.opponent)
    }
    
    // TODO: more computed stats
}
