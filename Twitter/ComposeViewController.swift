//
//  TweetingViewController.swift
//  Twitter
//
//  Created by Cory Avra on 2/26/16.
//  Copyright © 2016 coryavra. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController, UITextViewDelegate {

    // Outlets
    @IBOutlet weak var tweetField: UITextField!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screennamelabel: UILabel!
    
    // Variables
    var replyToPostID: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        displayData()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        tweetField.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func displayData() {
        
        nameLabel.text = (User.currentUser!.name)!
        screennamelabel.text = (User.currentUser!.screenname)!
        
        profileImageView.setImageWithURL((User.currentUser!.profileImageURL)!)
        profileImageView.layer.cornerRadius = 5
        profileImageView.clipsToBounds = true
        
    }
    
    // Actions
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
    
    @IBAction func onTweetButton(sender: AnyObject) {
        if (tweetField.text != nil) {
            
            var params = [String: AnyObject]()
            params["status"] = tweetField.text
            
            if (replyToPostID != nil) {
                params["in_reply_to_status_id"] = replyToPostID
            }
            
            TwitterClient.sharedInstance.tweet(params) { (tweet, error) -> () in
                //do nothing
            }
        }
        
        view.endEditing(true)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func onCancelButton(sender: AnyObject) {
        tweetField.text = ""
                
        view.endEditing(true)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
}
