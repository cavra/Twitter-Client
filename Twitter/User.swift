//
//  User.swift
//  Twitter
//
//  Created by Cory Avra on 2/20/16.
//  Copyright © 2016 coryavra. All rights reserved.
//

import UIKit

class User: NSObject {

    // Variables
    var dictionary: NSDictionary?
    
    var profileImageURL: NSURL?
    var backgroundImageURL: NSURL?
    var bannerImageURL: NSURL?

    var name: String?
    var screenname: String?
    var id: String?
    var tagline: String?
    
    var tweetCount: Int?
    var followingCount: Int?
    var followersCount: Int?
    
    // Deserialize the dictionary
    init(dictionary: NSDictionary) {
        self.dictionary = dictionary

        // Images
        let profileImageURLString = dictionary["profile_image_url_https"] as? String
        if let profileImageURLString = profileImageURLString {
            profileImageURL = NSURL(string: profileImageURLString)
        }
        let backgroundImageURLString = dictionary["profile_background_image_url_https"] as? String
        if let backgroundImageURLString = backgroundImageURLString {
            backgroundImageURL = NSURL(string: backgroundImageURLString)
        }
        let bannerImageURLString = dictionary["profile_banner_url"] as? String
        if let bannerImageURLString = bannerImageURLString {
            bannerImageURL = NSURL(string: bannerImageURLString)
        }
        
        // Texts
        name = dictionary["name"] as? String
        screenname = dictionary["screen_name"] as? String
        id = dictionary["id_str"] as? String
        tagline = dictionary["description"] as? String
        
        // Counts
        tweetCount = dictionary["statuses_count"] as? Int
        followingCount = dictionary["friends_count"] as? Int
        followersCount = dictionary["followers_count"] as? Int

    }

    static let UserDidLogOutNotification = "UserDidLogout"

    static var _currentUser: User?
    
    class var currentUser: User? {
        get {
            if _currentUser == nil {
            
                let defaults = NSUserDefaults.standardUserDefaults()
                let userData = defaults.objectForKey("currentUserData") as? NSData
            
                if let userData = userData {
                    let dictionary = try!
                        NSJSONSerialization.JSONObjectWithData(userData, options: []) as! NSDictionary
                    _currentUser = User(dictionary: dictionary)
                }
            }
            return _currentUser
        }
        set(user) {
            _currentUser = user
            
            let defaults = NSUserDefaults.standardUserDefaults()
            
            if let user = user {
                let data = try!
                    NSJSONSerialization.dataWithJSONObject(user.dictionary!, options: [])
                defaults.setObject(data, forKey: "currentUserData")
            }
            else {
                defaults.setObject(nil, forKey: "currentUserData")
            }
            
            defaults.synchronize()
        }
    }
    
}
