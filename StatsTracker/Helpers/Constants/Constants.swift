//
//  Constants.swift
//  StatsTracker
//
//  Created by Rachel Anderson on 4/10/20.
//  Copyright © 2020 Rachel Anderson. All rights reserved.
//

import Foundation

struct Constants {
    
    struct Titles {
        static let teamProfileTitle = "Team Profile"
        static let rosterTitle = "Roster"
        static let pullTitle = "Pull"
        static let gamesTitle = "Games"
        static let settingsTitle = "Settings"
        static let logout = "Log Out"
        static let edit = "Edit Team Profile"
        static let defaultTeamName = "Team Name"
        static let men = "Men"
        static let women = "Women"
        static let newPlayerTitle = "New Player"
        static let handler = "Handler"
        static let cutter = "Cutter"
        static let puller = "Puller"
        static let roles = "Player Role(s)"
        static let pointTitle = "Call a Line"
    }
    
    struct Alerts {
        static let logoutAlert = "Are you sure you want to log out?"
        static let dismiss = "Dismiss"
        static let cancel = "Cancel"
        static let confirm = "Confirm"
        static let startGameTitle = "Less than 7 players called"
        static let startGameAlert = "Are you sure you want to start the point without a full line?"
    }
    
    struct Empty {
        static let string = ""
        static let int = 0
        static let image = "defaultPhoto"
        static let teamName = "Team Name"
        static let email = "default@t.com"
    }
}
