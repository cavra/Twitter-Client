//
//  ViewController.swift
//  Twitter
//
//  Created by Cory Avra on 2/14/16.
//  Copyright © 2016 coryavra. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // Actions
    @IBAction func onLogin(sender: AnyObject) {
        
        TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
        TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token" , method: "GET", callbackURL: NSURL(string: "cptwitterdemo://oauth"), scope: nil,
            success: {(requestToken: BDBOAuth1Credential!) -> Void in
                print("Got the request token")
                var authURL = NSURL(string: "http://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")
                UIApplication.sharedApplication().openURL(authURL!)                
            },
            failure: {(error: NSError!) -> Void in
                print("Failed to get the request token")
            })
    }
    
    
    

}