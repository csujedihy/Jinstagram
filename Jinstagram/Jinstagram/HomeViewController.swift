//
//  HomeViewController.swift
//  Jinstagram
//
//  Created by YiHuang on 3/1/16.
//  Copyright © 2016 c2fun. All rights reserved.
//

import UIKit
import Parse
class HomeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDataSource, UITableViewDelegate {
    var photos = [Photo]()
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func cameraOnTap(sender: AnyObject) {
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
    
    
    
//    @IBAction func takePicOnTap(sender: AnyObject) {
//        let vc = UIImagePickerController()
//        vc.delegate = self
//        vc.allowsEditing = true
//        vc.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
//        
//        self.presentViewController(vc, animated: true, completion: nil)
//    }
//    
    func imagePickerController(picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [String : AnyObject]) {
            print("asdasd")
            let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
            let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
            dismissViewControllerAnimated(true, completion: {
                self.performSegueWithIdentifier("uploadedSegue", sender: editedImage)
            })
    }
    
    @IBAction func logoutOnTap(sender: AnyObject) {
        PFUser.logOut()
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.hidden = false
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return photos.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = tableView.dequeueReusableCellWithIdentifier("PhotoHeader") as! PhotoHeader
        headerView.rowIndex = section
        let photo = photos[section]
        if let user = photo.user {
            headerView.usernameLabel.text = user.userName
        }
        
        if headerView.avatarImage.userInteractionEnabled == false {
            headerView.avatarImage.userInteractionEnabled = true
            let tapGesture = UITapGestureRecognizer(target: self, action: "profileTap:")
            headerView.avatarImage.addGestureRecognizer(tapGesture)
        }
        
        if let timeBetween = photo.createdAtString {
            headerView.timeLabel.text = timeBetween
        }
        
        return headerView
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
        
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PhotoCell", forIndexPath: indexPath) as! PhotoCell
        let photo = photos[indexPath.section]
        cell.cellId = indexPath.section
        cell.photoView.parseObjectId = photo.objectId
        photo.lazyfetchImage(cell.photoView, success: { (retImage: UIImage) -> () in
            cell.photoView.image = retImage
            }) { (error: NSError?) -> () in
                print(error?.localizedDescription)
        }

        cell.captionLabel.text = photo.caption
        
        return cell
    }
    
    func profileTap (sender: UITapGestureRecognizer) {
        print("tapOnProfile")
        let headerView = sender.view?.superview?.superview as! PhotoHeader
        let rowIndex = headerView.rowIndex
        if let index = rowIndex {
            let photo = photos[index]
            performSegueWithIdentifier("profileSegueFromHome", sender: photo.user)
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerNib(UINib(nibName: "PhotoCell", bundle: nil), forCellReuseIdentifier: "PhotoCell")
        tableView.registerNib(UINib(nibName: "PhotoHeader", bundle: nil), forCellReuseIdentifier: "PhotoHeader")
        
        tableView.estimatedRowHeight = 260
        tableView.rowHeight = UITableViewAutomaticDimension
        
        Photo.lazyFetchPhotosArray({ (retPhotos: [Photo]) -> () in
            self.photos = retPhotos
            self.tableView.reloadData()
            
            }) { (error: NSError?) -> () in
                if let error = error {
                    print(error.localizedDescription)
                }
                
        }
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "uploadedSegue" {
            let takenphoto = sender as! UIImage
            let vc = segue.destinationViewController as! PictureTakeViewController
            vc.takenPhoto = takenphoto
            
        
        } else if segue.identifier == "profileSegueFromHome" {
            let vc = segue.destinationViewController as! ProfileViewController
            let user = sender as! User
            vc.otherAuthor = user
        }
    }


}
