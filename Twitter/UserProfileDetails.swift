//
//  UserProfileDetails.swift
//  Twitter
//
//  Created by Cory Avra on 2/26/16.
//  Copyright © 2016 coryavra. All rights reserved.
//

import UIKit

class UserProfileDetails: UIView {

    // Outlets
    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
   
    // Variables
    var user: User! {
        didSet {
            
            nameLabel.text = user?.name
            
            if (user?.backgroundImageURL != nil) {
                bannerImageView.setImageWithURL((user?.backgroundImageURL)!)
            }
            
        }
    }

}
