//
//  SignupViewController.swift
//  Planner
//
//  Created by majeed on 13/06/2016.
//  Copyright © 2016 Almond Media Ltd. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.nameTextBox.delegate = self;
        self.emailTextBox.delegate = self;
        self.phoneTextBox.delegate = self;
        self.passwordTextBox.delegate = self;
        
        self.navigationItem.titleView = UIImageView(image: UIImage(named: "Planner-app-logo-sm"))
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        
        App.UserSignupEvent.addHandler {self.navigationController?.popViewControllerAnimated(false);}
        
        App.UserSignupFailedEvent.addHandler { msg in
            self.activityIndicator.stopAnimating()
            App.displayAlert(self, title: "Sorry", message: msg)
        }
    }
    
    
    override func viewWillAppear(animated: Bool) {
        
        activityIndicator.stopAnimating()
        emailTextBox.text = App.Data.User.Email
        if(App.Data.User.AccessToken != "")
        {
            self.performSegueWithIdentifier("segueToAccount", sender: self);
        }
        else{
            super.viewWillAppear(animated)
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        activityIndicator.stopAnimating();
        self.dismissKeyboard();
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBAction func cancelTapped(sender: AnyObject) {
        self.dismissKeyboard();
    }
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    @IBOutlet weak var nameTextBox: UITextField!
    @IBOutlet weak var emailTextBox: UITextField!
    @IBOutlet weak var phoneTextBox: UITextField!
    @IBOutlet weak var passwordTextBox: UITextField!
    
    
    
    @IBAction func registerPressed(sender: AnyObject)
    {
        
        if(X.isValidEmail(emailTextBox.text!))
        {
            let password : NSString = "" + passwordTextBox.text!
            if(password.length >= 6)
            {
                activityIndicator.startAnimating();
                
                App.Data.User.Email = emailTextBox.text!
                let user = UserAccount();
                user.Email = emailTextBox.text!
                user.Password = passwordTextBox.text!
                user.Name = nameTextBox.text!
                user.Phone = phoneTextBox.text!
                
                App.registerAccount(user)
            }
            else
            {
                App.displayAlert(self, title: "", message: "Password must be at least 6 characters");
            }
        }
        else
        {
            App.displayAlert(self, title: "", message: "Please enter a valid Email");
        }
        
        
        
        
    }
    
    
    
    
    
    
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */}
