//
//  PictureTakeViewController.swift
//  Jinstagram
//
//  Created by YiHuang on 3/1/16.
//  Copyright © 2016 c2fun. All rights reserved.
//

import UIKit
import MBProgressHUD

@objc protocol PictureTakeViewDelegate {
    func pictureTakeView(pictureTakeView: PictureTakeViewController, success: Bool)
}

class PictureTakeViewController: UIViewController {
    var takenPhoto: UIImage?
    weak var delegate: PictureTakeViewDelegate?
    
    @IBOutlet weak var toolBarTextField: UITextField!
    @IBOutlet var toolBar: UIToolbar!
    
    @IBOutlet weak var postButton: UIButton!
    @IBOutlet weak var takenPhotoImageView: UIImageView!
    @IBOutlet weak var closeButton: UIButton!
    
    
    @IBAction func closeOnTap(sender: AnyObject) {
        dismissViewControllerAnimated(true) {
        
        
        
        }
    }
    
    @IBAction func postOnTap(sender: AnyObject) {
        print("post!!!")
        self.toolBarTextField.resignFirstResponder()
        let resizedPhoto = resize(takenPhoto!, newSize: CGSize(width: 640, height: 480))
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        Post.postUserImage(resizedPhoto, withCaption: toolBarTextField.text) { (success: Bool, error: NSError?) -> Void in
            
            if success {
                print("successfully uploaded!")
                MBProgressHUD.hideHUDForView(self.view, animated: true)
                self.delegate?.pictureTakeView(self, success: true)
                self.dismissViewControllerAnimated(true) {
                }
                
                
            } else {
                print(error?.localizedDescription)
            }
        }
    }
    
    @IBAction func toolBarPost(sender: AnyObject) {

        
    }
    
    @IBAction func cancelOnTap(sender: AnyObject) {
        self.toolBarTextField.resignFirstResponder()
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
    

    
    override func canBecomeFirstResponder() -> Bool {
        return true
    }
    
    override var inputAccessoryView: UIView{
        get{
            return self.toolBar
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        takenPhotoImageView.image = takenPhoto
        
        postButton.layer.cornerRadius = 4.0
        postButton.layer.borderWidth = 1.0
        postButton.layer.borderColor = UIColor(white: 0.8, alpha: 0.79).CGColor
        
        
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
