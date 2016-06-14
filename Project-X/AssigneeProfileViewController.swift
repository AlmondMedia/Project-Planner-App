//
//  AssigneeProfileViewController.swift
//  Planner
//
//  Created by majeed on 30/05/2016.
//  Copyright © 2016 Almond Media Ltd. All rights reserved.
//

import UIKit
import MessageUI

class AssigneeProfileViewController: UIViewController , UITableViewDataSource, UITableViewDelegate, MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate {
    
    @IBOutlet weak var tasksTableView: UITableView!
    @IBOutlet weak var textContactButtonsView: UIView!
    @IBOutlet weak var callContactsButtonView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        assignee = App.Memory.selectedAssignee!
        
        
        App.ContactsReloadedEvent.addHandler {
            self.refreshView()
        }
        profileImageView.contentMode = .ScaleAspectFill
        
        App.ContactsImageDownloadedEvent.addHandler { (resourceUID) in
            if(self.assignee.ResourceUID == resourceUID)
            {
                self.profileImageView.image = X.getImage(ImageGroup.Assignees, name: self.assignee.ResourceUID)
            }
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        refreshView()
    }
    
    func refreshView()
    {
        if(App.Memory.selectedAssignee != nil){
            assignee = App.Memory.selectedAssignee!
            tasks = App.Memory.selectedProject?.Tasks.filter({ (item) -> Bool in
                return item.AssigneeLink == assignee.Email
                //return item.AssigneeLink == assignee.Email
            })
            nameLabel.text = assignee.Name
            roleLabel.text = assignee.Profession
            profileImageView.image = X.getImage(ImageGroup.Assignees, name: assignee.ResourceUID)
            if(profileImageView.image == nil){
                profileImageView.setImageWithString(assignee.Name)
            }
            
            var pendingActivities = 0
            var completedactivities = 0
            var dueActivities = 0
            for task in tasks {
                let board = App.getTaskActivityBoard(task)
                pendingActivities = pendingActivities + board.UpcomingActivities.count
                completedactivities = completedactivities +  board.CompletedActivities.count;
                dueActivities = dueActivities + board.DueActivities.count;
            }
            pendingActivitiesLabel.text = "\(pendingActivities)"
            completedActivitiesLabel.text = "\(completedactivities)"
            dueActivitiesLabel.text = "\(dueActivities)"
            
            if(assignee.Phone.containsString("#") || assignee.Phone == "")
            {
                textContactButtonsView.hidden = true
                callContactsButtonView.hidden = true
            }
            else{
                textContactButtonsView.hidden = false
                callContactsButtonView.hidden = false
            }
            
            tasksTableView.reloadData();
        }
        
        
    }
    
    var assignee : Assignee!
    var tasks : [Task]!
    
    @IBOutlet weak var profileImageView: CircleImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var roleLabel: UILabel!
    @IBOutlet weak var pendingActivitiesLabel: UILabel!
    @IBOutlet weak var completedActivitiesLabel: UILabel!
    @IBOutlet weak var dueActivitiesLabel: UILabel!
    
    
    
    @IBAction func callAssignee(sender: AnyObject) {
        X.callNumber(assignee.Phone)
    }
    
    @IBAction func textAssignee(sender: AnyObject) {
        let messageVC = MFMessageComposeViewController()
        
        messageVC.body = "";
        messageVC.recipients = [assignee.Phone]
        messageVC.messageComposeDelegate = self;
        
        self.presentViewController(messageVC, animated: false, completion: nil)
    }
    
    @IBAction func emailAssignee(sender: AnyObject) {
        let picker = MFMailComposeViewController()
        picker.mailComposeDelegate = self
        picker.setSubject("RE : \(App.Data.User.Name)'s \(App.Memory.selectedProject!.Title)")
        let body = "Hello \(assignee.Name),"
        picker.setMessageBody(body, isHTML: true)
        picker.setToRecipients([assignee.Email])
        
        presentViewController(picker, animated: true, completion: nil)
    }
    
    func messageComposeViewController(controller: MFMessageComposeViewController, didFinishWithResult result: MessageComposeResult) {
        switch (result) {
        case MessageComposeResultCancelled:
            self.dismissViewControllerAnimated(true, completion: nil)
        case MessageComposeResultFailed:
            self.dismissViewControllerAnimated(true, completion: nil)
        case MessageComposeResultSent:
            self.dismissViewControllerAnimated(true, completion: nil)
        default:
            break;
        }
    }
    
    func mailComposeController(controller: MFMailComposeViewController, didFinishWithResult result: MFMailComposeResult, error: NSError?) {
        switch (result) {
        case MFMailComposeResultCancelled:
            self.dismissViewControllerAnimated(true, completion: nil)
        case MFMailComposeResultFailed:
            self.dismissViewControllerAnimated(true, completion: nil)
        case MFMailComposeResultSent:
            self.dismissViewControllerAnimated(true, completion: nil)
        default:
            self.dismissViewControllerAnimated(true, completion: nil)
            break;
        }
    }
    
    
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 64
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tasksTableView.dequeueReusableCellWithIdentifier("assignedTasksCell", forIndexPath: indexPath) as! AssignedTaskTableViewCell
        
        cell.task = tasks[indexPath.row];
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        App.Memory.selectedTask = tasks[indexPath.row];
        tableView.selectRowAtIndexPath(nil, animated: true, scrollPosition: UITableViewScrollPosition.Top)
    }
    
    
    @IBAction func menuTapped(sender: AnyObject) {
        
        let optionMenu = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
        
        // 2
        let deleteAction = UIAlertAction(title: "Remove Contact", style: .Destructive, handler: {
            (alert: UIAlertAction!) -> Void in
            
            
            let actions = [UIAlertAction(title: "No", style: .Default,handler: nil),
                UIAlertAction(title: "Remove", style: .Default, handler: { (action) -> Void in
                    App.projectHub.invoke("deleteContact", arguments: [App.Memory.selectedAssignee!.toJsonString()]){ (result, error) in
                    
                    }
                    for task in App.Memory.selectedProject!.Tasks {
                        if(task.AssigneeLink == App.Memory.selectedAssignee!.Email){
                            task.AssigneeLink = "";
                            task.AssigneeDidAccept = false
                        }
                    }
                    App.Memory.selectedProject?.Contacts.removeAtIndex((App.Memory.selectedProject?.Contacts.indexOf(App.Memory.selectedAssignee!))!)
                    App.Memory.selectedAssignee = nil;
                    self.navigationController?.popViewControllerAnimated(true)
                })]
            
            App.displayAlert(self, title: "Remove Contact", message: "Do you want to go ahead and remove this contact and un-assign from any tasks?", actions: actions);
            
            
        })
        //let editAction = UIAlertAction(title: "Edit Contact", style: .Default, handler: {
        //    (alert: UIAlertAction!) -> Void in
        //    self.performSegueWithIdentifier("editContactSegue", sender: self)
        //})
        
        //
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: {
            (alert: UIAlertAction!) -> Void in
            print("Cancelled")
        })
        
        
        // 4
        //optionMenu.addAction(editAction)
        optionMenu.addAction(deleteAction)
        optionMenu.addAction(cancelAction)
        
        // 5
        self.presentViewController(optionMenu, animated: true, completion: nil)
    }

}
