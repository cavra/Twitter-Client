//
//  Tweet.swift
//  Twitter
//
//  Created by Cory Avra on 2/20/16.
//  Copyright © 2016 coryavra. All rights reserved.
//

import UIKit

class Tweet: NSObject {

    // Variables
    var user: NSDictionary?
    var userProfileImageURL: NSURL?
    var userName: String?
    var userScreenname: String?
    var userTagline: String?

    var text: String?
    var timestamp: NSDate?
    var retweetCount: Int = 0
    var favoritesCount: Int = 0
    var postID: String?
    
    // Deserialize the dictionary
    init(dictionary: NSDictionary) {
        
        // User information
        user = dictionary["user"] as? NSDictionary
        userName = user!["name"] as? String
        userScreenname = "@\((user!["screen_name"] as? String)!)"
        userTagline = user!["description"] as? String
        
        // Get the profile picture
        let userProfileImageUrlString = user!["profile_image_url_https"] as? String
        if let userProfileImageUrlString = userProfileImageUrlString {
            userProfileImageURL = NSURL(string: userProfileImageUrlString)
        }
        
        // Get the general tweet data
        text = dictionary["text"] as? String
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        favoritesCount = (dictionary["favorite_count"] as? Int) ?? 0
        postID = dictionary["id_str"] as? String
        
        let timestampString = dictionary["created_at"] as? String
        
        if let timestampString = timestampString {
            let formatter = NSDateFormatter()
            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            timestamp = formatter.dateFromString(timestampString)
        }
    }
    
    class func tweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
    
        for dictionary in dictionaries {
            let tweet = Tweet(dictionary: dictionary)
            tweets.append(tweet)
        }
        return tweets
    }
    
}
