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
    
    var race: Race = Race()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = race.raceName!
        
    }
    
    // MARK: Prepare for segue method
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navController = segue.destination as! UINavigationController
        let viewController = navController.viewControllers.first as! RacerProfileViewController
        let racerCellIndexPath = sender as! IndexPath
        let racerCell = tableView(self.raceDetailsTableView, cellForRowAt: racerCellIndexPath)
        
        viewController.me = race.racers[racerCellIndexPath.row]
        
        if let racerCellTitle = racerCell.textLabel?.text {
            navController.viewControllers.first?.title = racerCellTitle
        }
        
    }
    
}

extension RaceDetailViewController: UITableViewDataSource, UITableViewDelegate {
    
    // MARK: UITableViewDataSource Methods
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "racerCell", for: indexPath)
        cell.textLabel?.text = race.racers[indexPath.row].fullName()
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return race.racers.count
    }
    
    // MARK: UITableViewDataSource Method(s)
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        performSegue(withIdentifier: "viewRacerDetailsSegue", sender: indexPath)
    }
    
}
