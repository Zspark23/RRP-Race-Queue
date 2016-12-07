//
//  Racer.swift
//  RRP Race Queue
//
//  Created by Zack Spicer on 12/2/16.
//  Copyright © 2016 Zack Spicer. All rights reserved.
//

import Foundation

class Racer {
    
    let finishPosition: String?
    let kartNum: String?
    let racerName: String?
    let firstName: String?
    let lastName: String?
    let rpm: String?
    let fastestLap: String?
    let lastLap: String?
    
    init(dictionary: [String : Any]) {
        
        if let finishPosition = dictionary["position"] {
            self.finishPosition = finishPosition as? String
        } else {
            self.finishPosition = nil
        }
        
        if let kartNum = dictionary["kart_num"] {
            self.kartNum = kartNum as? String
        } else {
            self.kartNum = nil
        }
        
        if let racerName = dictionary["nickname"] {
            self.racerName = racerName as? String
        } else {
            self.racerName = nil
        }
        
        if let firstName = dictionary["first_name"] {
            self.firstName = firstName as? String
        } else {
            self.firstName = nil
        }
        
        if let lastName = dictionary["last_name"] {
            self.lastName = lastName as? String
        } else {
            self.lastName = nil
        }
        
        if let rpm = dictionary["rpm"] {
            self.rpm = rpm as? String
        } else {
            self.rpm = nil
        }
        
        if let fastestLap = dictionary["fastest_lap_time"] {
            self.fastestLap = fastestLap as? String
        } else {
            self.fastestLap = nil
        }
        
        if let lastLap = dictionary["last_lap_time"] {
            self.lastLap = lastLap as? String
        } else {
            self.lastLap = nil
        }
    }
    
    func fullName() -> String? {
        return "\(firstName!) \(lastName!)"
    }
}
