//
//  ModelLogic.swift
//  Project-X
//
//  Created by majeed on 23/05/2016.
//  Copyright © 2016 Almond Media Ltd. All rights reserved.
//

import Foundation

extension App {
    
    static func CreateProject(title: String, date : NSDate, budget: Double, template: ProjectTemplate?) -> Project
    {
        let project = Project()
        //project.Id = App.Data.NewId;
        project.Title = title
        project.Budget = NSDecimalNumber(double: budget)
        project.DueDate = date
        
        if(template != nil)
        {
            project.ProjectType = template!.Title;
            project.Details = template!.Details;
            for item in template!.TaskTemplates
            {
            
                let date = project.DueDate.addDays(item.EndDayOffset * -1)
                let budget = X.in100s((project.Budget.doubleValue * item.InitialPercentageBudget))
                project.Tasks.append(App.CreateTask(item.Title, date: date, budget: budget, template: item))
            }
        }
        
        return project
    }
    
    static func CreateTask(title: String, date : NSDate, budget: Double, template : TaskTemplate?) -> Task
    {
        let task = Task()
        //task.Id = App.Data.NewId;
        task.Title = title
        task.Budget = NSDecimalNumber(double: budget)
        task.DueDate = date
        
        if(template != nil)
        {
            task.Details = template!.Details;
            for item in template!.ActivityTemplates
            {
                let date = task.DueDate.addDays(item.InitialDurationInDays * -1)
                task.Activities.append(App.CreateActivity(item.Title, date: date, cost: 0.0, template: item))
            }
            //for item in template!.ResourceTemplates
            //{
            //task.Resources.append(App.CreateResource(item.Title, template: item))
            //}
        }
        
        return task;
    }
    
    static func CreateActivity(title: String, date : NSDate, cost: Double, template : ActivityTemplate?) -> Activity
    {
        let activity = Activity()
        //activity.Id = App.Data.NewId;
        activity.Title = title
        activity.Cost = NSDecimalNumber(double: cost)
        activity.DueDate = date
        
        
        if(template != nil)
        {
            activity.Details = template!.Details;
        }
        
        return activity;
    }
    
    
    
    
    //----------------------------------------
    
    
    
    
    
    static func getProjectCosts(project : Project) -> CostBreakdown {
        var activitiesCost : Double = 0;
        var resourcesCost : Double = 0;
        
        for item in project.Tasks {
            let costs = App.getTaskCosts(item);
            activitiesCost += costs.ActivitiesCost.doubleValue
            resourcesCost += costs.ResourcesCost.doubleValue;
        }
        
        return CostBreakdown(activitiesCost: activitiesCost, resourcesCost: resourcesCost);
    }
    
    static func getTaskCosts(task : Task) -> CostBreakdown {
        var activitiesCost : Double = 0;
        for item in task.Activities {
            if(item.IsCompleted){
                activitiesCost += item.Cost.doubleValue
            }
        }
        
        let resourcesCost : Double = 0;
        //for item in task.Resources {
        //    resourcesCost += item.Cost.doubleValue
        //}
        
        return CostBreakdown(activitiesCost: activitiesCost, resourcesCost: resourcesCost);
    }
    
    static func getTaskAssignee(task : Task) -> Assignee?{
        let assignees = App.Memory.selectedProject!.Contacts.filter{$0.Email == task.AssigneeLink }
        if(assignees.isEmpty){
            return nil;
        }
        else{
            return assignees[0]
        }
    }
    
    static func getProjectTaskCount(project : Project) -> Int{
        return project.Tasks.count;
    }
    static func getProjectActivitiesCount(project : Project) -> Int{
        var count = 0;
        for task in project.Tasks {
                count = count + task.Activities.count;
        }
        return count;
    }
    static func getProjectCompletedActivitiesCount(project : Project) -> Int{
        var count = 0;
        for task in project.Tasks {
            for activity in task.Activities {
                if(activity.IsCompleted){
                    count = count + 1
                }
            }
        }

        return count;
    }
    static func getDaysToDeadline(deadline : NSDate) -> Int{
        let cal = NSCalendar.currentCalendar()
        
        
        let unit:NSCalendarUnit = .Day;
        
        let components = cal.components(unit, fromDate: NSDate(), toDate: deadline, options: .WrapComponents)
        
        return components.day;
    }
    
    static func getCostDueForProject(project: Project) -> NSDecimalNumber{
        var cost = 0.0;
        
        for item in project.Tasks{
            cost = cost + getCostDueForTask(item).doubleValue;
        }
        
        return NSDecimalNumber(double: cost);
    }
    
