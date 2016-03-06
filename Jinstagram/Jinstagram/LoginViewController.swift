//
//  LoginViewController.swift
//  Jinstagram
//
//  Created by Yi Huang on 16/2/29.
//  Copyright © 2016年 c2fun. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBAction func signInOnTap(sender: AnyObject) {
        PFUser.logInWithUsernameInBackground(usernameField.text!, password: passwordField.text!) { (user: PFUser?, error: NSError?) -> Void in
            if user != nil {
                print("Login successfully")
//                self.performSegueWithIdentifier("loginSegue", sender: nil)
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let homeNC = storyboard.instantiateViewControllerWithIdentifier("HomeNavController") as! UINavigationController
                let homeVC = homeNC.topViewController
                homeNC.tabBarItem.title = "Home"
                
                
                let uploadNC = storyboard.instantiateViewControllerWithIdentifier("HomeNavController") as! UINavigationController
                let uploadVC = uploadNC.topViewController
                uploadNC.tabBarItem.title = "Upload"
                
                let profileNC = storyboard.instantiateViewControllerWithIdentifier("ProfileNavController")
                profileNC.tabBarItem.title = "Me"
                
                let tabBarController = UITabBarController()
                tabBarController.viewControllers = [homeNC, profileNC]
                self.presentViewController(tabBarController, animated: true, completion: nil)

            }
        }
    }
    
    
    @IBOutlet weak var signUpOnTap: UIButton!
    
    @IBAction func signUpOnTap(sender: AnyObject) {
        let newUser = PFUser()
        newUser.username = usernameField.text
        newUser.password = passwordField.text
        newUser.signUpInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            if success {
                print("Yay, created a user!")
            } else {
                print(error?.localizedDescription)
            }
        }
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

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
