//
//  UIViewController.swift
//  TwitterClient
//
//  Created by Brandon Holderman on 7/15/17.
//  Copyright © 2017 Brandon Holderman. All rights reserved.
//

import Foundation
import UIKit

class DetailViewController: UITableViewController {
    
    var detailTweets = [Tweet]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detailTweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "detailCellView", for: indexPath)
        
        cell.textLabel?.detailTweets[indexPath.row]
        
        return cell
    }
}
