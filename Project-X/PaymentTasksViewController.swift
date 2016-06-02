//
//  PaymentTasksViewController.swift
//  Planner
//
//  Created by majeed on 25/05/2016.
//  Copyright © 2016 Almond Media Ltd. All rights reserved.
//

import UIKit

class PaymentTasksViewController: UIViewController , UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tasksTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        project = App.Memory.selectedProject!;
        reloadData();
    }
    
    var project : Project = Project()
    
    func reloadData() {
        tasksTableView.reloadData()
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 64
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return project.Tasks.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tasksTableView.dequeueReusableCellWithIdentifier("paymentTasksCell", forIndexPath: indexPath) as! PaymentTasksTableViewCell
        
        cell.task = project.Tasks[indexPath.row];
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        App.Memory.selectedPaymentTask = project.Tasks[indexPath.row];
        tableView.selectRowAtIndexPath(nil, animated: true, scrollPosition: UITableViewScrollPosition.Top)
    }
    

}
