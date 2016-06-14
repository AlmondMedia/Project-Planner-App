//
//  ActionListViewController.swift
//  Project-X
//
//  Created by majeed on 26/03/2016.
//  Copyright © 2016 Almond Media Ltd. All rights reserved.
//

import UIKit

class ActionListViewController: UIViewController , UITableViewDataSource, UITableViewDelegate {

    
    @IBOutlet weak var activitiesTableView: UITableView!
    
    let filter : FilterBar = FilterBar()
    override func viewDidLoad() {
        super.viewDidLoad()

        filter.titles = ["Pending", "Due", "Completed"]
        filter.translucent = false
        self.view.addSubview(filter)
        let topConstraint : NSLayoutConstraint = NSLayoutConstraint(item: filter, attribute: .Top, relatedBy: .Equal, toItem: self.topLayoutGuide, attribute: .Bottom, multiplier: 1.0, constant: 0.0)
        self.view.addConstraint(topConstraint)
        filter.addTarget(self, action: #selector(ActionListViewController.segmentChanged(_:)), forControlEvents: .ValueChanged)
        filter.selectedSegmentIndex = 1;
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        boardActivities = App.getProjectActivityBoard(App.Memory.selectedProject!)
        self.segmentChanged(filter);
    }
    
    var boardActivities = App.getProjectActivityBoard(Project())
    var selectedActivityGroup : [BoardActivity] = []

    @IBAction func accountBtnTapped(sender: AnyObject) {
        App.Data.SyncTimestamp = NSDate()
        App.SaveLocalData()
        self.navigationController!.tabBarController!.presentingViewController!.dismissViewControllerAnimated(true, completion: nil);
    }

    @IBAction func segmentChanged(sender: AnyObject) {
        
        let filter : FilterBar = sender as! FilterBar
        
        if(filter.selectedSegmentIndex == 0){
            selectedActivityGroup = boardActivities.UpcomingActivities
        }
        else if (filter.selectedSegmentIndex == 2){
            selectedActivityGroup = boardActivities.CompletedActivities
        }
        else{
            selectedActivityGroup = boardActivities.DueActivities
        }
        
        activitiesTableView.reloadData();
        
    }
    
    
    
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedActivityGroup.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = activitiesTableView.dequeueReusableCellWithIdentifier("boardActivityCell", forIndexPath: indexPath) as! ActivityBoardTableViewCell
        
        
        let activity = selectedActivityGroup[indexPath.row];
        
        cell.activity = activity;
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //App.Memory.selectedActivity = selectedActivityGroup[indexPath.row];
        tableView.selectRowAtIndexPath(nil, animated: true, scrollPosition: UITableViewScrollPosition.Top)
    }

}
