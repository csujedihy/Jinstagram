//
//  ProfileViewController.swift
//  Jinstagram
//
//  Created by YiHuang on 3/5/16.
//  Copyright © 2016 c2fun. All rights reserved.
//

import UIKit
import Parse

class ProfileViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    var otherAuthor: User?
    var photos = [Photo]()
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
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
            Photo.lazyFetchPhotosArray({ (retPhotos: [Photo]) -> () in
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


    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        let cell = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: "ProfileSectionHeader", forIndexPath: indexPath) as! ProfileSectionHeader
        if let otherAuthor = self.otherAuthor {
            let user = otherAuthor.pfObject
            cell.usernameLabel.text = user?.username
            Photo.getPhotosNumber(user, success: { (count) -> () in
                cell.postNumberLabel.text = String(count!)
                }) { (error) -> () in
                    print(error?.localizedDescription)
            }
        } else {
            let user = PFUser.currentUser()
            cell.usernameLabel.text = user?.username
            Photo.getPhotosNumber(user, success: { (count) -> () in
                cell.postNumberLabel.text = String(count!)
                }) { (error) -> () in
                    print(error?.localizedDescription)
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
