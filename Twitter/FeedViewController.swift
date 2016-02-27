//
//  TweetsFeedController.swift
//  Twitter
//
//  Created by Cory Avra on 2/20/16.
//  Copyright © 2016 coryavra. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // Outlets
    @IBOutlet weak var tableView: UITableView!

    // Variables
    var tweets: [Tweet]!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Initiate the tableView
        tableView.delegate = self
        tableView.dataSource = self

        // Dynamic Height
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 200
        
        // Get the data from the network
        getDataFromTwitter()
            
    }

    override func viewWillAppear(animated: Bool) {
        // Remove any selected styles from cells
        tableView.reloadData()
    }

    func getDataFromTwitter() {        
        // Get the home timeline information
        TwitterClient.sharedInstance.homeTimeline({ (tweets: [Tweet]) -> () in
            self.tweets = tweets
            self.tableView.reloadData()
            
        }, failure: { (error: NSError) -> () in
            print(error.localizedDescription)
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tweets?.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as! TweetCell
        cell.tweet = self.tweets?[indexPath.row]
    
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
       
        if segue.identifier == "SegueToDetails" {
            // Get the selected cell's index 
            let selectedIndex = tableView.indexPathForCell(sender as! UITableViewCell)
            let tweetToSend = self.tweets?[selectedIndex!.row]
            
            // Pass the tweet info to the destination controller
            let itemToAdd = segue.destinationViewController as! TweetDetailsViewController
            itemToAdd.tweet = tweetToSend
        }
        
        if segue.identifier == "FeedToUserInfo" {
            // Get the selected cell's index
            let button = sender as! UIButton
            let view = button.superview!
            let cell = view.superview as! TweetCell
            let indexPath = tableView.indexPathForCell(cell)
            
            let userDataToPass = self.tweets?[indexPath!.row].user
            
            // Pass the user info to the destination controller
            let itemToAdd = segue.destinationViewController as! ProfileViewController
            itemToAdd.user = userDataToPass
        }
    }

    // Actions
    @IBAction func onLogoutButton(sender: AnyObject) {
        TwitterClient.sharedInstance.logout()
    }
    
}
