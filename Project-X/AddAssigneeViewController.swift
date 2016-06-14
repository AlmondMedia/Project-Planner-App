//
//  AddAssigneeViewController.swift
//  Planner
//
//  Created by majeed on 29/05/2016.
//  Copyright © 2016 Almond Media Ltd. All rights reserved.
//

import UIKit
import Contacts
import ContactsUI
import AddressBookUI

class AddAssigneeViewController: UIViewController, UITextFieldDelegate, CNContactPickerDelegate, UINavigationControllerDelegate {
    
    var peopleSelector : CNContactPickerViewController!
    
    @IBOutlet weak var phoneInputStack: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        peopleSelector = CNContactPickerViewController();
        peopleSelector.delegate = self;
        peopleSelector.displayedPropertyKeys = [ CNContactEmailAddressesKey]
        
        if(editAssignee == nil){
            phoneInputStack.removeFromSuperview()
            
        }else{
            nameTextBox.text = editAssignee?.Name;
            emailTextBox.text = editAssignee?.Email;
            phoneTextBox?.text = editAssignee?.Phone;
        }
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.dismissKeyboard();
        self.nameTextBox.becomeFirstResponder()
    }
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    var editAssignee = App.Memory.selectedAssignee
    
    @IBOutlet weak var nameTextBox: UITextField!;
    @IBOutlet weak var emailTextBox: UITextField!;
    @IBOutlet weak var phoneTextBox: UITextField?;
    
    @IBAction func pickPhoneContact(sender: AnyObject) {
        self.presentViewController(peopleSelector, animated: true, completion: nil)
    }
    
    @IBAction func pickFacebookContact(sender: AnyObject) {
        
        
        
    }
    
    func contactPicker(picker: CNContactPickerViewController, didSelectContactProperty contactProperty: CNContactProperty) {
        let contact = contactProperty.contact
        self.nameTextBox.text = CNContactFormatter().stringFromContact(contact)
        let phoneNumber = (contactProperty.value as? CNPhoneNumber)?.stringValue
        self.phoneTextBox?.text  = phoneNumber;
        self.emailTextBox.text = contactProperty.value! as? String
    }
    
    
    @IBAction func save(sender: AnyObject) {
        if(editAssignee == nil){
            let newAssignee =  Assignee();
            newAssignee.Name = nameTextBox.text!;
            newAssignee.Email = emailTextBox.text!;
            newAssignee.Phone = phoneTextBox?.text ?? "";
            newAssignee.ProjectId = App.Memory.selectedProject!.Id;
            
            App.Memory.selectedProject!.Contacts.append(newAssignee);
            
            App.pushContact(App.Memory.selectedProject!, newContact : newAssignee);
            
        } else {
            editAssignee?.Name = nameTextBox.text!;
            editAssignee?.Email = emailTextBox.text!;
            //editAssignee?.Phone = phoneTextBox.text!;
        }
        
        self.navigationController?.popViewControllerAnimated(true)
        
    }


}
