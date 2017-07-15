//
//  API.swift
//  TwitterClient
//
//  Created by Brandon Holderman on 7/11/17.
//  Copyright © 2017 Brandon Holderman. All rights reserved.
//

import Foundation
import Accounts
import Social

typealias AccountsCompletion = (ACAccount?) -> ()
typealias TweetsCompletion = ([Tweet]?) -> ()
typealias UserCompletion = (User?) -> ()

class API {
    
    static let shared = API()
    
    var account : ACAccount?
    
    private init() {}
    
    private func login(completion: @escaping AccountsCompletion) {
        let accountStore = ACAccountStore()
        
        let accountType = accountStore.accountType(withAccountTypeIdentifier: ACAccountTypeIdentifierTwitter)
        
        accountStore.requestAccessToAccounts(with: accountType, options: nil) { (success, error) in
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
    
    func getOAuthUser(completion: @escaping UserCompletion) {
        let url = URL(string: "https://api.twitter.com/1.1/account/verify_credentials.json")
        
        let request = SLRequest(forServiceType: SLServiceTypeTwitter,
                                requestMethod: .GET,
                                url: url,
                                parameters: nil)
        
        request?.account = self.account
        
        request?.perform(handler:{ (data, response, error) in
            if error != nil {
                print("Erro Authenticating User: \(error!.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let response = response else {
                completion(nil)
                return
            }
            
            guard let data = data else {
                completion(nil)
                return
            }
            
            switch response.statusCode {
            case 200...299:
                print("Authorization Successful!")
                JSONParser.fromUser(data: data, callback: { (success, currentUser) in
                    completion(currentUser)
            })
            case 400...499:
                print("Client-side error, this is our fault... \(response.statusCode)")
            case 500...599:
                print("Server-side error, this is NOT our fault! \(response.statusCode)")
            default:
                print("Unrecognixed Status Code: \(response.statusCode)")
            }
        })
    }
    
    private func updateTimeline(completion: @escaping TweetsCompletion) {
        
        let url = URL(string: "https://api.twitter.com/1.1/statuses/home_timeline.json")
        
        let request = SLRequest(forServiceType: SLServiceTypeTwitter,
                                requestMethod: .GET,
                                url: url,
                                parameters: nil)
        
        print("The Service type constant for Twitter: \(SLServiceTypeTwitter)")
        
        request?.account = self.account
        
        request?.perform(handler:{ (data, response, error) in
            if error != nil {
                print("Error fecthing HomeTimeline: \(error!.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let response = response else {
                completion(nil)
                return
            }
            
            guard let data = data else {
                completion(nil)
                return
            }
            
            switch response.statusCode {
            case 200...299:
                print("Success!")
                JSONParser.tweetsFrom(data: data, callback: { (success, tweets) in
                    completion(tweets)
                })
            case 400...499:
                print("Client-side error, this is our fault... \(response.statusCode)")
            case 500...599:
                print("Server-side error, this is NOT our fault! \(response.statusCode)")
            default:
                print("Unrecognized Status Code: \(response.statusCode)")
            }
        })
    }
    
    func getTweets(completion: @escaping TweetsCompletion) {
        if self.account == nil {
            self.login(completion: { (account) in
                self.account = account
                self.updateTimeline(completion: { (tweets) in
                    completion(tweets)
                })
            })
        } else {
            self.updateTimeline(completion: { (tweets) in
                completion(tweets)
            })
        }
    }
}


