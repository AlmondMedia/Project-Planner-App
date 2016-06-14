//
//  AccountViewController.swift
//  Planner
//
//  Created by majeed on 11/06/2016.
//  Copyright © 2016 Almond Media Ltd. All rights reserved.
//

import UIKit

class AccountViewController: UIViewController, UIImagePickerControllerDelegate,
UINavigationControllerDelegate {

    let picker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
        self.navigationItem.hidesBackButton = true;
        
        self.profileImage.contentMode = .ScaleAspectFill
        
        App.downloadProfileImage()
        
        App.ProfileImageDownloadedEvent.addHandler{
            
            self.profileImage.image = X.getImage(ImageGroup.Profile, name: App.Data.User.ResourceUID)
            if(self.profileImage.image == nil){
                self.profileImage.setImageWithString(App.Data.User.Name)
            }
        }
        
        let user = App.Data.User
        if(user.AccessToken == ""){
            self.navigationController?.popViewControllerAnimated(true)
        }
        else{
            self.profileImage.image = X.getImage(ImageGroup.Profile, name: App.Data.User.ResourceUID)
            if(profileImage.image == nil){
                profileImage.setImageWithString(user.Name)
            }
            
            userNameLabel.text = user.Name;
            userEmailLabel.text = user.Email;
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillDisappear(animated: Bool) {
      super.viewWillDisappear(animated)
        
        if (self.isMovingFromParentViewController() || self.isBeingDismissed()) {
            // Login out
            App.SignOut()
        }
        
    }

    @IBOutlet weak var profileImage: CircleImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userEmailLabel: UILabel!
    
    @IBAction func signOut(sender: AnyObject) {
        App.SignOut();
        self.navigationController?.popViewControllerAnimated(true)
    }
   
    @IBAction func pickProfileImage(sender: AnyObject) {
        picker.allowsEditing = true //2
        picker.sourceType = .SavedPhotosAlbum //3
        presentViewController(picker, animated: true, completion: nil)
    }

    @IBAction func closeProfileMenu(sender: AnyObject) {
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
       
        let chosenImage = info[UIImagePickerControllerEditedImage] as! UIImage //2
        profileImage.contentMode = .ScaleAspectFill //3
        profileImage.image = chosenImage //4
        X.setImage(ImageGroup.Profile, name: App.Data.User.ResourceUID, image: chosenImage)
        App.postProfileImage(chosenImage)
        dismissViewControllerAnimated(true, completion: nil) //5
        
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
