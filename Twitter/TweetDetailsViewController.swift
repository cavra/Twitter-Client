//
//  TweetDetailsViewController.swift
//  Twitter
//
//  Created by Cory Avra on 2/24/16.
//  Copyright © 2016 coryavra. All rights reserved.
//

import UIKit

class TweetDetailsViewController: UIViewController {

    // Incoming Variables
    var tweet: Tweet?
    
    // Outlets
    @IBOutlet var tweetDetailsView: TweetDetails!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tweetDetailsView.tweet = self.tweet
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        if segue.identifier == "TweetToUserInfo" {
            
            //get the tweeter's information
            let userDataToPass = User(dictionary: (tweet?.user)!)
            
            // Pass the info to the destination controller
            let itemToAdd = segue.destinationViewController as! ProfileViewController
            itemToAdd.user = userDataToPass
        }
    }

}
