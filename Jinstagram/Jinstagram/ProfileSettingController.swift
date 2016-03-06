//
//  ProfileSettingController.swift
//  Jinstagram
//
//  Created by Yi Huang on 16/3/5.
//  Copyright © 2016年 c2fun. All rights reserved.
//

import UIKit

@objc protocol ProfileSettingControllerDelegate {
    optional func profileSetting(profileSetting: ProfileSettingController, didUpdateDescription updatedDescritptionText: String?)
    optional func profileSetting(profileSetting: ProfileSettingController, didUpdateAvatar updatedAvatar: UIImage?)

}

class ProfileSettingController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UpdateDescriptionViewControllerDelegate {
    
    @IBOutlet weak var avatarImageView: YHLazyImageView!
    @IBOutlet weak var descriptionPreviewLabel: UILabel!
    @IBOutlet weak var profilePhotoCell: UITableViewCell!
    var user: User?
    weak var delegate: ProfileSettingControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        avatarImageView.clipsToBounds = true
        avatarImageView.layer.cornerRadius = 15
        avatarImageView.layer.borderColor = UIColor(white: 0.7, alpha: 0.8).CGColor
        avatarImageView.layer.borderWidth = 1
        avatarImageView.parseObjectId = user?.objectId
        
        user?.lazyfetchAvatar(avatarImageView, success: { (retImage: UIImage) -> () in
            self.avatarImageView.image = retImage
            }, failure: { (error: NSError?) -> () in
            print(error?.localizedDescription)
        })
        
        descriptionPreviewLabel.text = user?.descriptionText

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 2
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let cell = self.tableView.cellForRowAtIndexPath(indexPath)
        if cell == profilePhotoCell {
            let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
            let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) {
                (action) in
                
            }
            
            let cameraAction = UIAlertAction(title: "Take Picture", style: .Default) {
                (action)in
                let vc = UIImagePickerController()
                vc.delegate = self
                vc.allowsEditing = true
                vc.sourceType = UIImagePickerControllerSourceType.Camera
                self.presentViewController(vc, animated: true, completion: nil)
            }
            
            let libraryAction = UIAlertAction(title: "Photo Library", style: .Default) {
                (action) in
                let vc = UIImagePickerController()
                vc.delegate = self
                vc.allowsEditing = true
                vc.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
                self.presentViewController(vc, animated: true, completion: nil)
                
            }
            
            alertController.addAction(cameraAction)
            alertController.addAction(libraryAction)
            alertController.addAction(cancelAction)
            self.presentViewController(alertController, animated: true, completion: nil)
        
        }
    }
    
    func updateDescriptionView(updateDescriptionView: UpdateDescriptionViewController, didUpdateDescription description: String?) {
        descriptionPreviewLabel.text = description
        delegate?.profileSetting?(self, didUpdateDescription: description)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        let resizedImage = editedImage.resize(CGSize(width: 320, height: 240))
        dismissViewControllerAnimated(true, completion: {
            self.user?.updateProfilePhoto(resizedImage, withCompletion: { (success: Bool, error: NSError?) -> Void in
                if success {
                    self.avatarImageView.image = resizedImage
                    self.delegate?.profileSetting?(self, didUpdateAvatar: resizedImage)
                    print("updated Avatar")
                } else {
                
                    
                }
            })
        })
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "descriptionSeuge" {
            let vc = segue.destinationViewController as! UpdateDescriptionViewController
            vc.user = self.user
            vc.delegate = self
        }
    }


}
