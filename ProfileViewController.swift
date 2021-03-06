//
//  ProfileViewController.swift
//  TwitterHamburger
//
//  Created by Satoru Sasozaki on 11/7/16.
//  Copyright © 2016 Satoru Sasozaki. All rights reserved.
//

import UIKit
import MBProgressHUD

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var user: User = User.currentUser!
    var tweets: [Tweet]!
    var bannerImageUrl: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 200
        let hud = MBProgressHUD()
        hud.show(animated: true)
        TwitterClient.sharedInstance.userTimeline(user: user, success: { (tweets: [Tweet]) in
            self.tweets = tweets
            self.tableView.reloadData()
            hud.hide(animated: true)
        }, failure: {(error: Error) in
            print(error.localizedDescription)
            hud.hide(animated: true)
        })
        
        TwitterClient.sharedInstance.getProfileBanner(success: { (url :URL) in
            self.bannerImageUrl = url
            self.tableView.reloadData()
        }, failure: {(error: Error) in
            print(error.localizedDescription)
        })
    }
}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let tweets = tweets {
            return tweets.count
        }
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderCell", for: indexPath) as! HeaderCell
            
            if let profileUrl = user.profileUrl {
                cell.profileImageView.setImageWith(profileUrl)
            }
            
            if let backgroundImageUrl = user.backgroundImageUrl {
                cell.backgroundImageView.setImageWith(backgroundImageUrl)
            }
            
            return cell
            
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "StatsCell", for: indexPath) as! StatsCell
            cell.tweetsLabel.text = String(describing: (user.tweetCount)!)
            cell.followingLabel.text = String((user.followingCount)!)
            cell.followersLabel.text = String((user.followersCount)!)
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCell
        let tweet = tweets[indexPath.row]
        
        if let profileImageUrl = tweet.profileImageUrl {
            cell.profileImageView.setImageWith(profileImageUrl)
        }
        
        cell.screennameLabel.text = "@" + tweet.screenname!
        cell.usernameLabel.text = tweet.username!
        cell.tweetTextLabel.text = tweet.text!
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
