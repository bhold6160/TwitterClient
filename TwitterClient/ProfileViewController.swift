//
//  ProfileViewController.swift
//  TwitterClient
//
//  Created by Brandon Holderman on 7/19/17.
//  Copyright © 2017 Brandon Holderman. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var userProfileImage: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var userTweetTable: UITableView!
    
    var selectedUser: User!
    var selectedUserTweets: Tweet!
     var allTweets = [Tweet]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    

        API.shared.getOAuthUser { (userProfile) in
            if let userProfile = userProfile {
                OperationQueue.main.addOperation {
                    self.selectedUser = userProfile
                    
                    if let user = self.selectedUser {
                        self.usernameLabel.text = self.selectedUser.name
                        
                        UIImage.fetchImageWith(urlString: user.profileImageUrl, completion: {
                            (userProfileImage) in
                            self.userProfileImage.layer.cornerRadius = 10
                            self.userProfileImage.image = userProfileImage
                        })
                    }
                }
            }
        }
        
        self.userTweetTable.dataSource = self
        
        let nib = UINib(nibName: "TweetCell", bundle: nil)
        self.userTweetTable.register(nib, forCellReuseIdentifier: "tweetCell")
        
        self.userTweetTable.rowHeight = UITableViewAutomaticDimension
        self.userTweetTable.estimatedRowHeight = 75
        
        API.shared.getTweetsFor(username: "bholderman44", completion: { (userTweets) in
            if let userTweets = userTweets {
                OperationQueue.main.addOperation {
                    self.allTweets = userTweets
                    self.userTweetTable.reloadData()
                }
            }
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allTweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell", for: indexPath) as! TweetCell
        
        let currentTweet = self.allTweets[indexPath.row]
        
        cell.tweet = currentTweet
        
        return cell
    }

}
