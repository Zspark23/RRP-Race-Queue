//
//  Race.swift
//  RRP Race Queue
//
//  Created by Zack Spicer on 12/2/16.
//  Copyright © 2016 Zack Spicer. All rights reserved.
//

import Foundation

class Race {
    
    let id: String?
    let trackId: String?
    let track: String?
    let startsAtDate: String?
    let heatTypeId: String?
    let heatStatusId: String?
    let speedLevelId: String?
    let speedLevel: String?
    let winBy: String?
    let raceBy: String?
    let duration: String?
    let raceName: String?
    let startsAtIso: String?
    let raceNumber: String?
    var racers: [Racer]
    
    init() {
        id = nil
        trackId = nil
        track = nil
        startsAtDate = nil
        heatTypeId = nil
        heatStatusId = nil
        speedLevelId = nil
        speedLevel = nil
        winBy = nil
        raceBy = nil
        duration = nil
        raceName = nil
        startsAtIso = nil
        raceNumber = nil
        racers = []
    }
    
    
    init(dictionary: [String : Any]) {
        id = dictionary["id"] as? String ?? nil
        trackId = dictionary["track_id"] as? String ?? nil
        track = dictionary["track"] as? String ?? nil
        startsAtDate = dictionary["starts_at"] as? String ?? nil
        heatTypeId = dictionary["heat_type_id"] as? String ?? nil
        heatStatusId = dictionary["heat_status_id"] as? String ?? nil
        speedLevelId = dictionary["speed_level_id"] as? String ?? nil
        speedLevel = dictionary["speed_level"] as? String ?? nil
        winBy = dictionary["win_by"] as? String ?? nil
        raceBy = dictionary["race_by"] as? String ?? nil
        duration = dictionary["duration"] as? String ?? nil
        raceName = dictionary["race_name"] as? String ?? nil
        startsAtIso = dictionary["starts_at_iso"] as? String ?? nil
        raceNumber = dictionary["race_number"] as? String ?? nil
        racers = []
        
        let tempRacersArray = dictionary["racers"] as? [String : Any] ?? nil
        for r in tempRacersArray?["racers"] as! [Any] {
            self.racers.append(Racer(dictionary: r as! [String : Any]))
        }
        
    }
}
