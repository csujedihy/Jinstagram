//
//  AppDelegate.swift
//  Jinstagram
//
//  Created by Yi Huang on 16/2/29.
//  Copyright © 2016年 c2fun. All rights reserved.
//

import UIKit
import Parse

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UINavigationControllerDelegate, HomeViewControllerDelegate {

    var window: UIWindow?
    var storyboard = UIStoryboard(name: "Main", bundle: nil)
    
    func homeView(didLogout homeView: HomeViewController) {
        let vc = storyboard.instantiateViewControllerWithIdentifier("LoginViewID") as! LoginViewController
        window?.rootViewController = vc
    }

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        let barStyle = UIBarButtonItem.appearance()
        barStyle.setBackButtonTitlePositionAdjustment(UIOffsetMake(-100, -60), forBarMetrics:UIBarMetrics.Default)
        
        UINavigationBar.appearance().barTintColor = UIColor(red: 29.0/255, green: 64.0/255, blue: 104.0/255, alpha: 1.0)
        UINavigationBar.appearance().tintColor = UIColor.whiteColor()
        UINavigationBar.appearance().alpha = 0.8
        UINavigationBar.appearance().translucent = true
        let titleDict: NSDictionary = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        UINavigationBar.appearance().titleTextAttributes = titleDict as! [String : AnyObject]
        
        UITabBar.appearance().barTintColor = UIColor(red: 29.0/255, green: 64.0/255, blue: 104.0/255, alpha: 1.0)
        UITabBar.appearance().tintColor = UIColor.whiteColor()
        
        
        
        // Only exec once
        Parse.initializeWithConfiguration(
            ParseClientConfiguration(block: { (configuration:ParseMutableClientConfiguration) -> Void in
                configuration.applicationId = "Jinstagram"
                configuration.clientKey = "asdkjfhaskdfhkahsdkfhiqw12312"
                configuration.server = "https://lit-depths-58220.herokuapp.com/parse"

            })
        )
        
        if PFUser.currentUser() != nil {
            window = UIWindow(frame: UIScreen.mainScreen().bounds)
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let homeNC = storyboard.instantiateViewControllerWithIdentifier("HomeNavController") as! UINavigationController
            let homeVC = homeNC.topViewController as! HomeViewController
            homeVC.delegate = self
            homeNC.tabBarItem.title = "Home"
            homeNC.tabBarItem.image = UIImage(named: "home")

            
            let profileNC = storyboard.instantiateViewControllerWithIdentifier("ProfileNavController")
            profileNC.tabBarItem.title = "Me"
            profileNC.tabBarItem.image = UIImage(named: "profile")

            
            let tabBarController = UITabBarController()
            tabBarController.viewControllers = [homeNC, profileNC]
            window?.rootViewController = tabBarController
            window?.makeKeyAndVisible()
  
        }
        
        return true
    }

    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

