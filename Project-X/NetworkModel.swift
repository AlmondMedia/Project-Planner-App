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
}

class TasksResults : EVObject
{
    var Action : String = "";
    var Message : String = "";
    var Success : Bool = false;
    var Tasks : [Task] = [];
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