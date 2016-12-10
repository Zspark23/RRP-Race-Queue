//
//  RacerDetailViewController.swift
//  RRP Race Queue
//
//  Created by Zack Spicer on 12/2/16.
//  Copyright © 2016 Zack Spicer. All rights reserved.
//

import UIKit

class RacerProfileViewController: UIViewController {
    
    @IBOutlet weak var profilePictureImageView: UIImageView!
    
    var me: Racer = Racer()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = me.fullName()
    
        do {
        try profilePictureImageView.image = UIImage(data: Data(contentsOf: URL(string: "http://aisbaltimore.clubspeedtiming.com/CustomerPictures/\(me.racerId!).jpg")!))
        } catch {
            print("Error getting picture")
        }
    }

    @IBAction func doneButtonTapped(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    

}
