//
//  Model.swift
//  Project-X
//
//  Created by majeed on 11/03/2016.
//  Copyright © 2016 Almond Media Ltd. All rights reserved.
//

import Foundation


class AppModel : EVObject {
    //var uuid = NSUUID().UUIDString
    var SyncTimestamp : NSDate =  NSDate(timeIntervalSince1970: 0)
    var User : AppUser = AppUser()
    var Projects : [Project] = []
    
    //var Assignees : [Assignee] = []
    //var MediaAttachments : [MediaAttachment] = []
    
}

class AppUser : EVObject{
    var Id : Int = 0;
    var Name : String  = "";
    var Email : String  = "";
    var Phone : String  = "";
    
    var Bio : String  = "";
    var Profession : String  = "";
    var AccessToken : String  = "";
    
    var ResourceUID : String  = "";
    
    var Details = [String: String]();
    
    //var Projects : [Project] = []
    
}

class Project : EVObject {
    var Id : Int = 0;
    var PlannerId : Int = 0;
    var Title : String  = "";
    var ProjectType : String = ""
    var TemplateId : Int = 0;
    var StartDate : NSDate = NSDate()
    var DueDate : NSDate = NSDate()
    var Budget : NSDecimalNumber = 0.0
    var Currency : String = "GBP"
    
    var Details = [String: String]();
    
    var Tasks : [Task] = []
    
    var Contacts : [Assignee] = []
    
    override func propertyConverters() -> [(String?, (Any?)->(), () -> Any? )] {
        
        return
            [("StartDate", {
                self.StartDate = X.makeDateFromUniversalDateString($0 as! String) },
                { return self.StartDate.localDescription}),
             ("DueDate",
                { self.DueDate = X.makeDateFromUniversalDateString($0 as! String) },
                { return self.DueDate.localDescription})
        ]
    }
    
    
    //Completion
    var IsCompleted : Bool{
        
        get{
            return self.Tasks.filter({ (item) -> Bool in
                return item.IsCompleted == false
            }).isEmpty
        }
    }
    var CompletionDate : NSDate?{
        get{
            if(!self.Tasks.isEmpty)
            {
                let sortedDate = self.Tasks.sort{$0.DueDate.timeIntervalSince1970 > $1.DueDate.timeIntervalSince1970};
                return sortedDate[0].DueDate
            }
            else {
                return nil;
            }
        }
    }
    
}


class Task : EVObject {
    
    var Id : Int = 0;
    var Title : String  = "";
    var ProjectId : Int = 0;
    var ProjectTitle : String = ""
    var PlannerName : String = "";
    
    var StartDate : NSDate = NSDate()
    var DueDate : NSDate = NSDate()
    var Budget : NSDecimalNumber = 0.0
    
    var Assignee_Id : Int = 0
    var AssigneeLink : String = ""
    var AssigneeDidAccept : Bool = false
    
    var Details = [String: String]();
    
    var Activities : [Activity] = []
    var Payments : [Payment] = []
    
    override func propertyConverters() -> [(String?, (Any?)->(), () -> Any? )] {
        
        return
            [("StartDate", {
                self.StartDate = X.makeDateFromUniversalDateString($0 as! String) },
                { return self.StartDate.localDescription}),
             ("DueDate",
                { self.DueDate = X.makeDateFromUniversalDateString($0 as! String) },
                { return self.DueDate.localDescription})
        ]
    }
    
    //Completion
    var IsCompleted : Bool{
        
        get{
            return self.Activities.filter({ (item) -> Bool in
                return item.IsCompleted == false
            }).isEmpty
        }
    }
    var CompletionDate : NSDate?{
        get{
            if(!self.Activities.isEmpty)
            {
                let sortedDate = self.Activities.sort{$0.DueDate.timeIntervalSince1970 > $1.DueDate.timeIntervalSince1970};
                return sortedDate[0].DueDate
            }
            else {
                return nil;
            }
        }
    }
    
    
    
}

class Activity : EVObject {
    var Id : Int = 0;
    var TaskId : Int = 0;
    var Title : String  = "";
    var ActivityType : String = ""
    var StartDate : NSDate  = NSDate()
    var DueDate : NSDate  = NSDate()
    var Cost : NSDecimalNumber = 0.0
    
    var DueInDays : Int {
        get{ return X.getDaysBetweenDate(NSDate().addDays(0), endDate: self.DueDate )}
    }
    
    var IsCompleted : Bool = false;
    var CompletionDate : NSDate?;
    
    var DoneByAssignee_Id : Int = 0
    
    var Details = [String: String]();
    
    override func propertyConverters() -> [(String?, (Any?)->(), () -> Any? )] {
        
        return
            [("CompletionDate", {
                self.CompletionDate = X.makeDateFromUniversalDateString($0 as! String) },
                { return self.CompletionDate?.localDescription}),
             ("StartDate", {
                self.StartDate = X.makeDateFromUniversalDateString($0 as! String) },
                { return self.StartDate.localDescription}),
             ("DueDate",
                { self.DueDate = X.makeDateFromUniversalDateString($0 as! String) },
                { return self.DueDate.localDescription ; })
        ]
    }
}


class Assignee : EVObject {
    
    var ProjectId : Int = 0;
    
    var Id : Int = 0;
    var Name : String  = "";
    var Email : String  = "";
    var Phone : String  = "";
    
    var Bio : String  = "";
    var Profession : String  = "";
    
    var ResourceUID : String  = "00000000";
}


class Payment : EVObject {
    var Id : Int = 0;
    var Title : String  = "";
    
    var Amount : NSDecimalNumber = 0.0
    var DateTime : NSDate = NSDate()
    
    var TaskId : Int = 0;
    var ReceivedBy : String  = "";
    var Comment : String  = "";
    
    override func propertyConverters() -> [(String?, (Any?)->(), () -> Any? )] {
        
        return
            [("DateTime", {
                self.DateTime = X.makeDateFromUniversalDateString($0 as! String) },
                { return self.DateTime.localDescription})
        ]
    }
}












class Resource {
    var Id : Int = 0;
    var Title : String  = "";
    
    var Cost : NSDecimalNumber = 0.0
    var PurchaseDate = NSDate();
    
    var Details = [String: String]();
}


class MediaAttachment {
    var Id : Int = 0;
    var Title : String  = "";
    var UploadDate = NSDate();
    var MediaType : TypeOfMedia = .Photo;
    
    var Tags = [String : Int]() //ClassType and Id
    
}
enum TypeOfMedia {
    case Photo
    case WebLink
    case Audio
    case Video
    case Pdf
    case Others
}



//class ProjectItem : EVObject {
//
//    var Id : Int = 0;
//    var ProjectId : Int = 0
//    var Title : String  = "";
//    var StartDate = NSDate()
//    var DueDate = NSDate()
//    var MaxBudget : NSDecimalNumber = 0.0
//
//    var PreceedingItem_Id : Int = 0
//
//    var Details = [String: String]();
//
//    var Tasks : [Task] = []
//
//
//    //Completion
//    var IsCompleted : Bool{
//
//        get{
//            return self.Tasks.filter({ (item) -> Bool in
//                return item.IsCompleted == false
//            }).isEmpty
//        }
//    }
//    var CompletionDate : NSDate?{
//        get{
//            if(!self.Tasks.isEmpty)
//            {
//                let sortedDate = self.Tasks.sort{$0.DueDate.timeIntervalSince1970 > $1.DueDate.timeIntervalSince1970};
//                return sortedDate[0].DueDate
//            }
//            else {
//                return nil;
//            }
//        }
//    }
//}


