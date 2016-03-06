//
//  ProfileViewController.swift
//  Jinstagram
//
//  Created by YiHuang on 3/5/16.
//  Copyright © 2016 c2fun. All rights reserved.
//

import UIKit
import Parse

class ProfileViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, ProfileSettingControllerDelegate {
    var otherAuthor: User?
    var photos = [Photo]()
    var headerIndexPath: NSIndexPath?
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        
        self.collectionView.registerNib(UINib(nibName: "ThumbCell", bundle: nil), forCellWithReuseIdentifier: "ThumbCell")
        if let otherAuthor = self.otherAuthor {
            Photo.lazyFetchPhotosArrayFromUser(otherAuthor, success: { (retPhotos: [Photo]) -> () in
                self.photos = retPhotos
                self.collectionView.reloadData()
                
                }) { (error: NSError?) -> () in
                    if let error = error {
                        print(error.localizedDescription)
                    }
                    
            }
        } else {
            let currentUser = User(pfUser: PFUser.currentUser()!)
            Photo.lazyFetchPhotosArrayFromUser(currentUser, success: { (retPhotos: [Photo]) -> () in
                self.photos = retPhotos
                self.collectionView.reloadData()
                
                }) { (error: NSError?) -> () in
                    if let error = error {
                        print(error.localizedDescription)
                    }
                    
            }
        }


        // Do any additional setup after loading the view.
    }
    
    func profileSetting(profileSetting: ProfileSettingController, didUpdateAvatar updatedAvatar: UIImage?) {
        if let headerIndexPath = self.headerIndexPath {
            let headerView = collectionView.supplementaryViewForElementKind(UICollectionElementKindSectionHeader, atIndexPath: headerIndexPath) as! ProfileSectionHeader
            headerView.avatarImageView.image = updatedAvatar
        }

        
    }
    
    func profileSetting(profileSetting: ProfileSettingController, didUpdateDescription updatedDescritptionText: String?) {
        if let headerIndexPath = self.headerIndexPath {
            let headerView = collectionView.supplementaryViewForElementKind(UICollectionElementKindSectionHeader, atIndexPath: headerIndexPath) as! ProfileSectionHeader
            headerView.descriptionLabel.text = updatedDescritptionText
        }
    }


    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        let cell = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: "ProfileSectionHeader", forIndexPath: indexPath) as! ProfileSectionHeader
        headerIndexPath = indexPath
        if let otherAuthor = self.otherAuthor {
            cell.descriptionLabel.text = otherAuthor.descriptionText
            cell.settingButton.hidden = true
            cell.usernameLabel.text = otherAuthor.userName
            let user = otherAuthor.pfObject
            cell.avatarImageView.parseObjectId = otherAuthor.objectId
            if let avatarImage = otherAuthor.avatarImage {
                cell.avatarImageView.image = avatarImage
                print("already has avatar!")
            } else {
                otherAuthor.lazyfetchAvatar(cell.avatarImageView, success: { (retImage: UIImage) -> () in
                    cell.avatarImageView.image = retImage
                    }, failure: { (error: NSError?) -> () in
                        print(error?.localizedDescription)
                        
                })
            }
            
            

            
            Photo.getPhotosNumber(user, success: { (count) -> () in
                cell.postNumberLabel.text = String(count!)
                }) { (error) -> () in
                    print(error?.localizedDescription)
            }
            
            
        } else {
            if let userObj = PFUser.currentUser() {
                let user = User(pfUser: userObj)
                cell.avatarImageView.parseObjectId = user.objectId
                cell.usernameLabel.text = user.userName
                cell.descriptionLabel.text = user.descriptionText
                user.lazyfetchAvatar(cell.avatarImageView, success: { (retImage: UIImage) -> () in
                    cell.avatarImageView.image = retImage
                    }, failure: { (error: NSError?) -> () in
                        print(error?.localizedDescription)
                        
                })
                Photo.getPhotosNumber(userObj, success: { (count) -> () in
                    cell.postNumberLabel.text = String(count!)
                    }) { (error) -> () in
                        print(error?.localizedDescription)
                }

            
            
            }

        
        }

        return cell

        
    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ThumbCell", forIndexPath: indexPath) as! ThumbCell
        let photo = photos[indexPath.row]
        cell.thumbImageView.parseObjectId = photo.objectId
        photo.lazyfetchImage(cell.thumbImageView, success: { (retImage: UIImage) -> () in
            cell.thumbImageView.image = retImage
            }) { (error: NSError?) -> () in
                print(error?.localizedDescription)
        }
        
        
        return cell
    }
    
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "profileSettingSegue"  {
            let vc = segue.destinationViewController as! ProfileSettingController
            vc.user = User(pfUser: PFUser.currentUser()!)
            vc.delegate = self
        
        }
    }


}
