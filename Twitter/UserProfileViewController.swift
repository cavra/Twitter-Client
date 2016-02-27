//
//  UserProfileViewController.swift
//  Twitter
//
//  Created by Cory Avra on 2/26/16.
//  Copyright © 2016 coryavra. All rights reserved.
//

import UIKit

class UserProfileViewController: UIViewController {
    
    // Outlets
    @IBOutlet var profileDetailsView: UserProfileDetails!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Pass the data to the ProfileDetails view
        self.profileDetailsView.user = User.currentUser
                
    }
    
    override func viewWillAppear(animated: Bool) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
