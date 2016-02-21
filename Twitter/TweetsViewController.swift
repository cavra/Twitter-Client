//
//  TweetsViewController.swift
//  Twitter
//
//  Created by Cory Avra on 2/20/16.
//  Copyright © 2016 coryavra. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // Variables
    var tweets: [Tweet]!
    var user: User!
    
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
        // Get the account details
        TwitterClient.sharedInstance.verifyCredentials({ (user: User) -> () in
            self.user = user
            self.tableView.reloadData()
            
            }, failure: { (error: NSError) -> () in
                print(error.localizedDescription)
        })
        
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
        return 20
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell", forIndexPath: indexPath) as! TweetCell
        cell.tweet = self.tweets?[indexPath.row]
        
        return cell
    }
    
    func refreshTableView() {
        self.tableView.reloadData()
    }
    
    // Actions
    @IBAction func onLogoutButton(sender: AnyObject) {
        TwitterClient.sharedInstance.logout()
    }
    
    @IBAction func onRetweetButton(sender: AnyObject) {
        // Get the cell index
        let button = sender as! UIButton
        let view = button.superview!
        let cell = view.superview as! TweetCell
        let indexPath = tableView.indexPathForCell(cell)
        
        // Increment the retweet count
        self.tweets[(indexPath?.row)!].retweetCount += 1
        self.tableView.reloadData()

        // @todo Figure out why this crashes...
        //TwitterClient.sharedInstance.retweet(sender.tag)
    }
    
    @IBAction func onFavoriteButton(sender: AnyObject) {
        // Get the cell index
        let button = sender as! UIButton
        let view = button.superview!
        let cell = view.superview as! TweetCell
        let indexPath = tableView.indexPathForCell(cell)
        
        // Increment the favorite count
        self.tweets[(indexPath?.row)!].favoritesCount += 1
        self.tableView.reloadData()
        
        // @todo Figure out why this crashes...
        //TwitterClient.sharedInstance.favorite(sender.tag)
    }
    
}
