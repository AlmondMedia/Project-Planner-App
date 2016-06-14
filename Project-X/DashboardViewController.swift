//
//  DashboardViewController.swift
//  Project-X
//
//  Created by majeed on 25/03/2016.
//  Copyright © 2016 Almond Media Ltd. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController {

    @IBOutlet weak var projecTitleLabel: UILabel!
    @IBOutlet weak var projectDescriptionLabel: UILabel!
    @IBOutlet weak var projectBudgetLabel: UILabel!
    @IBOutlet weak var projectTaskCountLabel: UILabel!
    @IBOutlet weak var projectDeadlineLabel: UILabel!
    @IBOutlet weak var projectAmountSpent: UILabel!
    @IBOutlet weak var projectBudgetSpentIndicator: KDCircularProgress!
    @IBOutlet weak var projectActivitiesCompletedLabel: UILabel!
    @IBOutlet weak var projectActivityProgressIndicator: KDCircularProgress!
    
    
    @IBOutlet weak var projectDueCostLabel: UILabel!
    @IBOutlet weak var projectTotalPaymentsLabel: UILabel!
    @IBOutlet weak var projectUnpaidTotalLabel: UILabel!
    @IBOutlet weak var projectUnpaidTitleLabel: UILabel!
    
    var project : Project = Project();
    
    override func viewDidLoad() {
        super.viewDidLoad()

        App.CurrentProjectChangedEvent.addHandler {self.refereshView()}
        App.downloadContactsImage(App.Memory.selectedProject!.Contacts)
    }
    func refereshView()
    {
        dispatch_async(dispatch_get_main_queue()) {
            self.setViewData();
        }
    }

    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        
        //setDefaultUI()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        setViewData();
        
        
    }
    
    @IBAction func accountBtnTapped(sender: AnyObject) {
        App.Data.SyncTimestamp = NSDate()
        App.SaveLocalData()
        self.navigationController?.tabBarController?.presentingViewController?.dismissViewControllerAnimated(true, completion: nil);
        
    }
    
    @IBAction func menuTapped(sender: UIButton) {
        showActionSheet(sender);
    }
    
    func showActionSheet(sender: UIButton ) {
        // 1
        let optionMenu = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
        
        // 2
        let deleteAction = UIAlertAction(title: "Delete", style: .Destructive, handler: {
            (alert: UIAlertAction!) -> Void in
            
            let actions = [UIAlertAction(title: "No", style: .Default,handler: nil),
                UIAlertAction(title: "Delete", style: .Default, handler: { (action) -> Void in
                    App.projectHub?.invoke("deleteProject", arguments: [App.Memory.selectedProject!.Id], callback: nil)
                    App.Data.Projects.removeAtIndex((App.Data.Projects.indexOf(App.Memory.selectedProject!))!)
                    App.Memory.selectedProject = nil;
                    self.navigationController?.tabBarController?.presentingViewController?.dismissViewControllerAnimated(true, completion: nil);
                })]
            
            App.displayAlert(self, title: "Delete Project", message: "Do you want to go ahead and remove this project from your account?", actions: actions);
            
            
        })
        let editAction = UIAlertAction(title: "Edit Project", style: .Default, handler: {
            (alert: UIAlertAction!) -> Void in
            
            self.performSegueWithIdentifier("editProjectSegue", sender: self)
        })
        
        //
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: {
            (alert: UIAlertAction!) -> Void in
            App.applyLightUI()
        })
        
        
        // 4
        optionMenu.addAction(editAction)
        optionMenu.addAction(deleteAction)
        optionMenu.addAction(cancelAction)
        
        // 5
        self.presentViewController(optionMenu, animated: true, completion: nil)
    }

    
    
    func setViewData()
    {
        if let project = App.Memory.selectedProject
        {
            projecTitleLabel.text = project.Title;
            projectDescriptionLabel.text = project.Details["Description"] ?? "";
            projectBudgetLabel.text = X.formatNumber(project.Budget);
            projectTaskCountLabel.text = "\(App.getProjectTaskCount(project))";
            projectDeadlineLabel.text = "\(App.getDaysToDeadline(project.DueDate))";
            let totalCost = App.getProjectCosts(project).TotalCost;
            projectAmountSpent.text = X.formatNumber(totalCost);
            let budgetSpent =  totalCost.doubleValue / (project.Budget.doubleValue > 0 ? project.Budget.doubleValue : 1.0) ;
            if(budgetSpent > 1){
                projectBudgetSpentIndicator.progressColors[0] = UIColor(red: 139.0/255.0, green: 0.0, blue: 8.0/255.0, alpha: 1);
            }
            else{
                projectBudgetSpentIndicator.progressColors[0] = App.window.tintColor;
            }
            projectBudgetSpentIndicator.angle = Int.init(budgetSpent * 360);
            let completedActivities = App.getProjectCompletedActivitiesCount(project);
            projectActivitiesCompletedLabel.text = "\(completedActivities)";
            let totalActivities = App.getProjectActivitiesCount(project);
            let activityProgress = Double.init(completedActivities) / (totalActivities > 0 ? Double.init(totalActivities) : 1.0);
            
            projectDueCostLabel.text = X.formatNumber(App.getCostDueForProject(project))
            projectTotalPaymentsLabel.text = X.formatNumber(App.getPaymentsTotalForProject(project))
            var unpaid = App.getUnpaidTotalForProject(project);
            if(unpaid.doubleValue < 0)
            {
                projectUnpaidTitleLabel.text = "BALANCE";
                unpaid = NSDecimalNumber(double:0)
            }
            else{
                projectUnpaidTitleLabel.text = "UNPAID";
            }
            projectUnpaidTotalLabel.text = X.formatNumber(unpaid);
            
            projectActivityProgressIndicator.angle = Int.init(activityProgress * 360);
        
        }
        else{
            self.accountBtnTapped(self)
        }
    }
    
    
