//
//  Racer.swift
//  RRP Race Queue
//
//  Created by Zack Spicer on 12/2/16.
//  Copyright © 2016 Zack Spicer. All rights reserved.
//

import Foundation

class Racer {
    
    let racerId: String?
    let finishPosition: String?
    let kartNum: String?
    let racerName: String?
    let firstName: String?
    let lastName: String?
    let rpm: String?
    let fastestLap: String?
    let lastLap: String?
    let createdAtDate: String?
    let numVisits: String?
    let numRaces: String?
    
    // Creates a blank racer with no values in any variable
    init() {
        racerId = nil
        finishPosition = nil
        kartNum = nil
        racerName = nil
        firstName = nil
        lastName = nil
        rpm = nil
        fastestLap = nil
        lastLap = nil
        createdAtDate = nil
        numVisits = nil
        numRaces = nil
    }
    
    // Creates a racer from a dictionary passed in (usually parsed JSON from an API call)
    init(dictionary: [String : Any]) {
        racerId = dictionary["id"] as? String ?? nil
        finishPosition = dictionary["position"] as? String ?? nil
        kartNum = dictionary["kart_num"] as? String ?? nil
        racerName = dictionary["nickname"] as? String ?? nil
        firstName = dictionary["first_name"] as? String ?? nil
        lastName = dictionary["last_name"] as? String ?? nil
        rpm = dictionary["rpm"] as? String ?? nil
        fastestLap = dictionary["fastest_lap_time"] as? String ?? nil
        lastLap = dictionary["last_lap_time"] as? String ?? nil
        createdAtDate = dictionary["created_at"] as? String ?? nil
        numVisits = dictionary["visits"] as? String ?? nil
        numRaces = dictionary["races"] as? String ?? nil
    }
    
    // Returns the full name of the racer as an optional in case there is a problem getting 
    // their first/last name
    func fullName() -> String? {
        return "\(firstName!) \(lastName!)"
    }
}
