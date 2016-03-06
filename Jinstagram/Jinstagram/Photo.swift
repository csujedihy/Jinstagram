//
//  Photo.swift
//  Jinstagram
//
//  Created by YiHuang on 3/1/16.
//  Copyright © 2016 c2fun. All rights reserved.
//

import UIKit
import Parse


class Photo: NSObject {
    var user: User?
    var pfObject: PFObject?
    var objectId: String?
    var image: UIImage?
    var caption: String?
    var createdAt: NSDate?
    var createdAtString: String?
    
    static let sharedCache: NSCache = {
        let cache = NSCache()
        cache.name = "PhotoCache"
        cache.countLimit = 50 // Max 20 images in memory.
        cache.totalCostLimit = 10 * 1024 * 1024 // Max 10MB used.
        return cache
    }()
    
    init(pfObject: PFObject) {
        self.pfObject = pfObject
        self.objectId = pfObject.objectId
        if let caption = pfObject.objectForKey("caption") {
            self.caption = caption as? String
        }
        if let user = pfObject.objectForKey("author") as? PFUser {
            self.user = User(pfUser: user)
        }
        
        if let createdAt = pfObject.createdAt {
            self.createdAt = createdAt
            self.createdAtString = self.createdAt?.between()
            print(createdAtString)
        }
        
        
    }
    
    
    init(image: UIImage, caption: String) {
        self.image = image
        self.caption = caption
    
    }

    func lazyfetchImage(signatureImage: YHLazyImageView, success: (retImage: UIImage) ->(), failure: (NSError?) ->()) {
        if let pfObject = self.pfObject {
            if let objectId = self.objectId {
                if let cachedImage = Photo.sharedCache.objectForKey(objectId) {
                    print("cached")
                    success(retImage: cachedImage as! UIImage)
                    return
                }
            }
            let imageFile = pfObject.objectForKey("media") as! PFFile
            imageFile.getDataInBackgroundWithBlock({ (result: NSData?, error: NSError?) -> Void in
                if signatureImage.parseObjectId != self.objectId {
                    failure(NSError(domain: "ParseLazyPhotoLoading", code: 1000, userInfo: nil))
                    return
                }
                if let result = result {
                    if let resUIImage = UIImage(data: result) {
                        if let objectId = self.objectId {
                            Photo.sharedCache.setObject(resUIImage, forKey: objectId, cost: result.length)
                        }
                        self.image = resUIImage
                        success(retImage: resUIImage)
                    } else {
                        failure(error)
                    }
                    
                } else {
                    failure(error)

                }
                
            })
        
        } else {
            failure(nil)
        }

    }
    
    
    class func lazyFetchPhotosArrayFromUser(user: User, success: (retPhotos: [Photo]) ->(), failure: (NSError?) ->()) {
        let query = PFQuery(className: "Post")
        query.orderByDescending("createdAt")
        query.whereKey("author", equalTo: user.pfObject!)
        query.includeKey("author")
        query.limit = 20
        // fetch data asynchronously
        
        query.findObjectsInBackgroundWithBlock { (media: [PFObject]?, error: NSError?) -> Void in
            if let media = media {
                var photos = [Photo]()
                for pfObj in media {
                    let photo = Photo(pfObject: pfObj)
                    photos.append(photo)
                    
                }
                success(retPhotos: photos)
                
                // do something with the data fetched
            } else {
                // handle error
                failure(error)
            }
        }
    }
    
    
    class func lazyFetchPhotosArray(success: (retPhotos: [Photo]) ->(), failure: (NSError?) ->()) {
        let query = PFQuery(className: "Post")
        query.orderByDescending("createdAt")
        query.includeKey("author")
        query.limit = 20
        // fetch data asynchronously
        
        query.findObjectsInBackgroundWithBlock { (media: [PFObject]?, error: NSError?) -> Void in
            if let media = media {
                var photos = [Photo]()
                for pfObj in media {
                    let photo = Photo(pfObject: pfObj)
                    photos.append(photo)
                    
                }
                success(retPhotos: photos)
                
                // do something with the data fetched
            } else {
                // handle error
                failure(error)
            }
        }
        
    }
    
    class func fetchPhotosArray(success: (retPhotos: [Photo]) ->(), failure: (NSError?) ->()) {
        let query = PFQuery(className: "Post")
        query.orderByDescending("createdAt")
        query.includeKey("author")
        query.limit = 20
        var photos = [Photo]()
        // fetch data asynchronously

        query.findObjectsInBackgroundWithBlock { (media: [PFObject]?, error: NSError?) -> Void in
            if let media = media {
                let mediaNum = media.count
                print(mediaNum)
                var currentMedia = 0
                for pfObj in media {
                    currentMedia += 1
                    let id = pfObj.objectId
                    print(id)
                    
                    let author = pfObj.objectForKey("caption") as! String
                    let imageFile = pfObj.objectForKey("media") as! PFFile
                    imageFile.getDataInBackgroundWithBlock({ (result: NSData?, error: NSError?) -> Void in
                        let resUIImage = UIImage(data: result!)
                        let photo = Photo(image: resUIImage!, caption: author)
                        photos.append(photo)
                        if currentMedia == mediaNum {
                            success(retPhotos: photos)
                        }
                        
                    })

                    
                }
                
                // do something with the data fetched
            } else {
                // handle error
                failure(error)
            }
        }
    }
    
    class func getPhotosNumber(user: PFUser?, success: (count: Int32?)->(), failure: (error: NSError?)->()) {
        if let user = user {
            let query = PFQuery(className: "Post")
            query.whereKey("author", equalTo: user)
            query.countObjectsInBackgroundWithBlock { (count: Int32, error: NSError?) -> Void in
                if error == nil {
                    success(count: count)
                } else {
                    failure(error: error)
                }
            }
        
        }

    }
}
