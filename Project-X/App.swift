//
//  AppLogic.swift
//  Project-X
//
//  Created by majeed on 14/03/2016.
//  Copyright © 2016 Almond Media Ltd. All rights reserved.
//

import Foundation

class App{
    static var Data : AppModel = AppModel()
    static var Memory : AppMemory = AppMemory();
    //static var appDelegate : UIApplication!
    static func StartUp()
    {
        
        App.PrepareTemplates();
        App.PrepareCustomUI();
        App.LoadLocalData();
        
        if(App.Data.User.AccessToken != ""){
            App.CreatProjectHub()
        }
        
    }
    
    static func ResetMemory()
    {
        App.Memory.selectedProject = nil;
        App.Memory.selectedTask = nil;
        App.Memory.selectedActivity = nil;
        App.Memory.selectedAssignee = nil;
        App.Memory.selectedPaymentTask = nil;
        App.Memory.selectedTemplate = nil;
    }
    
    static func LoadLocalData()
    {
        let content = X.LoadDataFromDir("App.data")
        App.Data = AppModel(json: content)
    }
    
    static func SaveLocalData()
    {
        //App.Data.SyncTimestamp = NSDate()
        let content = App.Data.toJsonString()
        X.SaveToDataDir("App.data", content: content)
    }
    
    static func SignOut()
    {
        App.Data.User.AccessToken = "";
        App.Data.SyncTimestamp = NSDate()
        App.SaveLocalData()
        
        App.CreatProjectHub()
    }
    
    static func PrepareTemplates()
    {
        let template1 = ProjectTemplate()
        template1.Title = "Building"
        template1.Description = "Lorem ipsum det imet gout et las vivas dout items"
        App.Memory.Templates.append(template1)
        
        
        let template4 = ProjectTemplate()
        template4.Title = "Landscaping"
        template4.Description = "Lorem ipsum det imet gout et las vivas dout items"
        App.Memory.Templates.append(template4)
        
        
        
        let template3 = ProjectTemplate()
        template3.Title = "Gardning"
        template3.Description = "Lorem ipsum det imet gout et las vivas dout items"
        App.Memory.Templates.append(template3)
        
        
        let template5 = ProjectTemplate()
        template5.Title = "Renovation"
        template5.Description = "Lorem ipsum det imet gout et las vivas dout items"
        App.Memory.Templates.append(template5)
        
        
        let template2 = ProjectTemplate()
        template2.Title = "Extension"
        template2.Description = "Lorem ipsum det imet gout et las vivas dout items"
        App.Memory.Templates.append(template2)
        
        
        let template6 = ProjectTemplate()
        template6.Title = "Repairs"
        template6.Description = "Lorem ipsum det imet gout et las vivas dout items"
        App.Memory.Templates.append(template6)
        
        
        
    }
    
    static func PrepareProjects()
    {
        let project1 = App.CreateProject("Home Repair", date: NSDate().addDays(13), budget: 82000.0, template: App.Memory.Templates[4])
        App.Data.Projects = [project1]
        
        
        App.GenerateAssignees(App.Data.Projects[0]);
        App.GenerateTasks(App.Data.Projects[0]);
        
    }
    
    static func GenerateTasks(project: Project)
    {
        let tasks : [Task] = [Task(), Task(), Task(), Task(), Task(), Task(), Task() ]
        
        tasks[0].Title = "Design"
        tasks[0].DueDate = NSDate().addDays(7);
        tasks[0].Assignee_Id = 1;
        
        tasks[1].Title = "Building"
        tasks[1].DueDate = NSDate().addDays(20);
        tasks[1].Assignee_Id = 2;
        
        tasks[2].Title = "Plumbing"
        tasks[2].DueDate = NSDate().addDays(30);
        tasks[2].Assignee_Id = 5;
        
        tasks[3].Title = "Carpentry"
        tasks[3].DueDate = NSDate().addDays(35);
        tasks[3].Assignee_Id = 7;
        
        tasks[4].Title = "Electrical"
        tasks[4].DueDate = NSDate().addDays(45);
        tasks[4].Assignee_Id = 4;
        
        tasks[5].Title = "Painting"
        tasks[5].DueDate = NSDate().addDays(48);
        tasks[5].Assignee_Id = 6;
        
        tasks[6].Title = "Decorating"
        tasks[6].DueDate = NSDate().addDays(52);
        tasks[6].Assignee_Id = 3;
        
        for index in 0 ... 5 {
            GenerateActivities(tasks[index])
        }
        
        project.Tasks = tasks;
    }
    
