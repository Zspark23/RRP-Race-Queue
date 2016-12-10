//
//  NetworkController.swift
//  RRP Race Queue
//
//  Created by Zack Spicer on 12/2/16.
//  Copyright © 2016 Zack Spicer. All rights reserved.
//

import Foundation

private let apiKey = "VaeqiShEf3nbUnawWkEw"

class NetworkController {
    
    static let sharedInstance = NetworkController()
    private init() {}
    
    // The base URL for the clubspeed API
    private func baseURL() -> String {
        return "https://aisbaltimore.clubspeedtiming.com/api/index.php/"
    }
    
    // MARK: URL constructors-----------------------------------------------------------
    
    // Constructs the URL for getting races
    private func constructURL(when: String, track: String) -> URL {
        return URL(string:"\(baseURL())races/\(when).json?track=\(track)&key=\(apiKey)")!
    }
    
    // Constructs the URL for getting people in the system with their Racer ID
    private func constructURL(racerId: String) -> URL {
        return URL(string:"\(baseURL())racers/\(racerId).json?key=\(apiKey)")!
    }
    
    // MARK: Racer acquisition method(s)--------------------------------------------------
    
    // Gets a single racer by their unique racer id
    func getRacerBy(id: String, completion: @escaping (Racer) -> Void) {
        let url = constructURL(racerId: id)
        
        performDataTask(url: url, completion: { (json) in
            if let data = json {
                completion(Racer(dictionary: data["racer"] as! [String : Any]))
            }
        })
    }
    
    // MARK: Race acquisition method(s)---------------------------------------------------
    
    // Gets the upcoming race for the specified track
    func getNextRaceFor(track: String, completion: @escaping (Race) -> Void) {
        let url = constructURL(when: "next", track: track)
        
        performDataTask(url: url, completion: { (json) in
            if let data = json?["race"] as? [String : Any] {
                completion(Race(dictionary: data))
            }
        })
    }
    
    // Gets all the races scheduled for the specified track
    func getAllUpcomingRacesFor(track: String, completion: @escaping ([Race]) -> Void) {
        let url = constructURL(when: "upcoming", track: track)
        
        performDataTask(url: url, completion: { (json) in
            if let data = json?["races"] as? [[String : Any]] {
                var tempRaces: [Race] = []
                for race in data {
                    tempRaces.append(Race(dictionary: race["race"] as! [String : Any]))
                }
                completion(tempRaces)
            }
        })
    }
    
    // MARK: API call method(s)-----------------------------------------------------------
    
    // Performs the API call
    private func performDataTask(url: URL, completion: @escaping (([String : Any]?) -> Void)) {
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: url, completionHandler: {
            (data, response, error) in
            
            if error != nil {
                print(error!.localizedDescription)
            } else {
                do {
                    if let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String : Any]
                    {
                        completion(json)
                    } else {
                        completion(nil)
                    }
                } catch {
                    print("error in JSONSerialization")
                }
            }
        })
        task.resume()
    }
}
