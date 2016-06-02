//
//  AssigneeProfileViewController.swift
//  Planner
//
//  Created by majeed on 30/05/2016.
//  Copyright © 2016 Almond Media Ltd. All rights reserved.
//

import UIKit

class AssigneeProfileViewController: UIViewController , UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tasksTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        assignee = App.Memory.selectedAssignee!
        let image = UIImage(named: "ui-image-assignee-\(assignee.Id)")
        if(image != nil){
            X.setImage(ImageGroup.Assignees, name: assignee.Email, image: image!)
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        assignee = App.Memory.selectedAssignee!
        tasks = App.Memory.selectedProject?.Tasks.filter({ (item) -> Bool in
            return item.Assignee_Id == assignee.Id
            //return item.AssigneeLink == assignee.Email
        })
        nameLabel.text = assignee.Name
        roleLabel.text = assignee.Profession
        profileImageView.image = UIImage(named: "ui-image-assignee-\(assignee.Id)") ?? UIImage(named: "ui-image-default-assignee-profile")

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
        
        tasksTableView.reloadData();
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
        
    }
    
    @IBAction func textAssignee(sender: AnyObject) {
        
    }
    
    @IBAction func emailAssignee(sender: AnyObject) {
        
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

}
