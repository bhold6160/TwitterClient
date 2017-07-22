//
//  ProfileViewController.swift
//  TwitterClient
//
//  Created by Brandon Holderman on 7/19/17.
//  Copyright © 2017 Brandon Holderman. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var userProfileImage: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    
    var selectedUser: User!
    
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
    }
}
