//
//  PhotoCell.swift
//  Jinstagram
//
//  Created by YiHuang on 3/1/16.
//  Copyright © 2016 c2fun. All rights reserved.
//

import UIKit

class PhotoCell: UITableViewCell {
    var cellId: Int?
    @IBOutlet weak var captionLabel: UILabel!
    
    @IBOutlet weak var photoView: YHLazyImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
