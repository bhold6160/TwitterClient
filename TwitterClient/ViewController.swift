//
//  ViewController.swift
//  TwitterClient
//
//  Created by Brandon Holderman on 7/3/17.
//  Copyright © 2017 Brandon Holderman. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var allTweets = [Tweet]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
    
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 75
        
        API.shared.getTweets { (tweets) in
            if let tweets = tweets {
                OperationQueue.main.addOperation {
                self.allTweets = tweets
                self.tableView.reloadData()
                }
            }
        }
    }

        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return allTweets.count
        }
 
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "tweetCell", for: indexPath) as! TweetCell
            
            let currentTweet = self.allTweets[indexPath.row]
            
            cell.usernameLabel.text = currentTweet.user?.name
            cell.tweetLabel.text = currentTweet.text
            
            return cell
        }
    
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath as IndexPath, animated: true)
            performSegue(withIdentifier: "detailSegue", sender: allTweets[indexPath.row])
        }
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let detailTweet = segue.destination as UIViewController
//        
//        detailTweet.
//    }
}










