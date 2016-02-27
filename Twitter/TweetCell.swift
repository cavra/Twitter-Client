//
//  TweetCell.swift
//  Twitter
//
//  Created by Cory Avra on 2/20/16.
//  Copyright © 2016 coryavra. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    // Outlets
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screennameLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var favoriteCountLabel: UILabel!
    
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    
    // Variables
    var tweet: Tweet! {
        didSet {

            // Images
            if (tweet?.user?.profileImageURL != nil) {
                profileImageView.setImageWithURL((tweet?.user?.profileImageURL!)!)

                // Some formatting
                profileImageView.layer.cornerRadius = 5
                profileImageView.clipsToBounds = true
            }
            
            // Texts
            nameLabel.text = tweet?.user?.name
            screennameLabel.text = "@\((tweet?.user?.screenname)!)"
            tweetLabel.text = tweet?.text
            timestampLabel.text = parseDate(tweet?.timestamp)
            
            // Counts -- Check for single or plural types
            if (tweet?.retweetCount == 1) {
                retweetCountLabel.text = "\(tweet.retweetCount) RETWEET"
            }
            else if (tweet?.retweetCount != nil) {
                retweetCountLabel.text = "\(tweet.retweetCount) RETWEETS"
            }
            if (tweet?.favoritesCount == 1) {
                favoriteCountLabel.text = "\(tweet.favoritesCount) FAVORITE"
            }
            else if (tweet?.favoritesCount != nil) {
                favoriteCountLabel.text = "\(tweet.favoritesCount) FAVORITES"
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        // Set the default first
        let defaultBackgroundView = UIView()
        defaultBackgroundView.backgroundColor = .None
        self.backgroundView = defaultBackgroundView
        
        // Followed by the selected style
        let selectedBackgroundView = UIView()
        selectedBackgroundView.backgroundColor = UIColor.lightGrayColor()
        self.selectedBackgroundView = selectedBackgroundView

    }
    
    func parseDate(date: NSDate?) -> String? {
        
        //@todo rewrite this
        if (date == nil) {
            return nil
        }

        var outputTime: String = ""
        let calendar = NSCalendar.autoupdatingCurrentCalendar()
        let components = calendar.components([.Year, .Month, .Day, .Hour, .Minute, .Second], fromDate: date!, toDate: NSDate(), options: [])
        
        if (components.year > 1) {
            outputTime = "\(components.year) years ago"
        } else if (components.month > 1) {
            outputTime = "\(components.month) months ago"
        } else if (components.day > 1) {
            outputTime = "\(components.day) days ago"
        } else if (components.hour > 1) {
            outputTime = "\(components.hour)h"
        } else if (components.minute > 1) {
            outputTime = "\(components.minute)m"
        } else {
            outputTime = "\(components.second)s"
        }
        
        return outputTime
    }
    
    // Actions
    @IBAction func onRetweetButton(sender: AnyObject) {
        TwitterClient.sharedInstance.retweet(tweet) { (tweet, error) -> () in
            print(tweet)
        }
        tweet.retweetCount += 1
        
        //refresh tableview
    }
    
    @IBAction func onFavoriteButton(sender: AnyObject) {
        TwitterClient.sharedInstance.favorite(tweet) { (tweet, error) -> () in
            print(tweet)
        }
        tweet.favoritesCount += 1

        //refresh tableview
    }
    
}
