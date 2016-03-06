//
//  ProfileSectionHeader.swift
//  Jinstagram
//
//  Created by YiHuang on 3/5/16.
//  Copyright © 2016 c2fun. All rights reserved.
//

import UIKit

class ProfileSectionHeader: UICollectionReusableView {
    @IBOutlet weak var avatarImageView: YHLazyImageView!
    
    
    @IBOutlet weak var postNumberLabel: UILabel!
    
    @IBOutlet weak var likeNumberLabel: UILabel!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var settingButton: UIButton!
    
    override func awakeFromNib() {
        avatarImageView.clipsToBounds = true
        avatarImageView.layer.cornerRadius = 15;
        avatarImageView.layer.borderColor = UIColor(white: 0.7, alpha: 0.8).CGColor
        avatarImageView.layer.borderWidth = 1;
    }
    
    
}
