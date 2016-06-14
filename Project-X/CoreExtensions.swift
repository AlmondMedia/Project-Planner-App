//
//  CoreExtensions.swift
//  KeepFit
//
//  Created by majeed on 09/02/2016.
//  Copyright © 2016 University of Salford. All rights reserved.
//

import Foundation

extension NSDate {
    var startOfDay: NSDate {
        return NSCalendar.currentCalendar().startOfDayForDate(self)
    }
    
    var endOfDay: NSDate {
        let components = NSDateComponents()
        components.day = 1
        components.second = -1
        return NSCalendar.currentCalendar().dateByAddingComponents(components, toDate: startOfDay, options: NSCalendarOptions())!
    }
    
    var endOfYesterday: NSDate {
        let components = NSDateComponents()
        components.day = -1
        return NSCalendar.currentCalendar().dateByAddingComponents(components, toDate: endOfDay, options: NSCalendarOptions())!
    }
    
    var tommorrow: NSDate {
        let components = NSDateComponents()
        components.day = 1
        return NSCalendar.currentCalendar().dateByAddingComponents(components, toDate: startOfDay, options: NSCalendarOptions())!
    }
    
    var aWeekAgo: NSDate {
        let components = NSDateComponents()
        components.day = -7
        return NSCalendar.currentCalendar().dateByAddingComponents(components, toDate: startOfDay, options: NSCalendarOptions())!
    }
    
    var nextWeek: NSDate {
        let components = NSDateComponents()
        components.day = 7
        return NSCalendar.currentCalendar().dateByAddingComponents(components, toDate: startOfDay, options: NSCalendarOptions())!
    }
    
    func addDays(days : Int) -> NSDate
    {
        let components = NSDateComponents()
        components.day = days
        return NSCalendar.currentCalendar().dateByAddingComponents(components, toDate: startOfDay, options: NSCalendarOptions())!
    }
    
    func addHours(hours : Int) -> NSDate
    {
        let components = NSDateComponents()
        components.hour = hours
        return NSCalendar.currentCalendar().dateByAddingComponents(components, toDate: self, options: NSCalendarOptions())!
    }
    
    func addSeconds(seconds : Int) -> NSDate
    {
        let components = NSDateComponents()
        components.second = seconds
        return NSCalendar.currentCalendar().dateByAddingComponents(components, toDate: self, options: NSCalendarOptions())!
    }
    
    var localDescription : String {
        return X.getDateString(self, format: "yyyy-MM-dd HH:mm:ss") + " +0000";
    }
    
    func timeAgo() -> String {
        let date = self;
        let calendar = NSCalendar.currentCalendar()
        let now = NSDate()
        let earliest = now.earlierDate(date)
        let latest = (earliest == now) ? date : now
        let components:NSDateComponents = calendar.components([NSCalendarUnit.Minute , NSCalendarUnit.Hour , NSCalendarUnit.Day , NSCalendarUnit.WeekOfYear , NSCalendarUnit.Month , NSCalendarUnit.Year , NSCalendarUnit.Second], fromDate: earliest, toDate: latest, options: NSCalendarOptions())
        
        if (components.year >= 2) {
            return "\(components.year) years ago"
        } else if (components.year >= 1){
            return "Last year"
            
        } else if (components.month >= 2) {
            return "\(components.month) months ago"
        } else if (components.month >= 1){
            return "Last month"
            
        } else if (components.weekOfYear >= 2) {
            return "\(components.weekOfYear) weeks ago"
        } else if (components.weekOfYear >= 1){
            return "Last week"
            
        } else if (components.day >= 2) {
            return "\(components.day) days ago"
        } else if (components.day >= 1){
            return "Yesterday"
            
        } else if (components.hour >= 2) {
            return "\(components.hour) hours ago"
        } else if (components.hour >= 1){
            return "An hour ago"
            
        } else if (components.minute >= 2) {
            return "\(components.minute) minutes ago"
        } else if (components.minute >= 1){
            return "A minute ago"
            
        } else if (components.second >= 3) {
            return "\(components.second) seconds ago"
        } else {
            return "Just now"
        }
    }
    
    func timeTill() -> String {
        let date = self;
        let calendar = NSCalendar.currentCalendar()
        let now = NSDate()
        let earliest = now.earlierDate(date)
        let latest = (earliest == now) ? date : now
        let components:NSDateComponents = calendar.components([NSCalendarUnit.Minute , NSCalendarUnit.Hour , NSCalendarUnit.Day , NSCalendarUnit.WeekOfYear , NSCalendarUnit.Month , NSCalendarUnit.Year , NSCalendarUnit.Second], fromDate: earliest, toDate: latest, options: NSCalendarOptions())
        
        if (components.year >= 2) {
            return "\(components.year) years"
        } else if (components.year >= 1){
            return "Next year"
            
        } else if (components.month >= 2) {
            return "\(components.month) months"
        } else if (components.month >= 1){
            return "Next month"
            
        } else if (components.weekOfYear >= 2) {
            return "\(components.weekOfYear) weeks"
        } else if (components.weekOfYear >= 1){
            return "Next week"
            
        } else if (components.day >= 2) {
            return "\(components.day) days"
        } else if (components.day >= 1){
            return "Tomorrow"
            
        } else if (components.hour >= 2) {
            return "\(components.hour) hours"
        } else if (components.hour >= 1){
            return "An hour"
            
        } else if (components.minute >= 2) {
            return "\(components.minute) minutes"
        } else if (components.minute >= 1){
            return "A minute"
            
        } else if (components.second >= 3) {
            return "\(components.second) seconds"
        } else {
            return "Now"
        }
    }
}


extension String {
    
    subscript (i: Int) -> Character {
        return self[self.startIndex.advancedBy(i)]
    }
    
    subscript (i: Int) -> String {
        return String(self[i] as Character)
    }
    
    subscript (r: Range<Int>) -> String {
        let start = startIndex.advancedBy(r.startIndex)
        let end = start.advancedBy(r.endIndex - r.startIndex)
        return self[Range(start ..< end)]
    }
}

extension CollectionType {
    /// Returns the element at the specified index iff it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Generator.Element? {
        return indices.contains(index) ? self[index] : nil
    }
}


