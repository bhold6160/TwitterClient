//
//  UserTimelineViewController.swift
//  TwitterClient
//
//  Created by Brandon Holderman on 7/22/17.
//  Copyright © 2017 Brandon Holderman. All rights reserved.
//

import UIKit

class UserTimelineViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var userTimelineView: UITableView!
    
    var userTimeline: Tweet!
    
    var allTweets = [Tweet]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.userTimelineView.dataSource = self
        
        let nib = UINib(nibName: "TweetCell", bundle: nil)
        self.userTimelineView.register(nib, forCellReuseIdentifier: "tweetCell")
        
        self.userTimelineView.rowHeight = UITableViewAutomaticDimension
        self.userTimelineView.estimatedRowHeight = 75
        
        print(API.shared.test)
        API.shared.getTweetsFor(username: userTimeline.user!.screenName, completion: { (userTweets) in
            if let userTweets = userTweets {
                OperationQueue.main.addOperation {
                    self.allTweets = userTweets
                    self.userTimelineView.reloadData()
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




