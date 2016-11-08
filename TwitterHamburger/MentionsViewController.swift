//
//  MentionsViewController.swift
//  TwitterHamburger
//
//  Created by Satoru Sasozaki on 11/7/16.
//  Copyright © 2016 Satoru Sasozaki. All rights reserved.
//

import UIKit
import MBProgressHUD

class MentionsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var user: User = User.currentUser!
    var tweets: [Tweet]!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 200
        let hud = MBProgressHUD()
        hud.show(animated: true)
        TwitterClient.sharedInstance.mentionsTimeline(user: user, success: { (tweets: [Tweet]) in
            self.tweets = tweets
            self.tableView.reloadData()
            hud.hide(animated: true)
        }, failure: {(error: Error) -> () in
            print(error.localizedDescription)
            hud.hide(animated: true)
        })
    }
}

extension MentionsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let tweets = tweets {
            return tweets.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetCell
        let tweet = tweets[indexPath.row]
        
        if let profileImageUrl = tweet.profileImageUrl {
            cell.profileImageView.setImageWith(profileImageUrl)
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        cell.screennameLabel.text = tweet.screenname
        cell.usernameLabel.text = tweet.username
        cell.tweetTextLabel.text = tweet.text
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let tweet = tweets[indexPath.row]
        let userId = tweet.userId
        let screenname = tweet.screenname
        TwitterClient.sharedInstance.showUser(userId: userId, screenname: screenname, success: {(user: User) in
            let profileViewController = self.storyboard?.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
            profileViewController.user = user
            self.navigationController?.pushViewController(profileViewController, animated: true)
        } , failure: {(error: Error) in
            print(error.localizedDescription)
        })
    }
}
