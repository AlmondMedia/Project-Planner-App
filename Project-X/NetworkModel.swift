//
//  NetworkModel.swift
//  Project-X
//
//  Created by majeed on 23/05/2016.
//  Copyright © 2016 Almond Media Ltd. All rights reserved.
//

import Foundation

class UserAccount : EVObject
{
    var UserAccessToken : String = "";
    var Email : String = "";
    var Password : String = "";
    var Name : String = "";
    var Phone : String = "";
    var UserRole : String = "PLANNER";
}


class AccountAccessFeedback : EVObject
{
    var Success : Bool = false;
    var Response : String = "";
    var Message : String = "";
    var User : AppUser?;
}

class ProjectsResults : EVObject
{
    var Action : String = "";
    var Message : String = "";
    var Success : Bool = false;
    var Projects : [Project] = [];
    var SycnTimestamp : NSDate = NSDate()
    override func propertyConverters() -> [(String?, (Any?)->(), () -> Any? )] {
        
        return
            [("SycnTimestamp", {
                self.SycnTimestamp = X.makeDateFromUniversalDateString($0 as! String) },
                { return self.SycnTimestamp.description})
        ]
    }
}

class TasksResults : EVObject
{
    var Action : String = "";
    var Message : String = "";
    var Success : Bool = false;
    var Tasks : [Task] = [];
}

class ActivitiesResults : EVObject
{
    var Action : String = "";
    var Message : String = "";
    var Success : Bool = false;
    var Activities : [Activity] = [];
}

class ContactsResults : EVObject
{
    var Action : String = "";
    var Message : String = "";
    var Success : Bool = false;
    var Contacts : [Assignee] = [];
}

class AssignedTasksResults : EVObject
{
    var Action : String = "";
    var Message : String = "";
    var Success : Bool = false;
    var Tasks : [Task] = [];
}

class ActionFeedback : EVObject
{
    var Response : String = "";
    var Message : String = "";
    var Success : Bool = false;
}


class FileUpload : EVObject
{
    required init() {
        
    }
    
    init(image : UIImage){
        let size = image.size.height;
        let compression = 150.0 / size
        let data:NSData = UIImageJPEGRepresentation(image, compression)!
        base64String = data.base64EncodedStringWithOptions(.Encoding64CharacterLineLength)
    }
    
    init(image : UIImage, height: CGFloat){
        let size = image.size.height;
        let compression = height / size
        let data:NSData = UIImageJPEGRepresentation(image, compression)!
        base64String = data.base64EncodedStringWithOptions(.Encoding64CharacterLineLength)
    }
    
    init(data : NSData) {
        base64String = data.base64EncodedStringWithOptions(.Encoding64CharacterLineLength)
    }
    
    var accessToken : String = ""
    var base64String : String = ""
    
}