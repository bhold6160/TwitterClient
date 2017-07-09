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
    
    var user: User?
    
    init?(json: [String: Any]) {
        if let text = json["text"] as? String,
            let id = json["id_str"] as? String,
            let userJSON = json["user"] as? [String: Any] {
            
            self.text = text
            self.id = id
            
            let newUser = User(json: userJSON)
            
            self.user = newUser
            
        } else {
            return nil
        }
    }
}
