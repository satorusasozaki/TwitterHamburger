//
//  HamburgerViewController.swift
//  TwitterHamburger
//
//  Created by Satoru Sasozaki on 11/6/16.
//  Copyright © 2016 Satoru Sasozaki. All rights reserved.
//

import UIKit

class HamburgerViewController: UIViewController {
    @IBOutlet weak var MenuView: UIView!
    @IBOutlet weak var ContentView: UIView!
    var originalContentLeftMargin: CGFloat!

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
