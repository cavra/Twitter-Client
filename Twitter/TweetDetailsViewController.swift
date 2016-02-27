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
            
            // Get the tweeter's information
            let dataToPass = tweet?.user
            
            // Pass the info to the destination controller
            let itemToAdd = segue.destinationViewController as! ProfileViewController
            itemToAdd.user = dataToPass
        }
        
        if segue.identifier == "segueToReply" {
            
            // Get the tweeter's information
            let dataToPass = tweet?.postID
            
            // Pass the info to the destination controller
            let navVC = segue.destinationViewController as! UINavigationController
            let itemToAdd = navVC.viewControllers.first as! ComposeViewController
            itemToAdd.replyToPostID = dataToPass
        }
        
    }

    // Actions
    @IBAction func onRetweetButton(sender: AnyObject) {
        TwitterClient.sharedInstance.retweet(tweet) { (tweet, error) -> () in
            print(tweet)
        }
        
        self.tweet!.retweetCount += 1
        
        //refresh tableview
    }
    
    @IBAction func onFavoriteButton(sender: AnyObject) {
        TwitterClient.sharedInstance.favorite(tweet) { (tweet, error) -> () in
            print(tweet)
        }
        
        self.tweet!.retweetCount += 1
        
        //refresh tableview
    }

}
