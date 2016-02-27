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
let twitterBaseURL = NSURL(string: "https://api.twitter.com")
let twitterConsumerKey = "hMvOhK5tjeQwU7viIzWTO3rZG"
let twitterConsumerSecret = "Mg7GaNDvbAaddJUA4TIQ8usrFTHQhhrhPKrVXOvhXBpigHbkmT"

class TwitterClient: BDBOAuth1SessionManager {
        
    class var sharedInstance: TwitterClient {
        struct Static {
            static let instance = TwitterClient(baseURL: twitterBaseURL, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)
        }
        return Static.instance
    }
    
    var loginSuccess: (() -> ())?
    var loginFailure: ((NSError) -> ())?
    
    func login(success: () -> (), failure: (NSError) -> ()) {
        loginSuccess = success
        loginFailure = failure
        
        requestSerializer.removeAccessToken()
        fetchRequestTokenWithPath("oauth/request_token" , method: "GET", callbackURL: NSURL(string: "twitterdemo://oauth"), scope: nil,
            success: {(requestToken: BDBOAuth1Credential!) -> Void in
                print("Got the request token")
                let authURL = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")
                UIApplication.sharedApplication().openURL(authURL!)
            },
            failure: {(error: NSError!) -> Void in
                print(error.localizedDescription)
                self.loginFailure!(error)
            }
        )
    }
    
    func logout() {
        User.currentUser = nil
        deauthorize()
        
        NSNotificationCenter.defaultCenter().postNotificationName(User.UserDidLogOutNotification, object: nil)
    }

    func tweet(statusUpdate: String?, completion: (tweet: Tweet?, error: NSError?) -> ()) {
        POST("1.1/statuses/update.json?status=\(statusUpdate)", parameters: nil,
            progress: { (NSProgress) -> Void in
                print("Tweeting...")
            }, success: { (operation: NSURLSessionDataTask, response: AnyObject?) -> Void in
                print("Tweet successful")
            }) { (operation: NSURLSessionDataTask?, error: NSError) -> Void in
                print(error.localizedDescription)
        }
    }
    
    func retweet(tweet: Tweet?, completion: (tweet: Tweet?, error: NSError?) -> ()) {
        POST("1.1/statuses/retweet/\((tweet?.postID)!).json", parameters: nil,
            progress: { (NSProgress) -> Void in
                print("Retweeting...")
            }, success: { (operation: NSURLSessionDataTask, response: AnyObject?) -> Void in
                print("Retweet successful")
            }) { (operation: NSURLSessionDataTask?, error: NSError) -> Void in
                print(error.localizedDescription)
        }
    }

    func favorite(tweet: Tweet?, completion: (tweet: Tweet?, error: NSError?) -> ()) {
        POST("1.1/favorites/create.json?id=\((tweet?.postID)!)", parameters: nil,
            progress: { (NSProgress) -> Void in
                print("Favoriting...")
            }, success: { (operation: NSURLSessionDataTask, response: AnyObject?) -> Void in
                print("Favorite successful")
            }) { (operation: NSURLSessionDataTask?, error: NSError) -> Void in
                print(error.localizedDescription)
        }
    }

    func handleOpenUrl(url: NSURL) {
        fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: BDBOAuth1Credential(queryString: url.query),
            success: { (accessToken: BDBOAuth1Credential!) -> Void in
                print("Got the access token")
                
                // Get the access token
                self.requestSerializer.saveAccessToken(accessToken)

                self.verifyCredentials({ (user: User) -> () in
                    User.currentUser = user
                    self.loginSuccess?()
                }, failure: { (error: NSError) -> () in
                    self.loginFailure?(error)
                })
                
            }) { (error: NSError!) -> Void in
                print(error.localizedDescription)
                self.loginFailure?(error)
        }
    }
    
    func verifyCredentials(success: (User) -> (), failure: (NSError) -> ()) {
        GET("1.1/account/verify_credentials.json", parameters: nil,
            progress: { (NSProgress) -> Void in
                print("Getting the user's credentials...")
            },
            success: { (operation: NSURLSessionDataTask, response: AnyObject?) -> Void in
                let userDictionary = response as! NSDictionary
                let user = User(dictionary: userDictionary)
                success(user)
            },
            failure: { (operation: NSURLSessionDataTask?, error: NSError) -> Void in
                failure(error)
        })
    }
    
    func homeTimeline(success: ([Tweet]) -> (), failure: (NSError) -> ()) {
        GET("1.1/statuses/home_timeline.json", parameters: nil,
            progress: { (NSProgress) -> Void in
                print("Getting the home timeline...")
            },
            success: { (operation: NSURLSessionDataTask, response: AnyObject?) -> Void in
                let dictionaries = response as! [NSDictionary]
                let tweets = Tweet.tweetsWithArray(dictionaries)
                success(tweets)
            },
            failure: { (operation: NSURLSessionDataTask?, error: NSError) -> Void in
                failure(error)
        })
    }
    
    /*
    
    func getProfileBanner(user: User?, completion: (banner: Tweet?, error: NSError?) -> ()) {
        POST("1.1/users/profile_banner.json?screen_name=twitterapi", parameters: nil,
            progress: { (NSProgress) -> Void in
                print("Getting the profile banner...")
            }, success: { (operation: NSURLSessionDataTask, response: AnyObject?) -> Void in
                print("Banner get!")
            }) { (operation: NSURLSessionDataTask?, error: NSError) -> Void in
                print(error.localizedDescription)
        }
    }*/
    
}
