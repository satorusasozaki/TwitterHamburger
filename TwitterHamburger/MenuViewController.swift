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
    
    private var greenNavigationController: UIViewController!
    private var blueNavigationController: UIViewController!
    private var redNavigationController: UIViewController!
    
    var viewControllers: [UIViewController] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self

        greenNavigationController = storyboard?.instantiateViewController(withIdentifier: "greenNavigationController")
        blueNavigationController = storyboard?.instantiateViewController(withIdentifier: "blueNavigationController")
        redNavigationController = storyboard?.instantiateViewController(withIdentifier: "redNavigationController")
        
        viewControllers.append(greenNavigationController)
        viewControllers.append(blueNavigationController)
        viewControllers.append(redNavigationController)
    }
}

extension MenuViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewControllers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MenuCell", for: indexPath) as! MenuCell
        let titles = ["Green", "Blue", "Red"]
        cell.viewControllerLabel.text = titles[indexPath.row]
        return cell
    }
}
