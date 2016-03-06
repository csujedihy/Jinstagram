//
//  UpdateDescriptionViewController.swift
//  Jinstagram
//
//  Created by Yi Huang on 16/3/5.
//  Copyright © 2016年 c2fun. All rights reserved.
//

import UIKit

@objc protocol UpdateDescriptionViewControllerDelegate {
    func updateDescriptionView(updateDescriptionView: UpdateDescriptionViewController, didUpdateDescription description: String?)
    
}

class UpdateDescriptionViewController: UIViewController, UITextViewDelegate {
    var user: User?
    @IBOutlet weak var descriptionContent: UITextView!
    var placeHolderLabel: UILabel!
    weak var delegate: UpdateDescriptionViewControllerDelegate?
    
    
    func textViewDidBeginEditing(textView: UITextView) {
        placeHolderLabel.hidden = true
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        if textView.text.isEmpty {
            placeHolderLabel.hidden = false
        }
    }
    
    @IBAction func doneOnTap(sender: AnyObject) {
        if let user = self.user {
            user.updateDescription(descriptionContent.text, withCompletion: { (success: Bool, error: NSError?) -> Void in
                if success {
                    print("description Updated!")
                    self.delegate?.updateDescriptionView(self, didUpdateDescription: self.descriptionContent.text)
                    if let navController = self.navigationController {
                        navController.popViewControllerAnimated(true)
                    }
                } else {
                    print(error?.localizedDescription)
                }
            })
        
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        descriptionContent.delegate = self
        placeHolderLabel = UILabel()
        placeHolderLabel.text = "What's happening?"
        placeHolderLabel.sizeToFit()
        placeHolderLabel.textColor = UIColor(white: 0, alpha: 0.3)
        placeHolderLabel.hidden = !descriptionContent.text.isEmpty
        descriptionContent.addSubview(placeHolderLabel)
        self.automaticallyAdjustsScrollViewInsets = false
        
        
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
