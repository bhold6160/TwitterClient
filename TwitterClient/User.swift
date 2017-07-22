//
//  User.swift
//  TwitterClient
//
//  Created by Brandon Holderman on 7/8/17.
//  Copyright © 2017 Brandon Holderman. All rights reserved.
//

import Foundation

class User {
    let name: String
    let profileImageUrl: String
    let location: String
    let screenName: String
    
    init?(json: [String: Any]) {
        if let name = json["name"] as? String,
            let profileImageUrl = json["profile_image_url"] as? String,
            let location = json["location"] as? String,
            let screenName = json["screen_name"] as? String {
        
            self.name = name
            self.profileImageUrl = profileImageUrl
            self.location = location
            self.screenName = screenName
            
    } else {
        return nil
        }
    }
}
