//
//  TwitterClient.swift
//  Twitter
//
//  Created by Cory Avra on 2/14/16.
//  Copyright © 2016 coryavra. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

// Variables
let twitterBaseURL = NSURL(string: "http://api.twitter.com")
let twitterConsumerKey = "hMvOhK5tjeQwU7viIzWTO3rZG"
let twitterConsumerSecret = "Mg7GaNDvbAaddJUA4TIQ8usrFTHQhhrhPKrVXOvhXBpigHbkmT"

class TwitterClient: BDBOAuth1SessionManager {
    
    class var sharedInstance: TwitterClient {
        struct Static {
            static let instance = TwitterClient(baseURL: twitterBaseURL, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)
        }
        
        return Static.instance
    }
    
}
