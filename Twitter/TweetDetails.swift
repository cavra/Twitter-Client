//
//  TweetDetails.swift
//  Twitter
//
//  Created by Cory Avra on 2/24/16.
//  Copyright © 2016 coryavra. All rights reserved.
//

import UIKit

class TweetDetails: UIView {

    // Outlets
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screennameLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    
    @IBOutlet weak var profileImageViewButton: UIButton!

    // Variables
    var tweet: Tweet! {
        didSet {
            nameLabel.text = tweet?.userName
            screennameLabel.text = tweet?.userScreenname
            tweetLabel.text = tweet?.text
            
            if (tweet?.userProfileImageURL != nil) {
                profileImageView.setImageWithURL((tweet?.userProfileImageURL!)!)
                                
                // Some formatting
                profileImageView.layer.cornerRadius = 3
                profileImageView.clipsToBounds = true
            }
            
            // @todo figure out how to parse NSDate
            let time = parseDate(tweet?.timestamp)
            timestampLabel.text = time
            
            //Check for single or plural types
            /*if (tweet?.retweetCount == 1) {
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
            }*/
        }
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
}
