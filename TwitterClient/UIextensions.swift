//
//  UIextensions.swift
//  TwitterClient
//
//  Created by Brandon Holderman on 7/22/17.
//  Copyright © 2017 Brandon Holderman. All rights reserved.
//

import Foundation
import UIKit

typealias ImageCompletion = (UIImage?) -> ()

extension UIImage {
    class func fetchImageWith(urlString: String, completion: @escaping ImageCompletion) {
        OperationQueue().addOperation {
            if let url = URL(string: urlString) {
                do {
                    let data = try Data(contentsOf: url)
                    
                    OperationQueue.main.addOperation {
                        completion(UIImage(data: data))
                    }
                } catch {
                    print("There was an error getting data from URL: Error:\(error)")
                    OperationQueue.main.addOperation {
                        completion(nil)
                    }
                }
            }
        }
    }
}
