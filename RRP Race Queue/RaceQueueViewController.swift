//
//  ViewController.swift
//  RRP Race Queue
//
//  Created by Zack Spicer on 12/2/16.
//  Copyright © 2016 Zack Spicer. All rights reserved.
//

import UIKit

class RaceQueueViewController: UIViewController {
    
    @IBOutlet weak var trackSelectSegmentedControl: UISegmentedControl!
    @IBOutlet weak var raceQueueTableView: UITableView!
    
    var me: Racer? // The racer that is currently logged in (Hard coded for testing)
    var selectedRace: Race? // The race that was tapped in the table view
    var upcomingRaces: [Race] = [] // All of the schedules races for the selected track
    

    override func viewDidLoad() {
        super.viewDidLoad()
        assignMe()
        NotificationCenter.default.addObserver(self, selector: #selector(indexChanged(_:)), name: NSNotification.Name(rawValue: "load"), object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        indexChanged(trackSelectSegmentedControl)
    }
    
    // Gets all the scheduled races for the selected track and reloads the table view
    func showAllScheduledRacesFor(track: String) {
        NetworkController.sharedInstance.getAllUpcomingRacesFor(track: track, completion: { (races) in
            DispatchQueue.main.async(execute: { () -> Void in
                self.upcomingRaces = races
                self.raceQueueTableView.reloadData()
            })
        })
    }
    
    // Assigns the me variable to the person currently logged in (Hard coded for development)
    func assignMe() {
        NetworkController.sharedInstance.getRacerBy(id: "1001228", completion: { (racer) in
            DispatchQueue.main.async(execute: { () -> Void in
                self.me = racer
            })
        })
    }
    
    // Action for segmented control triggered when the user clicks a different segment
    @IBAction func indexChanged(_ sender: UISegmentedControl) {
        upcomingRaces = []
        raceQueueTableView.reloadData()
        
        switch trackSelectSegmentedControl.selectedSegmentIndex {
        case 0:
            showAllScheduledRacesFor(track: "2")
        case 1:
            showAllScheduledRacesFor(track: "1")
        default:
            break
        }
    }
    
    // MARK: Prepare for segue method---------------------------------------------------------------
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if sender is UIBarButtonItem {
            let navController = segue.destination as! UINavigationController
            let viewController = navController.viewControllers.first as! RacerProfileViewController
            if let me = self.me {
                viewController.me = me
            }
        } else {
            let viewController = segue.destination as! RaceDetailViewController
            viewController.race = selectedRace!
        }
    }
}

extension RaceQueueViewController: UITableViewDataSource, UITableViewDelegate {
    
    // MARK: UITableViewDataSource Methods----------------------------------------------------------
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "raceCell", for: indexPath)
        cell.textLabel?.text = "Race #" + (upcomingRaces[indexPath.row].raceNumber)! + ": " + (upcomingRaces[indexPath.row].raceName)!
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return upcomingRaces.count
    }
    
    // MARK: UITableViewDelegate Method(s)----------------------------------------------------------
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selectedRace = upcomingRaces[indexPath.row]
        performSegue(withIdentifier: "raceDetailViewControllerSegue", sender: indexPath)
    }
    
}

