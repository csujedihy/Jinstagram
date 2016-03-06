//
//  DetailPhotoViewController.swift
//  Jinstagram
//
//  Created by Yi Huang on 16/3/6.
//  Copyright © 2016年 c2fun. All rights reserved.
//

import UIKit

class DetailPhotoViewController: UIViewController {

    var avatarImage: UIImage?
    var photoImage: UIImage?

    var username: String?
    var caption: String?
    var createAtString: String?
    
    @IBOutlet weak var avatarImageView: RoundedImageView!
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var photoView: UIImageView!
    
    @IBOutlet weak var captionLabel: UILabel!
    
    @IBOutlet weak var createAtLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let avatarImage = self.avatarImage {
            avatarImageView.image = avatarImage
        }
        
        photoView.image = photoImage
        usernameLabel.text = username
        captionLabel.text = caption
        if let createAtString = self.createAtString {
            createAtLabel.text = "created at \(createAtString) ago"
        } else {
            createAtLabel.text = ""

        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
