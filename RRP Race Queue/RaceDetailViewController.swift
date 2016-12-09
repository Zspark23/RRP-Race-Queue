//
//  RaceDetailViewController.swift
//  RRP Race Queue
//
//  Created by Zack Spicer on 12/2/16.
//  Copyright © 2016 Zack Spicer. All rights reserved.
//

import UIKit

class RaceDetailViewController: UIViewController {
    
    @IBOutlet weak var raceDetailsTableView: UITableView!
    
    var racersArray: [Racer] = []
    var race: Race = Race()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fillTableWithRacers()
        
        NetworkController.sharedInstance.getRacerBy(id: "1001228", completion: { (racer) in
            DispatchQueue.main.async(execute: { () in
                print(racer.fullName() ?? "No racer")
            })
        })
    }
    
    func fillTableWithRacers() {
        NetworkController.sharedInstance.getUpcomingRaceFor(track: 1, completion: { (racers) in
            DispatchQueue.main.async(execute: { () -> Void in
                self.racersArray = racers
                self.raceDetailsTableView.reloadData()
            })
        })
    }
    
    // MARK: Prepare for segue method
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navController = segue.destination as! UINavigationController
        let racerCell = sender as! UITableViewCell
        
        if let racerCellTitle = racerCell.textLabel?.text {
            navController.viewControllers.first?.title = racerCellTitle
        }
        
    }
    
}

extension RaceDetailViewController: UITableViewDataSource, UITableViewDelegate {
    
    // MARK: UITableViewDataSource Methods
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "racerCell", for: indexPath)
        cell.textLabel?.text = racersArray[indexPath.row].fullName()
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return racersArray.count
    }
    
    // MARK: UITableViewDataSource Method(s)
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        performSegue(withIdentifier: "viewRacerDetailsSegue", sender: cell)
    }
    
}
