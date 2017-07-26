//
//  UserTimelineViewController.swift
//  TwitterClient
//
//  Created by Brandon Holderman on 7/22/17.
//  Copyright © 2017 Brandon Holderman. All rights reserved.
//

import UIKit

class UserTimelineViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var userTimelineView: UITableView!
    
    var userTimeline: Tweet!
    
    var allTweets = [Tweet]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        API.shared.getTweetsFor(username: userTimeline.user?.screenName, completion: { (userTweets) in
            if let userTweets = userTweets {
                OperationQueue.main.addOperation {
                    self.allTweets = userTweets
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
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        super.prepare(for: segue, sender: sender)
//        if segue.identifier == "userViewSegue" {
//            if let selectedIndex = self.tableView.indexPathForSelectedRow {
//                let selectedTweet = self.allTweets[selectedIndex.row]
//                
//                if let destinationController = segue.destination as? UserTimelineViewController {
//                    destinationController.selectedTweet = selectedTweet
//                }
//            }
//        }
//    }
}
