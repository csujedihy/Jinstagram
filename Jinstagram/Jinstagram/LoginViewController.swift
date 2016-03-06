//
//  LoginViewController.swift
//  Jinstagram
//
//  Created by Yi Huang on 16/2/29.
//  Copyright © 2016年 c2fun. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController, HomeViewControllerDelegate {

    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    func login() {
        PFUser.logInWithUsernameInBackground(usernameField.text!, password: passwordField.text!) { (user: PFUser?, error: NSError?) -> Void in
            if user != nil {
                print("Login successfully")
                //                self.performSegueWithIdentifier("loginSegue", sender: nil)
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let homeNC = storyboard.instantiateViewControllerWithIdentifier("HomeNavController") as! UINavigationController
                let homeVC = homeNC.topViewController as! HomeViewController
                homeVC.delegate = self
                homeVC.fromLoginView = true
                homeNC.tabBarItem.title = "Home"
                homeNC.tabBarItem.image = UIImage(named: "home")
                
                
                let profileNC = storyboard.instantiateViewControllerWithIdentifier("ProfileNavController")
                profileNC.tabBarItem.title = "Me"
                profileNC.tabBarItem.image = UIImage(named: "profile")
                
                
                let tabBarController = UITabBarController()
                tabBarController.viewControllers = [homeNC, profileNC]
                self.presentViewController(tabBarController, animated: true, completion: nil)
                
            } else {
                let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .Alert)
                let cancelAction = UIAlertAction(title: "Try again", style: .Cancel) {
                    (action) in
                    self.passwordField.text = ""
                    
                }

                alertController.addAction(cancelAction)
                self.presentViewController(alertController, animated: true, completion: nil)
                
            }
        }
    }
    
    @IBAction func signInOnTap(sender: AnyObject) {
        login()
    }
    
    func homeView(didLogout homeView: HomeViewController) {
        print("loginView logout")
        usernameField.text = ""
        passwordField.text = ""
    }
    
    
    @IBOutlet weak var signUpOnTap: UIButton!
    
    @IBAction func signUpOnTap(sender: AnyObject) {
        let newUser = PFUser()
        newUser.username = usernameField.text
        newUser.password = passwordField.text
        newUser.signUpInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            if success {
                print("Yay, created a user!")
                self.login()
                
            } else {
                let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .Alert)
                let cancelAction = UIAlertAction(title: "Ok", style: .Cancel) {
                    (action) in
                    self.passwordField.text = ""
                    
                }
                
                alertController.addAction(cancelAction)
                self.presentViewController(alertController, animated: true, completion: nil)
                print(error?.localizedDescription)
            }
        }
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        signInButton.layer.cornerRadius = 4.0
        signInButton.layer.borderWidth = 1.0
        signInButton.layer.borderColor = UIColor(white: 0.8, alpha: 0.79).CGColor
        
        signUpButton.layer.cornerRadius = 4.0
        signUpButton.layer.borderWidth = 1.0
        signUpButton.layer.borderColor = UIColor(white: 0.8, alpha: 0.79).CGColor
        

        
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
