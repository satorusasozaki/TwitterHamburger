//
//  HamburgerViewController.swift
//  TwitterHamburger
//
//  Created by Satoru Sasozaki on 11/6/16.
//  Copyright © 2016 Satoru Sasozaki. All rights reserved.
//

import UIKit

class HamburgerViewController: UIViewController {
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var contentView: UIView!
    var originalContentLeftMargin: CGFloat!
    
    var menuViewController: UIViewController! {
        didSet {
            self.view.layoutIfNeeded()
            menuView.addSubview(menuViewController.view)
        }
    }
    
    var contentViewController: UIViewController! {
        didSet {
            self.view.layoutIfNeeded()
            
            if oldValue != nil {
                oldValue.willMove(toParentViewController: nil)
                oldValue.removeFromParentViewController()
                oldValue.didMove(toParentViewController: nil)
            }
            
            contentViewController.willMove(toParentViewController: self) // calls willAppear on contentViewController
            contentView.addSubview(contentViewController.view)
            contentViewController.didMove(toParentViewController: self) // calls didAppear on contentVC
            UIView.animate(withDuration: 0.3, animations: {
                self.contentLeftMarginConstraint.constant = 0
                self.view.layoutIfNeeded()
            })
        }
    }
    
    @IBOutlet weak var contentLeftMarginConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onPanGesture(_ sender: UIPanGestureRecognizer) {
        let translation = sender.translation(in: self.view)
        let velocity = sender.velocity(in: self.view)
        
        if sender.state == UIGestureRecognizerState.began {
            originalContentLeftMargin = contentLeftMarginConstraint.constant
        } else if sender.state == UIGestureRecognizerState.changed {
            contentLeftMarginConstraint.constant = originalContentLeftMargin + translation.x
        } else if sender.state == UIGestureRecognizerState.ended {
            
            UIView.animate(withDuration: 0.3, animations: {
                if velocity.x > 0 {
                    self.contentLeftMarginConstraint.constant = self.view.frame.width - 50
                } else {
                    self.contentLeftMarginConstraint.constant = 0
                }
                self.view.layoutIfNeeded()
            })

        }
    }
}
