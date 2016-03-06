//
//  TimeFormatter.swift
//  Jinstagram
//
//  Created by YiHuang on 3/5/16.
//  Copyright © 2016 c2fun. All rights reserved.
//

import UIKit

extension NSDate {
    func between () -> String? {
        print(self.timeIntervalSinceNow)
        if self.timeIntervalSinceNow < 0 {
            let interval = Int(-1 * self.timeIntervalSinceNow)
            
            switch interval {
            case 0:
                return "Now"
            case 1...3599:
                // minutes case
                return "\(interval/3600)m"
            case 3600...86399:
                let hour = interval/3600
                return "\(hour)h"
            case 86400...2592000:
                return "\(interval/86400)d"
            case 2592000...31104000:
                return "\(interval/2592000)m"
            default:
                return "\(interval/31104000)y"
            }
            
            
        } else {
            return "Now"
        }
    }

}