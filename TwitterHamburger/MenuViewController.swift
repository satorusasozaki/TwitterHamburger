//
//  MenuViewController.swift
//  TwitterHamburger
//
//  Created by Satoru Sasozaki on 11/6/16.
//  Copyright © 2016 Satoru Sasozaki. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    private var profileNavigationController: UIViewController!
    private var timelineNavigationController: UIViewController!
    private var mentionsNavigationController: UIViewController!
    
    var viewControllers: [UIViewController] = []
    var hamburgerViewController: HamburgerViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self

        profileNavigationController = storyboard?.instantiateViewController(withIdentifier: "profileNavigationController")
        timelineNavigationController = storyboard?.instantiateViewController(withIdentifier: "timelineNavigationController")
        mentionsNavigationController = storyboard?.instantiateViewController(withIdentifier: "mentionsNavigationController")
        
        viewControllers.append(profileNavigationController)
        viewControllers.append(timelineNavigationController)
        viewControllers.append(mentionsNavigationController)
        
        hamburgerViewController.contentViewController = profileNavigationController
    }
}

extension MenuViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewControllers.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) as! MenuCell
        if indexPath.row == 3 {
            cell.viewControllerLabel.text = "Logout"
        } else {
            let titles = ["Profile", "Timeline", "Mentions"]
            cell.viewControllerLabel.text = titles[indexPath.row]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 3 {
            TwitterClient.sharedInstance.logout()
        } else {
            hamburgerViewController.contentViewController = viewControllers[indexPath.row]
        }
    }
}
