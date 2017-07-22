//
//  JSONparser.swift
//  TwitterClient
//
//  Created by Brandon Holderman on 7/8/17.
//  Copyright © 2017 Brandon Holderman. All rights reserved.
//

import Foundation

typealias JSONParserCallback = (Bool, [Tweet]?) -> ()
typealias JSONParserUserCallback = (Bool, User?) -> ()
typealias JSONParserRetweet = (Bool, Tweet?) -> ()

class JSONParser {
    static var sampleTweetData : Data {
    
        guard let path = Bundle.main.url(forResource: "tweet", withExtension: "json") else
        { fatalError("No path") }
            do {
                let data = try Data(contentsOf: path)
                return data
            } catch {
                fatalError(error.localizedDescription)
            }
        }
    
    class func tweetsFrom(data: Data, callback: JSONParserCallback) {
        do {
            if let rootObject = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [[String: Any]] {
         
                var allTweets = [Tweet]()
            
                for tweetJSON in rootObject {
                    guard let newTweet = Tweet(json: tweetJSON) else { continue }
                    allTweets.append(newTweet)
                }
                
                callback(true, allTweets)
            }
        } catch {
            print(error)
        }
    }
    
    class func fromUser(data: Data, callback: JSONParserUserCallback) {
        do {
            if let userAuth = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                let currentUser = User(json: userAuth)
                print("Recieved serialized user data")
                callback(true, currentUser)
            }
        } catch {
            print("Error")
        }
    }
    
    class func numberOfRetweets(data: Data, callback: JSONParserRetweet) {
        do {
            if let retweetCount = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                let currentCount = Tweet(json: retweetCount)
                print("Recieved retweet count")
                callback(true, currentCount)
            }
        } catch {
            print("Error")
        }
    }
}
