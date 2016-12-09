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
    
    var me: Racer?

    override func viewDidLoad() {
        super.viewDidLoad()
        //fillTableWithRacers()
        print("\(trackSelectSegmentedControl.)")
    }
    
    func showUpcomingRaceInTable() {
        //let trackNum = trackSelectSegmentedControl.
        NetworkController.sharedInstance.getUpcomingRaceFor(track: "1", completion: { (race) in
            DispatchQueue.main.async(execute: { () -> Void in
                
            })
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if sender is UIBarButtonItem {
            let navController = segue.destination as! UINavigationController
            let viewController = navController.viewControllers.first as! RacerProfileViewController
            viewController.racer = me
        } else {
            let viewController = segue.destination as! RaceDetailViewController
            let raceCell = sender as! UITableViewCell
            
            if let raceText = raceCell.textLabel?.text {
                viewController.title = "\(raceText)"
            }
        }
    }
    
}

extension RaceQueueViewController: UITableViewDataSource, UITableViewDelegate {
    
    // MARK: UITableViewDataSource Methods----------------------------------------------------------
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "raceCell", for: indexPath)
        cell.textLabel?.text = "Race \(indexPath.row + 1)"
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    // MARK: UITableViewDelegate Method(s)----------------------------------------------------------
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

