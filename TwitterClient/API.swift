//
//  API.swift
//  TwitterClient
//
//  Created by Brandon Holderman on 7/11/17.
//  Copyright © 2017 Brandon Holderman. All rights reserved.
//

import Foundation
import Accounts

typealias AccountsCompletion = (ACAccount?) -> ()

class API {
    
    static let shared = API()
    
    var account : ACAccount?
    
    private init() {}
    
    private func login(completion: @escaping AccountsCompletion) {
        let accountStore = ACAccountStore()
        
        let accountType = accountStore.accountType(withAccountTypeIdentifier: ACAccountTypeIdentifierTwitter)
        
        accountStore.requestAccessToAccounts(with: accountType) { (success, error) in
            if error != nil {
                print("ERROR: \(error!)")
                completion(nil)
                return
            }
            
            if success {
                print("Success gaining access to Twitter Accounts")
                if let accounts = accountStore.accounts(with: accountType) as? [ACAccount] {
                    completion(accounts.first) //Come back to for stretch goal
                    return
                }
            }
            
            print("No error, but success is FALSE")
            completion(nil)
        }
    }
}


