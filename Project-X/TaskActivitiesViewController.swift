//
//  TaskActivitiesViewController.swift
//  Project-X
//
//  Created by majeed on 24/03/2016.
//  Copyright © 2016 Almond Media Ltd. All rights reserved.
//

import UIKit

class TaskActivitiesViewController: UIViewController , UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var taskTitleLabel: UILabel!
    @IBOutlet weak var assigneeImageView: CircleImageView!
    @IBOutlet weak var assigneeNameLabel: UILabel!
    @IBOutlet weak var taskBudgetLabel: UILabel!
    //@IBOutlet weak var taskCostsLabel: UILabel!
    @IBOutlet weak var taskDaysLeft: UILabel!
    //@IBOutlet weak var taskActivitiesLeft: UILabel!
    
    @IBOutlet weak var activitiesTableView: UITableView!
    @IBOutlet weak var activitiesView: UIView!
    
//    @IBOutlet weak var paymentsTableView: UITableView!
//    @IBOutlet weak var paymentsView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        App.CurrentTaskChangedEvent.addHandler {self.reloadData()}
        App.ActivitiesReloadedEvent.addHandler {self.reloadData()}
        App.CurrentActivityChangedEvent.addHandler {self.reloadData()}
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        App.Memory.selectedActivity = nil;
        task = App.Memory.selectedTask!;
        reloadData();
    }
    
    var task : Task = Task()
    
    func reloadData() {
        task = App.Memory.selectedTask!;
        self.navigationItem.title = "TASK";
        taskTitleLabel.text = task.Title.uppercaseString
        let assignee = App.getTaskAssignee(task);
        self.assigneeNameLabel.text = assignee?.Name
        if(assignee != nil){
            let image = X.getImage(ImageGroup.Assignees, name: assignee!.ResourceUID)
            self.assigneeImageView.image = image;
            
        }
        
        if(assigneeImageView.image == nil){
            assigneeImageView.setImageWithString(assignee?.Name ?? "")
        }
        
        self.taskBudgetLabel.text = X.formatNumber(task.Budget)
        self.taskDaysLeft.text = X.getDaysBetweenDate(NSDate().endOfYesterday, endDate:  task.DueDate).description
        //self.taskActivitiesLeft.text = task.Activities.filter({ (item) -> Bool in
            //return !item.IsCompleted
        //}).count.description;
        //self.taskCostsLabel.text = X.formatNumber(App.getTaskCosts(task).TotalCost)
        activitiesTableView.reloadData()
    }
    
    @IBAction func taskMenuTapped(sender: AnyObject) {
        
        let optionMenu = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
        
        // 2
        let deleteAction = UIAlertAction(title: "Delete Task", style: .Destructive, handler: {
            (alert: UIAlertAction!) -> Void in
            
            
            let actions = [UIAlertAction(title: "No", style: .Default,handler: nil),
                UIAlertAction(title: "Delete", style: .Default, handler: { (action) -> Void in
                    App.projectHub?.invoke("deleteTask", arguments: [App.Memory.selectedTask!.Id]){ (result, error) in
                        
                    }
                App.Memory.selectedProject?.Tasks.removeAtIndex((App.Memory.selectedProject?.Tasks.indexOf(App.Memory.selectedTask!))!)
                    App.Memory.selectedTask = nil;
                    self.navigationController?.popViewControllerAnimated(true)
                })]
            
            App.displayAlert(self, title: "Delete Task", message: "Do you want to go ahead and remove this task from your project?", actions: actions);
            
            
        })
        let editAction = UIAlertAction(title: "Edit Task", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.performSegueWithIdentifier("editTaskSegue", sender: self)
        })
        
        let assignAction = UIAlertAction(title: "Assign Task", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            self.performSegueWithIdentifier("assignTaskSegue", sender: self)
        })
        
        //
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: {
            (alert: UIAlertAction!) -> Void in
            print("Cancelled")
        })
        
        
        // 4
        optionMenu.addAction(assignAction)
        optionMenu.addAction(editAction)
        optionMenu.addAction(deleteAction)
        optionMenu.addAction(cancelAction)
        
        // 5
        self.presentViewController(optionMenu, animated: true, completion: nil)
    }
    @IBAction func phoneAssigneeTapped(sender: AnyObject) {
    }
    @IBAction func messageAssigneeTapped(sender: AnyObject) {
    }
    
    
    
    @IBAction func addActivityTapped(sender: AnyObject) {
        
    }
    
    
    
    
    
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return task.Activities.count + 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        //if(tableView == activitiesTableView){
            if(indexPath.row >= task.Activities.count){
                
                let cell = activitiesTableView.dequeueReusableCellWithIdentifier("addItemCell", forIndexPath: indexPath) as! ActivitiesFooterTableViewCell
                cell.totalCost = App.getTaskCosts(task).TotalCost
                return cell
            }
            else{
                let cell = activitiesTableView.dequeueReusableCellWithIdentifier("activityCell", forIndexPath: indexPath) as! ActivityTableViewCell
                let activity = task.Activities[indexPath.row];
                
                cell.activity = activity;
                
                return cell
            }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if(indexPath.row < task.Activities.count){
            App.Memory.selectedActivity = task.Activities[indexPath.row];
            self.performSegueWithIdentifier("editActivitySegue", sender: self)
        }
        //tableView.selectRowAtIndexPath(nil, animated: true, scrollPosition: UITableViewScrollPosition.Top)
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        let result = indexPath.row < task.Activities.count
        
        return result;
    }
    
    func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
        if(indexPath.row < task.Activities.count){
            App.Memory.selectedActivity = task.Activities[indexPath.row];
            self.performSegueWithIdentifier("editActivitySegue", sender: self);
        }
    }
    
    func tableView(tableView: UITableView, canFocusRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false;
    }
    
    
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        if(indexPath.row < task.Activities.count){
            return [UITableViewRowAction(style: .Default, title: "Delete", handler: { (action, indexPath) in
                
                App.deleteActivity(self.task.Activities[indexPath.row])
                self.task.Activities.removeAtIndex(indexPath.row)
                App.Memory.selectedActivity = nil
                App.CurrentTaskChangedEvent.raise();
            })];
        }
        else{
            return nil
        }
        
    }

}
