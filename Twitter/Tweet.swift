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
    var user: User?

    var text: String?
    var postID: String?
    var timestamp: NSDate?
    
    var retweetCount: Int = 0
    var favoritesCount: Int = 0
    
    // Deserialize the dictionary
    init(dictionary: NSDictionary) {
        
        // User Information
        let userDictionary = dictionary["user"] as? NSDictionary
        user = User(dictionary: userDictionary!)
        
        // Texts
        text = dictionary["text"] as? String
        postID = dictionary["id_str"] as? String

        // Timestamp
        let timestampString = dictionary["created_at"] as? String
        if let timestampString = timestampString {
            let formatter = NSDateFormatter()
            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            timestamp = formatter.dateFromString(timestampString)
        }

        // Counts
        favoritesCount = (dictionary["favorite_count"] as? Int) ?? 0
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        
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
