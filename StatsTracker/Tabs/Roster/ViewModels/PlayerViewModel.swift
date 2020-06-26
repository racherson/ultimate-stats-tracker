//
//  PlayerViewModel.swift
//  StatsTracker
//
//  Created by Rachel Anderson on 5/5/20.
//  Copyright © 2020 Rachel Anderson. All rights reserved.
//

import Foundation

struct PlayerViewModel {
    
    //MARK: Properties
    let model: PlayerModel
    
    var name: String {
        return model.name
    }
    
    var gender: Gender {
        return Gender(rawValue: model.gender)!
    }
    
    var roles: String {
        let roles = model.roles.map{ Roles(rawValue: $0)! }
        let rolesTitles = roles.map{ $0.description }
        return rolesTitles.joined(separator: ", ")
    }
    
    var games: String {
        return String(model.games)
    }
    
    var points: String {
        return String(model.points)
    }
    
    var completions: String {
        return String(model.completions)
    }
    
    var throwaways: String {
        return String(model.throwaways)
    }
    
    var catches: String {
        return String(model.catches)
    }
    
    var drops: String {
        return String(model.drops)
    }
    
    var goals: String {
        return String(model.goals)
    }
    
    var assists: String {
        return String(model.assists)
    }
    
    var ds: String {
        return String(model.ds)
    }
    
    var pulls: String {
        return String(model.pulls)
    }
    
    var callahans: String {
        return String(model.callahans)
    }
    
    //MARK: Calculated Stats
    var catchingPercentage: String {
        if model.catches + model.drops > 0 {
            let percentNum = model.catches / (model.catches + model.drops)
            return String(percentNum)
        }
        return String(0)
    }
    
    var completionPercentage: String {
        if model.completions + model.throwaways > 0 {
            let percentNum = model.completions / (model.completions + model.throwaways)
            return String(percentNum)
        }
        return String(0)
    }
}

extension PlayerViewModel {
    func addGoal() {
        model.addGoal()
    }
}