//
//  ProfileHeader.swift
//  Jinstagram
//
//  Created by YiHuang on 3/5/16.
//  Copyright © 2016 c2fun. All rights reserved.
//

import UIKit

class ProfileHeader: UICollectionViewCell {

    @IBOutlet weak var avatarImageView: RoundedImageView!
    
    
    @IBOutlet weak var postNumberLabel: UILabel!
    
    @IBOutlet weak var likeNumberLabel: UILabel!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
