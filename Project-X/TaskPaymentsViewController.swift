//
//  TaskPaymentsViewController.swift
//  Planner
//
//  Created by majeed on 25/05/2016.
//  Copyright © 2016 Almond Media Ltd. All rights reserved.
//

import UIKit

class TaskPaymentsViewController: UIViewController , UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var taskTitleLabel: UILabel!
    @IBOutlet weak var assigneeImageView: CircleImageView!
    @IBOutlet weak var assigneeNameLabel: UILabel!
    @IBOutlet weak var taskBalanceTitle: UILabel!
    @IBOutlet weak var taskBalanceLabel: UILabel!
    @IBOutlet weak var taskCostsLabel: UILabel!
    //@IBOutlet weak var taskDaysLeft: UILabel!
    //@IBOutlet weak var taskActivitiesLeft: UILabel!
    
    @IBOutlet weak var paymentsTableView: UITableView!
    @IBOutlet weak var paymentsView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        task = App.Memory.selectedPaymentTask!;
//        let payment = Payment();
//        payment.TaskId = task.Id;
//        payment.Amount = 530
//        payment.DateTime = NSDate().addDays(-5);
//        payment.ReceivedBy = "Vendor";
//        task.Payments = [payment];
        reloadData();
    }
    
    var task : Task = Task()
    
    func reloadData() {
        self.navigationItem.title = "TASK";
        taskTitleLabel.text = task.Title.uppercaseString
        let assignee = App.getTaskAssignee(task);
        self.assigneeNameLabel.text = assignee?.Name
        let image = UIImage(named: "ui-image-assignee-\(task.Assignee_Id)")
        self.assigneeImageView.image = image;
        self.taskCostsLabel.text = X.formatNumber(App.getTaskCosts(task).TotalCost)
        
        
        let totalAmount : Double = task.Payments.reduce(0.0) { $0 + $1.Amount.doubleValue};
        
        let balance = totalAmount - App.getTaskCosts(task).TotalCost.doubleValue;
        if(balance < 0)
        {
            taskBalanceTitle.text = "UNPAID"
            taskBalanceTitle.textColor = App.dangerColor
            taskBalanceLabel.text = X.numToCurrency(NSDecimalNumber(double :(balance * -1)));
        } else if(balance > 0){
            taskBalanceTitle.text = "EXCESS"
            taskBalanceTitle.textColor = App.successColor
            taskBalanceLabel.text = X.numToCurrency(NSDecimalNumber(double :balance));
        }
        else{
            taskBalanceTitle.text = "BALANCE"
            taskBalanceTitle.textColor = App.defaultColor
            taskBalanceLabel.text = X.numToCurrency(NSDecimalNumber(double :balance));
        }
        
        paymentsTableView.reloadData()
    }
    
        @IBAction func phoneAssigneeTapped(sender: AnyObject) {
    }
    @IBAction func messageAssigneeTapped(sender: AnyObject) {
    }
    
    
    
    
    
    
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 44
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 0){ return task.Payments.count }
        else { return 1}
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if(section == 0){ return nil }
        else { return nil}
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if(indexPath.section == 1){
            let cell = paymentsTableView.dequeueReusableCellWithIdentifier("addItemCell", forIndexPath: indexPath) as! PaymentsFooterTableViewCell
            cell.task = task;
            return cell
        }
        else{
            let cell = paymentsTableView.dequeueReusableCellWithIdentifier("paymentCell", forIndexPath: indexPath) as! PaymentTableViewCell
            let payment = task.Payments[indexPath.row];
            
            cell.payment = payment;
            
            return cell
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if(indexPath.section == 0){
            App.Memory.selectedPayment = task.Payments[indexPath.row];
        }
    }
}
