//
//  User.swift
//  Jinstagram
//
//  Created by YiHuang on 3/5/16.
//  Copyright © 2016 c2fun. All rights reserved.
//

import UIKit
import Parse

class User: NSObject {
    var pfObject: PFUser?
    var objectId: String?
    var userName: String?
    var likeNumber: Int?
    var avatarImage: UIImage?
    var descriptionText: String?
    
    
    init(pfUser: PFUser) {
        userName = pfUser.username
        print(userName)
        likeNumber = pfUser["likeNumber"] as? Int
        descriptionText = pfUser["description"] as? String
        pfObject = pfUser
        objectId = pfUser.objectId
    }
    
    func updateProfilePhoto(image: UIImage?, withCompletion completion: PFBooleanResultBlock?) {
        // Create Parse object PFObject
        if let image = image {
            if let user = pfObject {
                // Add relevant fields to the object
                user["avatar"] = Post.getPFFileFromImage(image) // PFFile column type
                user.saveInBackgroundWithBlock(completion)
                // Save object (following function will save the object in Parse asynchronously)
            }
        }

    }
    
    func updateDescription(description: String?, withCompletion completion: PFBooleanResultBlock?) {
        if let description = description {
            if let user = pfObject {
                user["description"] = description
                user.saveInBackgroundWithBlock(completion)
            }
        }
    
    }
    
    func lazyfetchAvatar(signatureImage: YHLazyImageView, success: (retImage: UIImage) ->(), failure: (NSError?) ->()) {
        if let pfObject = self.pfObject {
            if let _ = self.objectId {
/* ignore cached for small size avator
                if let cachedImage = Photo.sharedCache.objectForKey(objectId) {
                    print("cached Avator")
                    success(retImage: cachedImage as! UIImage)
                    return
                }
*/
            }
            
            if let imageFile = pfObject.objectForKey("avatar") as? PFFile {
                imageFile.getDataInBackgroundWithBlock({ (result: NSData?, error: NSError?) -> Void in
                    if signatureImage.parseObjectId != self.objectId {
                        failure(NSError(domain: "ParseLazyAvatarLoading", code: 1000, userInfo: nil))
                        return
                    }
                    if let result = result {
                        if let resUIImage = UIImage(data: result) {
                            /* ignore cached for small size avator
                            
                            if let objectId = self.objectId {
                            Photo.sharedCache.setObject(resUIImage, forKey: objectId, cost: result.length)
                            }
                            */
                            self.avatarImage = resUIImage
                            success(retImage: resUIImage)
                        } else {
                            failure(error)
                        }
                        
                    } else {
                        failure(error)
                        
                    }
                    
                })
            }

            
        } else {
            failure(nil)
        }
        
    }


}
