//
//  StatsCell.swift
//  TwitterHamburger
//
//  Created by Satoru Sasozaki on 11/7/16.
//  Copyright © 2016 Satoru Sasozaki. All rights reserved.
//

import UIKit

class StatsCell: UITableViewCell {

    @IBOutlet weak var tweetsLabel: UILabel!
    @IBOutlet weak var followingLabel: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
