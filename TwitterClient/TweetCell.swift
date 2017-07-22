//
//  TweetCellTableViewCell.swift
//  TwitterClient
//
//  Created by Brandon Holderman on 7/18/17.
//  Copyright © 2017 Brandon Holderman. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var retweetLabel: UILabel!
    @IBOutlet weak var userProfileImage: UIImageView!
    
    var tweet: Tweet! {
        didSet {
            self.tweetLabel.text = tweet.text
            self.retweetLabel.text = "Retweets: \(tweet.retweet_count)"
            
            if let user = tweet.user {
                self.usernameLabel.text = user.name
                
                UIImage.fetchImageWith(urlString: user.profileImageUrl, completion: {
                    (userProfileImage) in
                    self.userProfileImage.layer.cornerRadius = 10
                    self.userProfileImage.image = userProfileImage
                })
            }
        }
    }
}
