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
    
    
    private func baseURL() -> String {
        return "https://aisbaltimore.clubspeedtiming.com/api/index.php/"
    }
    
    // MARK: URL constructors-----------------------------------------------------------
    
    // Constructs the URL for getting races
    private func constructURL(when: String, track: Int) -> URL {
        return URL(string:"\(baseURL())races/\(when).json?track=\(track)&key=\(apiKey)")!
    }
    
    // Constructs the URL for getting people in the system with their Racer ID
    private func constructURL(racerId: String) -> URL {
        return URL(string:"\(baseURL())racers/\(racerId).json?key=\(apiKey)")!
    }
    
    // MARK: Racer acquisition methods--------------------------------------------------
    
    // Gets a single racer by their unique racer id
    func getRacerBy(id: String, completion: @escaping (Racer) -> Void) {
        let url = constructURL(racerId: id)
        
        performDataTask(url: url, completion: { (json) in
            if let data = json {
                completion(Racer(dictionary: data["racer"] as! [String : Any]))
            }
        })
    }
    
    // MARK: Race acquisition methods---------------------------------------------------
    
    // Gets the upcoming race for the specified track
    func getUpcomingRaceFor(track: Int, completion: @escaping ([Racer]) -> Void) {
        let url = constructURL(when: "next", track: track)
        
        performDataTask(url: url, completion: { (json) in
            if let data = json {
                completion(Race(dictionary: data["race"] as! [String : Any]).racers)
            }
        })
    }
    
    // MARK: API call methods-----------------------------------------------------------
    
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