    static func GenerateActivities(task : Task)
    {
        let activities : [Activity] = [Activity(), Activity(), Activity(), Activity(), Activity()]
        
        activities[0].Title = "Purchase Resources"
        activities[0].DueDate = NSDate().addDays(0);
        activities[0].Cost = 1200;
        activities[0].IsCompleted = true;
        
        activities[1].Title = "Basement Work"
        activities[1].DueDate = NSDate().addDays(0);
        activities[1].Cost = 200;
        
        activities[2].Title = "Ground Floor Work"
        activities[2].DueDate = NSDate().addDays(1);
        activities[2].Cost = 300;
        
        activities[3].Title = "Upstairs Work"
        activities[3].DueDate = NSDate().addDays(5);
        activities[3].Cost = 350;
        
        activities[4].Title = "Outside Work"
        activities[4].DueDate = task.DueDate
        activities[4].Cost = 700;
        
        task.Activities = activities;
        
    }
    
    static func GenerateAssignees(project: Project)
    {
        project.Contacts = [Assignee(), Assignee(), Assignee(), Assignee(), Assignee(), Assignee(), Assignee()];
        
        project.Contacts[0].Id = 1
        project.Contacts[0].Name = "Craig Federighi";
        project.Contacts[0].Profession = "Architect";
        project.Contacts[0].Email = "c.federighi@mail.com";
        
        project.Contacts[1].Id = 2
        project.Contacts[1].Name = "Emannuel Ebate";
        project.Contacts[1].Profession = "Constructor";
        project.Contacts[1].Email = "e.ebate@mail.com";
        
        project.Contacts[5].Id = 3
        project.Contacts[5].Name = "Angela Ahrendts";
        project.Contacts[5].Profession = "Interior Designer";
        project.Contacts[5].Email = "a.ahrendts@mail.com";
        
        project.Contacts[2].Id = 4
        project.Contacts[2].Name = "Arun Gupta";
        project.Contacts[2].Profession = "Electrician";
        project.Contacts[2].Email = "a.gupta@mail.com";
        
        project.Contacts[3].Id = 5
        project.Contacts[3].Name = "Marek Kowalek";
        project.Contacts[3].Profession = "Plumber";
        project.Contacts[3].Email = "m.kowalek@mail.com";
        
        project.Contacts[4].Id = 6
        project.Contacts[4].Name = "John Smith";
        project.Contacts[4].Profession = "Painter";
        project.Contacts[4].Email = "j.smith@mail.com";
        
        project.Contacts[6].Id = 7
        project.Contacts[6].Name = "Adam White";
        project.Contacts[6].Profession = "Carpenter";
        project.Contacts[6].Email = "a.white@mail.com";
        
        //App.Data.Assignees = assignees;
    }
    
    
    static func getTemplates()
    {
        
        let filePath = NSBundle.mainBundle().pathForResource("templates", ofType: "json")
        
        // get the contentData
        let contentData = NSFileManager.defaultManager().contentsAtPath(filePath!)
        
        // get the string
        var content = NSString(data: contentData!, encoding: NSUTF8StringEncoding) as? String
        content = content?.stringByReplacingOccurrencesOfString("\n", withString: "")
        content = content?.stringByReplacingOccurrencesOfString("\t", withString: "")
        print(content)
        let templates = TemplateJson(json: content);
        print(templates);
    }
    
    
}