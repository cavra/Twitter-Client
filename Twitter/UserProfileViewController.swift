//
//  profileViewController.swift
//  Twitter
//
//  Created by Cory Avra on 2/26/16.
//  Copyright © 2016 coryavra. All rights reserved.
//

import UIKit

class UserProfileViewController: UIViewController {

    // Variables
    var userData: User!

    // Outlets
    @IBOutlet var profileDetailsView: ProfileDetails!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // Get the data from the network
        getDataFromTwitter()       
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getDataFromTwitter() {
        // Get the account details
        TwitterClient.sharedInstance.verifyCredentials({ (user: User) -> () in
            
            // Pass the data to the ProfileDetails view
            self.profileDetailsView.user = user
            
            }, failure: { (error: NSError) -> () in
                print(error.localizedDescription)
        })
    }

}
