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
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var screennameLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var favoriteCountLabel: UILabel!
    
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var tweet: Tweet! {
        didSet {
            
            nameLabel.text = tweet?.userName
            tweetLabel.text = tweet?.text
            screennameLabel.text = tweet?.userScreenname

            if (tweet?.userProfileImageURL != nil) {
                profileImageView.setImageWithURL((tweet?.userProfileImageURL!)!)
            }
            
            // @todo figure out how to parse NSDate
            //let time = tweet?.timestamp?.timeIntervalSinceNow
            timestampLabel.text = "17 min"
            //"\(tweet?.timestamp?.timeIntervalSinceNow)hr"
            
            if (tweet?.retweetCount == 1) {
                retweetCountLabel.text = "Retweets: \(tweet.retweetCount)"
            }
            else if (tweet?.retweetCount != nil) {
                retweetCountLabel.text = "Retweets: \(tweet.retweetCount)"
            }
            
            if (tweet?.favoritesCount == 1) {
                favoriteCountLabel.text = "Favorites: \(tweet.favoritesCount)"
            }
            else if (tweet?.favoritesCount != nil) {
                favoriteCountLabel.text = "Favorites: \(tweet.favoritesCount)"
            }
            
            // Store the ID as the button's tag to easily retweet, favorite, etc.
            if (tweet?.postID != nil ) {
                retweetButton.tag = Int((tweet?.postID)!)!
                favoriteButton.tag = Int((tweet?.postID)!)!
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Some formatting
        profileImageView.layer.cornerRadius = 3
        profileImageView.clipsToBounds = true
        
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
}
