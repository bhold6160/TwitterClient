//
//  UIViewController.swift
//  TwitterClient
//
//  Created by Brandon Holderman on 7/17/17.
//  Copyright © 2017 Brandon Holderman. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var retweetLabel: UILabel!
    
    var selectedTweet: Tweet!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tweetLabel.numberOfLines = 0
        
        self.usernameLabel.text = selectedTweet.user?.name
        self.tweetLabel.text = selectedTweet.text
        self.retweetLabel.text = "\(selectedTweet.retweet_count)"
    }
}
