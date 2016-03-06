//
//  PhotoHeader.swift
//  Jinstagram
//
//  Created by YiHuang on 3/5/16.
//  Copyright © 2016 c2fun. All rights reserved.
//

import UIKit

class PhotoHeader: UITableViewCell {
    var rowIndex: Int?
    @IBOutlet weak var avatarImage: YHLazyImageView!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        avatarImage.clipsToBounds = true
        avatarImage.layer.cornerRadius = 15;
        avatarImage.layer.borderColor = UIColor(white: 0.7, alpha: 0.8).CGColor
        avatarImage.layer.borderWidth = 1;
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
