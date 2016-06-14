//
//  ProjectTemplate.swift
//  Project-X
//
//  Created by majeed on 15/03/2016.
//  Copyright © 2016 Almond Media Ltd. All rights reserved.
//

import Foundation


class ProjectTemplate {
    
    var ProjectType : TypeOfProject = .Work;
    var Title : String = "";
    var Description : String = "";
    var Details = [String: String]();
    
    var TaskTemplates : [TaskTemplate] = []
}

class TaskTemplate {
    var Title : String = "";
    var IsOptional : Bool = false;
    var StartDayOffset : Int = 0;
    var EndDayOffset : Int = 0;
    var InitialMinBudget : NSDecimalNumber = 0;
    var InitialMaxBudget : NSDecimalNumber = 0;
    var InitialPercentageBudget : Double = 0.0;
    
    var Details = [String: String]();
    
    var ActivityTemplates : [ActivityTemplate] = []
    var ResourceTemplates : [ResourceTemplate] = []
    
}

class ActivityTemplate {
    var Title : String = "";
    var IsOptional : Bool = false;
    var StartDayOffset : Int = 0;
    var InitialDurationInDays : Int = 0;
    var InitialFixedCost : NSDecimalNumber = 0;
    var InitialPercentageCost : Double = 0.0;
    
    var Details = [String: String]();
}

class ResourceTemplate {
    var Title : String  = "";
    var IsOptional : Bool = false;
    var DefaultCost : NSDecimalNumber = 0.0
    
    var Details = [String: String]();
}

enum TypeOfProject {
    case Work
    case Event
    case Holiday
}





class TemplateJson : EVObject
{
    var events : [ProjectJson] = []
    var building : [ProjectJson] = []
    var travel : [ProjectJson] = []
}

class ProjectJson : EVObject
{
    var title : String = ""
    var tasks :[String] = []
}