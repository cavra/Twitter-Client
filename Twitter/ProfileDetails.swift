//
//  ProfileDetails.swift
//  Twitter
//
//  Created by Cory Avra on 2/26/16.
//  Copyright © 2016 coryavra. All rights reserved.
//

import UIKit

class ProfileDetails: UIView {

    // Outlets
    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var screennameLabel: UILabel!
    
    @IBOutlet weak var tweetsCountLabel: UILabel!
    @IBOutlet weak var followingCountLabel: UILabel!
    @IBOutlet weak var followersCountLabel: UILabel!
    
    // Variables
    var user: User! {
        didSet {
            
            // Images
            if (user?.bannerImageURL != nil) {
                bannerImageView.setImageWithURL((user?.bannerImageURL)!)
            }
            else {
                bannerImageView.setImageWithURL((User.currentUser?.bannerImageURL)!)
            }
            if (user?.profileImageURL != nil) {
                profileImageView.setImageWithURL((user?.profileImageURL)!)
                
                // Some formatting
                profileImageView.layer.cornerRadius = 5
                profileImageView.clipsToBounds = true
                profileImageView.layer.borderColor = UIColor.whiteColor().CGColor
                profileImageView.layer.borderWidth = 3
            }
            
            // More formatting
            let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Light)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            blurEffectView.frame = bannerImageView.bounds
            blurEffectView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
            bannerImageView.addSubview(blurEffectView)

            
            // Texts
            nameLabel.text = user?.name
            screennameLabel.text = "@\((user?.screenname)!)"
            
            // Counts
            tweetsCountLabel.text = "\((user?.tweetCount)!)"
            followingCountLabel.text = "\((user?.followingCount)!)"
            followersCountLabel.text = "\((user?.followersCount)!)"
        }
    }
}
