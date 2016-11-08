//
//  ProfileViewController.swift
//  TwitterHamburger
//
//  Created by Satoru Sasozaki on 11/7/16.
//  Copyright © 2016 Satoru Sasozaki. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var tweets: [Tweet]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 200
        TwitterClient.sharedInstance.userTimeline(success: { (tweets: [Tweet]) in
            self.tweets = tweets
            self.tableView.reloadData()
        }, failure: {(error: Error) in
            print(error.localizedDescription)
        })
    }
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let tweets = tweets {
            return tweets.count + 2
        }
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell", for: indexPath) as! HeaderCell
            
            if let profileUrl = User.currentUser?.profileUrl {
                cell.profileImageView.setImageWith(profileUrl)
            }
            
            if let backgroundImageUrl = User.currentUser?.backgroundImageUrl {
                cell.backgroundImageView.setImageWith(backgroundImageUrl)
            }
            
            return cell
            
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "StatsCell", for: indexPath) as! StatsCell
            cell.tweetsLabel.text = String(describing: (User.currentUser?.tweetCount)!)
            cell.followingLabel.text = String((User.currentUser?.followingCount)!)
            cell.followersLabel.text = String((User.currentUser?.followersCount)!)
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCell
        return cell
    }
}