    static func getCostDueForTask(task: Task) -> NSDecimalNumber{
        var cost = 0.0;
        
        for item in task.Activities {
            cost = cost + (item.DueInDays <= 0 ? item.Cost.doubleValue : 0.0);
        }
        
        return NSDecimalNumber(double: cost);
    }
    
    static func getPaymentsTotalForProject(project: Project) -> NSDecimalNumber{
        var total = 0.0;
        
        for item in project.Tasks{
            total = total + item.Payments.reduce(0.0) { $0 + $1.Amount.doubleValue};
        }
        
        return NSDecimalNumber(double: total);
    }
    
    static func getUnpaidTotalForProject(project : Project) -> NSDecimalNumber{
        var total = 0.0;
        
        for item in project.Tasks{
            total = total + (getCostDueForTask(item).doubleValue - item.Payments.reduce(0.0) { $0 + $1.Amount.doubleValue});
        }
        
        return NSDecimalNumber(double: total);
    }

    
    static func getProjectActivityBoard(project : Project) -> ProjectActivityBoard
    {
        let board = ProjectActivityBoard()
        
        for task in project.Tasks {
            for activity in task.Activities {
                if(activity.IsCompleted){
                    board.CompletedActivities.append(BoardActivity(activity: activity, taskTitle: task.Title, assignee_Id: task.Assignee_Id));
                }
                else if(activity.DueInDays <= 0)
                {
                    board.DueActivities.append(BoardActivity(activity: activity, taskTitle: task.Title, assignee_Id: task.Assignee_Id))
                }
                else{
                    board.UpcomingActivities.append(BoardActivity(activity: activity, taskTitle: task.Title, assignee_Id: task.Assignee_Id))
                }
            }
        }
        
        board.DueActivities.sortInPlace { (item1, item2) -> Bool in
            return item1.DueInDays < item2.DueInDays
        }
        board.UpcomingActivities.sortInPlace { (item1, item2) -> Bool in
            return item1.DueInDays < item2.DueInDays
        }
        board.CompletedActivities.sortInPlace { (item1, item2) -> Bool in
            return item1.DueInDays > item2.DueInDays
        }
        
        return board;
    }
    
    static func getTaskActivityBoard(task : Task) -> ProjectActivityBoard
    {
        let board = ProjectActivityBoard()
        
        for activity in task.Activities {
            if(activity.IsCompleted){
                board.CompletedActivities.append(BoardActivity(activity: activity, taskTitle: task.Title, assignee_Id: task.Assignee_Id));
            }
            else if(activity.DueInDays <= 0)
            {
                board.DueActivities.append(BoardActivity(activity: activity, taskTitle: task.Title, assignee_Id: task.Assignee_Id))
            }
            else{
                board.UpcomingActivities.append(BoardActivity(activity: activity, taskTitle: task.Title, assignee_Id: task.Assignee_Id))
            }
        }
        
        board.DueActivities.sortInPlace { (item1, item2) -> Bool in
            return item1.DueInDays < item2.DueInDays
        }
        board.UpcomingActivities.sortInPlace { (item1, item2) -> Bool in
            return item1.DueInDays < item2.DueInDays
        }
        board.CompletedActivities.sortInPlace { (item1, item2) -> Bool in
            return item1.DueInDays > item2.DueInDays
        }
        
        return board;
    }
}

class CostBreakdown {
    
    init(activitiesCost: Double, resourcesCost: Double)
    {
        ActivitiesCost = NSDecimalNumber(double: activitiesCost);
        ResourcesCost = NSDecimalNumber(double: resourcesCost);
        TotalCost = NSDecimalNumber(double: (activitiesCost + resourcesCost));
    }
    var TotalCost: NSDecimalNumber
    var ActivitiesCost: NSDecimalNumber
    var ResourcesCost: NSDecimalNumber
    
}

class ProjectActivityBoard {
    var UpcomingActivities : [BoardActivity] = []
    var DueActivities : [BoardActivity] = []
    var CompletedActivities : [BoardActivity] = []
}

class BoardActivity {
    init(activity : Activity, taskTitle : String, assignee_Id : Int)
    {
        Id = activity.Id;
        Title = activity.Title;
        DueDate = activity.DueDate;
        Cost = activity.Cost;
        DueInDays = activity.DueInDays;
        IsCompleted = activity.IsCompleted
        CompletionDate = activity.CompletionDate
        TaskTitle = taskTitle
        Assignee_Id = assignee_Id
    }
    
    var Id : Int = 0;
    var Title : String  = "";
    var DueDate : NSDate!
    var Cost : NSDecimalNumber = 0.0
    
    var DueInDays : Int = 0;
    
    var IsCompleted : Bool = false;
    var CompletionDate : NSDate?;
    
    var Assignee_Id : Int = 0
    var TaskTitle = ""
}
