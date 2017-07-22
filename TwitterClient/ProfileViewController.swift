//
//  ProfileViewController.swift
//  TwitterClient
//
//  Created by Brandon Holderman on 7/19/17.
//  Copyright © 2017 Brandon Holderman. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    

    var selectedUser: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        API.shared.getOAuthUser { (userProfile) in
            if let userProfile = userProfile {
                OperationQueue.main.addOperation {
                    self.selectedUser = userProfile
                }
            }
        }
    }
}
