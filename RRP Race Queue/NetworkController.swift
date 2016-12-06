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
        return "http://aisbaltimore.clubspeedtiming.com/api/index.php/"
    }
    
    private func constructURLString(when: String, track: Int) -> String {
        return "\(baseURL())races/\(when).json?track=\(track)&key=\(apiKey)"
    }
    
    func getUpcomingFor(track: Int, completion: @escaping ([Racer]) -> Void) {
        let url = URL(string: constructURLString(when: "next", track: track))
        performDataTask(url: url!, completion: { (racers) in
            completion(racers)
        })
        
    }
    
    private func performDataTask(url: URL, completion: @escaping (([Racer]) -> Void)) {
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        var racerArray: [Racer] = []
        let task = session.dataTask(with: url, completionHandler: {
            (data, response, error) in
            
            if error != nil {
                print(error!.localizedDescription)
            } else {
                do {
                    if let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String : Any]
                    {
                        if let race = json["race"] as? [String : Any] {
                            for racer in race["racers"] as! [Any] {
                                racerArray.append(Racer(dictionary: racer as! [String : Any]))
                            }
                            completion(racerArray)
                        } else {
                            completion([])
                        }
                    }
                } catch {
                    print("error in JSONSerialization")
                }
            }
        })
        task.resume()
    }
    
    private func testPerformDataTask(completion: @escaping (([String : Any]) -> Void)) {
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: URL(string: "\(baseURL())racers/search.json?query=Baby%20Spice&key=\(apiKey)")!, completionHandler: {
            (data, response, error) in
            
            if error != nil {
                print(error!.localizedDescription)
            } else {
                do {
                    if let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? [String : Any]
                    {
                        completion(json)
                    }
                } catch {
                    print("error in JSONSerialization")
                }
            }
        })
        task.resume()
    }
}
