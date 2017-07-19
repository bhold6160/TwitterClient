//
//  Tweet.swift
//  TwitterClient
//
//  Created by Brandon Holderman on 7/8/17.
//  Copyright © 2017 Brandon Holderman. All rights reserved.
//

import Foundation

class Tweet {
    let text: String
    let id: String
    let retweet_count: Int
    
    var user: User?
    
    init?(json: [String: Any]) {
        if let text = json["text"] as? String,
            let id = json["id_str"] as? String,
            let userJSON = json["user"] as? [String: Any],
            let numberOfRetweets = json["retweet_count"] as? Int {
            
            self.text = text
            self.id = id
            self.retweet_count = numberOfRetweets
            
            let newUser = User(json: userJSON)
            
            self.user = newUser
            
        } else {
            return nil
        }
    }
}
