//
//  UserViewController.swift
//  Twitter
//
//  Created by Cory Avra on 2/26/16.
//  Copyright © 2016 coryavra. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    // Incoming Variables
    var user: User?

    // Outlets
    @IBOutlet var profileDetailsView: ProfileDetails!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.profileDetailsView.user = user

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
