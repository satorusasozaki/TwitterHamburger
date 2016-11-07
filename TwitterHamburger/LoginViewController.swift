//
//  LoginViewController.swift
//  TwitterHamburger
//
//  Created by Satoru Sasozaki on 11/7/16.
//  Copyright © 2016 Satoru Sasozaki. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onLoginButton(_ sender: UIButton) {
        TwitterClient.sharedInstance.login(succeess: {
            let hamburgerViewController = self.storyboard?.instantiateViewController(withIdentifier: "HamburgerViewController") as! HamburgerViewController
            let menuViewController = self.storyboard?.instantiateViewController(withIdentifier: "MenuViewController") as! MenuViewController
            menuViewController.hamburgerViewController = hamburgerViewController
            hamburgerViewController.menuViewController = menuViewController
            self.present(hamburgerViewController, animated: true, completion: nil)
        }, failure: {(error: Error) -> () in
            print(error.localizedDescription)
        })
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
