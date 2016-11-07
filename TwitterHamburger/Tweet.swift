//
//  Tweet.swift
//  TwitterHamburger
//
//  Created by Satoru Sasozaki on 11/7/16.
//  Copyright © 2016 Satoru Sasozaki. All rights reserved.
//

// to create a model
// 1. Enumerate all your properties
// 2. Write a contructor that de-serializes an API response

import UIKit

class Tweet: NSObject {
    
    var text: String?
    var timestamp: Date?
    var retweetCount: Int = 0
    var favoritesCount: Int = 0
    var username: String?
    var screenname: String?
    var profileImageUrl: URL?
    var id: Int = 0
    
    init(dictionary: [String:AnyObject]) {
        text = dictionary["text"] as? String
        retweetCount = (dictionary["retweet_count"] as? Int) ?? 0
        favoritesCount = (dictionary["favourites_count"] as? Int) ?? 0
        let timestampString = dictionary["created_at"] as? String
        if let timestampString = timestampString {
            let formatter = DateFormatter()
            formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
            timestamp = formatter.date(from: timestampString)
        }
        username = dictionary["user"]?["name"] as? String
        let profileImageUrlString = dictionary["user"]?["profile_image_url_https"] as? String
        if let urlString = profileImageUrlString {
            profileImageUrl = URL(string: urlString)
        }
        
        id = dictionary["id"] as! Int
        screenname = dictionary["user"]?["screen_name"] as? String
    }
    
    class func tweetsWithArray(dictionaries: [AnyObject]) -> [Tweet] {
        var tweets = [Tweet]()
        for dictionary in dictionaries {
            let dic = dictionary as! [String:AnyObject]
            let tweet = Tweet(dictionary: dic)
            tweets.append(tweet)
        }
        return tweets
    }
}