//    func setCustomUI()
//    {
//        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
//        self.navigationController!.navigationBar.barTintColor = App.window.tintColor;
//        self.navigationController!.navigationBar.shadowImage = UIImage()
//        self.navigationController!.navigationBar.translucent = false
//        self.navigationController!.navigationBar.tintColor = UIColor.whiteColor()
//        
//        let navbarFont = UIFont(name: "Helvetica-Light", size: 16) ?? UIFont.systemFontOfSize(16)
//        let barbuttonFont = UIFont(name: "Helvetica", size: 15) ?? UIFont.systemFontOfSize(15)
//        self.navigationController!.navigationBar.titleTextAttributes = [NSFontAttributeName: navbarFont, NSForegroundColorAttributeName:UIColor.whiteColor()]
//        self.navigationController!.navigationBar.titleTextAttributes = [NSFontAttributeName: barbuttonFont, NSForegroundColorAttributeName:UIColor.whiteColor()]
//    }
//    
//    func setDefaultUI()
//    {
//        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
//        self.navigationController!.navigationBar.barTintColor = UIColor.whiteColor()
//        self.navigationController!.navigationBar.shadowImage = UIImage()
//        self.navigationController!.navigationBar.translucent = true
//        self.navigationController!.navigationBar.tintColor = App.window.tintColor;
//        
//        let navbarFont = UIFont(name: "Helvetica-Light", size: 16) ?? UIFont.systemFontOfSize(16)
//        let barbuttonFont = UIFont(name: "Helvetica", size: 15) ?? UIFont.systemFontOfSize(15)
//        self.navigationController!.navigationBar.titleTextAttributes = [NSFontAttributeName: navbarFont, NSForegroundColorAttributeName:UIColor.darkTextColor()]
//        self.navigationController!.navigationBar.titleTextAttributes = [NSFontAttributeName: barbuttonFont, NSForegroundColorAttributeName:UIColor.darkTextColor()]
//    }

}
