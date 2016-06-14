//
//  AssigneeListViewController.swift
//  Project-X
//
//  Created by majeed on 26/03/2016.
//  Copyright © 2016 Almond Media Ltd. All rights reserved.
//

import UIKit


class AssigneeListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        App.ContactsReloadedEvent.addHandler { self.tableView.reloadData()}
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        App.Memory.selectedAssignee = nil;
        self.tableView.reloadData()
    }

    @IBAction func accountBtnTapped(sender: AnyObject) {
        App.Data.SyncTimestamp = NSDate()
        App.SaveLocalData()
        self.navigationController!.tabBarController!.presentingViewController!.dismissViewControllerAnimated(true, completion: nil);
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 74.0;
    }


    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return App.Memory.selectedProject!.Contacts.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("assigneeCell", forIndexPath: indexPath) as! AssigneeTableViewCell
        
        
        let item = App.Memory.selectedProject!.Contacts[indexPath.row];
        
        cell.assignee = item;
        
        return cell
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        App.Memory.selectedAssignee = App.Memory.selectedProject!.Contacts[indexPath.row];
    }
    
    func tableView(tableView: UITableView, accessoryButtonTappedForRowWithIndexPath indexPath: NSIndexPath) {
        App.Memory.selectedAssignee = App.Memory.selectedProject!.Contacts[indexPath.row];
        self.performSegueWithIdentifier("editAssigneeSegue", sender: self);
    }

}
