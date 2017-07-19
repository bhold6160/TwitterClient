//
//  UIViewController.swift
//  TwitterClient
//
//  Created by Brandon Holderman on 7/17/17.
//  Copyright © 2017 Brandon Holderman. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    
//    @IBOutlet weak var detailView: UIViewController!
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    
    var selectedTweet: Tweet!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.usernameLabel.text = selectedTweet.user?.name
        self.tweetLabel.text = selectedTweet.text
        
        
        print("DETAILVIEW CONTROLLER GOT THE FOLLOWING TWEET")
    }
}
