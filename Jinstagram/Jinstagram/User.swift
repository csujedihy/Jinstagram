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
    
    
    init(pfUser: PFUser) {
        userName = pfUser.username
        print(userName)
        likeNumber = pfUser["likeNumber"] as? Int
        pfObject = pfUser
    }
    
//    class func queryUser(username: String?, success: ()->(), failure: (error: NSError?)->()) {
//        if let username = username {
//            let findUserQuery: PFQuery? = PFUser.query()
//            if let query = findUserQuery {
//                query.whereKey("username",  equalTo: username)
//                query.findObjectsInBackgroundWithBlock({ (pfArray: [PFObject]?, error: NSError?) -> Void in
//                    if pfArray?.count == 1 {
//                        success()
//                    } else {
//                        failure(error: error)
//                    
//                    }
//                })
//            }
//            
//        }
//        
//    }

}
