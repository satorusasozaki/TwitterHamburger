//
//  User.swift
//  TwitterHamburger
//
//  Created by Satoru Sasozaki on 11/7/16.
//  Copyright © 2016 Satoru Sasozaki. All rights reserved.
//

import UIKit

class User: NSObject {
    
    var id: Int?
    var name: String?
    var screenname: String?
    var profileUrl: URL?
    var backgroundImageUrl: URL?
    var tagline: String?
    var tweetCount: Int?
    var followingCount: Int?
    var followersCount: Int?
    
    var dictionary: [String:AnyObject]?
    
    init(dictionary: [String:AnyObject]) {
        self.dictionary = dictionary
        
        // de-serialization
        id = dictionary["id"] as? Int
        name = dictionary["name"] as? String
        screenname = dictionary["screen_name"] as? String
        let profileUrlString = dictionary["profile_image_url_https"] as? String
        if let profileUrlString = profileUrlString {
            profileUrl = URL(string: profileUrlString)
        }
        
        let backgroundImageUrlString = dictionary["profile_background_image_url_https"] as? String
        if let backgroundImageUrlString = backgroundImageUrlString {
            backgroundImageUrl = URL(string: backgroundImageUrlString)
        }

        tagline = dictionary["description"] as? String
        
        tweetCount = dictionary["statuses_count"] as? Int
        followingCount = dictionary["friends_count"] as? Int
        followersCount = dictionary["followers_count"] as? Int
    }
    
    static let userDidLogoutNotification = Notification.Name(rawValue: "UserDidLogout")
    
    static var _currentUser: User?
    
    class var currentUser: User? {
        get {
            if _currentUser == nil {
                let defaults = UserDefaults.standard
                let userData = defaults.object(forKey: "currentUserData") as? Data
                
                if let userData = userData {
                    let dictionary = try? JSONSerialization.jsonObject(with: userData, options: []) as! [String:AnyObject]
                    if let dictionary = dictionary {
                        _currentUser = User(dictionary: dictionary)
                    }
                }
            }
            return _currentUser
        }
        
        set(user) {
            _currentUser = user
            
            let defaults = UserDefaults.standard
            if let user = user {
                let data = try! JSONSerialization.data(withJSONObject: user.dictionary!, options: [])
                defaults.set(data, forKey: "currentUserData")
            } else {
                defaults.set(nil, forKey: "currentUserData")
            }
        }
    }
}
