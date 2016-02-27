//
//  TweetingViewController.swift
//  Twitter
//
//  Created by Cory Avra on 2/26/16.
//  Copyright © 2016 coryavra. All rights reserved.
//

import UIKit

class ComposeViewController: UIViewController {

    // Outlets
    @IBOutlet weak var tweetField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    override func viewWillAppear(animated: Bool) {
        tweetField.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
}
