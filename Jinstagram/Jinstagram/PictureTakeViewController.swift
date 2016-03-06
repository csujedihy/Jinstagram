//
//  PictureTakeViewController.swift
//  Jinstagram
//
//  Created by YiHuang on 3/1/16.
//  Copyright © 2016 c2fun. All rights reserved.
//

import UIKit

class PictureTakeViewController: UIViewController {
    var takenPhoto: UIImage?
    
    
    @IBOutlet weak var captionField: UITextField!
    
    @IBOutlet weak var takenPhotoImageView: UIImageView!
    @IBOutlet weak var closeButton: UIButton!
    
    @IBAction func closeOnTap(sender: AnyObject) {
        dismissViewControllerAnimated(true) {
        
        
        
        }
    }
    
    func resize(image: UIImage, newSize: CGSize) -> UIImage {
        let resizeImageView = UIImageView(frame: CGRectMake(0, 0, newSize.width, newSize.height))
        resizeImageView.contentMode = UIViewContentMode.ScaleAspectFill
        resizeImageView.image = image
        
        UIGraphicsBeginImageContext(resizeImageView.frame.size)
        resizeImageView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    @IBAction func sendOnTap(sender: AnyObject) {

        let resizedPhoto = resize(takenPhoto!, newSize: CGSize(width: 640, height: 480))
        Post.postUserImage(resizedPhoto, withCaption: captionField.text) { (success: Bool, error: NSError?) -> Void in
            
            if success {
                print("successfully uploaded!")
                self.dismissViewControllerAnimated(true) {
                    
                }

                
            } else {
                print(error?.localizedDescription)
            }
        }
        
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        takenPhotoImageView.image = takenPhoto
        
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
