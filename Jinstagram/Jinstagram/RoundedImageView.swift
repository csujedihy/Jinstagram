//
//  RoundedImageView.swift
//  Jinstagram
//
//  Created by YiHuang on 3/5/16.
//  Copyright © 2016 c2fun. All rights reserved.
//

import UIKit

class RoundedImageView: UIImageView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    override func awakeFromNib() {
        self.clipsToBounds = true
        self.layer.cornerRadius = 15;
        self.layer.borderColor = UIColor(white: 0.7, alpha: 0.8).CGColor
        self.layer.borderWidth = 1;
    }

}
