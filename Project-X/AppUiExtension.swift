//
//  UiLogic.swift
//  Project-X
//
//  Created by majeed on 24/03/2016.
//  Copyright © 2016 Almond Media Ltd. All rights reserved.
//

import Foundation

extension App {
    
    static var window : UIWindow = UIWindow()
    static var tintColor : UIColor!
    static var dangerColor : UIColor!
    static var darkDangerColor : UIColor!
    static var warningColor : UIColor!
    static var defaultColor: UIColor!
    static var successColor: UIColor!
    static var primaryColor: UIColor!
    static func PrepareCustomUI()
    {
        applyLightUI();
    }
    
    
    
    static func applyLightUI()
    {
        window.backgroundColor = UIColor.whiteColor()
        
        tintColor = UIColor(red: 0.03, green: 0.03, blue: 0.03, alpha: 1.0)//UIColor(red: 0.21, green: 0.22, blue: 0.27, alpha: 1.0)
        window.tintColor = UIColor(red: 34.0/255.0, green: 108.0/255.0, blue: 176.0/255.0, alpha: 1.0)
        
        App.darkDangerColor = UIColor(red: 139.0/255.0, green: 0/255.0, blue: 8.0/255.0, alpha: 1.0)
        App.dangerColor = UIColor(red: 0.86, green: 0.25, blue: 0.22, alpha: 1.0)
        App.warningColor = UIColor(red: 0.95, green: 0.73, blue: 0.07, alpha: 1.0)
        App.defaultColor = UIColor.darkGrayColor()
        App.successColor = UIColor(red: 0.32, green: 0.65, blue: 0.33, alpha: 1.0)
        App.primaryColor = UIColor(red: 34.0/255.0, green: 108.0/255.0, blue: 176.0/255.0, alpha: 1.0)
        
        let backImg: UIImage = UIImage(named: "ui-icon-back-button")!;
        UIBarButtonItem.appearance().setBackButtonBackgroundImage(backImg, forState: .Normal, barMetrics: .Default);
        
        //UINavigationBar.appearance().setBackgroundImage(UIImage(), forBarMetrics: .Default)
        //UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.93)
        UINavigationBar.appearance().translucent = true
        
        let navbarFont = UIFont(name: "Helvetica-Light", size: 16) ?? UIFont.systemFontOfSize(16)
        let barbuttonFont = UIFont(name: "Helvetica", size: 15) ?? UIFont.systemFontOfSize(15)
        
        UINavigationBar.appearance().tintColor = tintColor  //UIColor.blackColor()
        
        UINavigationBar.appearance().titleTextAttributes = [NSFontAttributeName: navbarFont, NSForegroundColorAttributeName:UIColor.darkTextColor()]
        UIBarButtonItem.appearance().setTitleTextAttributes([NSFontAttributeName: barbuttonFont, NSForegroundColorAttributeName:UIColor.darkTextColor()], forState: UIControlState.Normal)
        
        UITabBar.appearance().backgroundImage = UIImage()
        //UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.93)
        UITabBar.appearance().translucent = true
        UITabBar.appearance().tintColor = tintColor;
        
        UIToolbar.appearance().setBackgroundImage(UIImage(), forToolbarPosition: .Any, barMetrics: .Default)
        //UIToolbar.appearance().shadowImageForToolbarPosition(.Bottom)
        UIToolbar.appearance().backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.9)
        UIToolbar.appearance().translucent = true
        
        
        //UILabel.appearance().textColor = UIColor.darkTextColor()
    }

    
    static func setupInAppNotificationView()
    {
        
    }
    
    
    static func displayNotification(title: String, body : String)
    {
        let notification = UILocalNotification()
        notification.alertBody = body
        notification.alertAction = "open" // text that is displayed after "slide to..." on the lock screen - defaults to "slide to view"
        notification.fireDate = NSDate().addSeconds(10) // todo item due date (when notification will be fired)
        notification.soundName = UILocalNotificationDefaultSoundName // play default sound
        notification.userInfo = ["UUID": "---"] // assign a unique identifier to the notification so that we can retrieve it later
        notification.category = "TASK UPDATE"
        UIApplication.sharedApplication().scheduleLocalNotification(notification)
    }
    
    
    static func displayAlert(sender: AnyObject, title: String, message: String, var actions:[UIAlertAction] = [UIAlertAction(title: "OK", style: UIAlertActionStyle.Default,handler: nil)])
    {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        for index in 0...(actions.count-1)
        {
            alertController.addAction(actions[index])
        }
        
        sender.presentViewController(alertController, animated: true, completion: nil)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    static func applyDarkUI()
    {
        window.backgroundColor = UIColor(red: 0.21, green: 0.22, blue: 0.27, alpha: 1.0)//UIColor(patternImage: UIImage(named: "App-BG-Image")!)
        
        window.tintColor = UIColor.whiteColor()
        
        
        UINavigationBar.appearance().setBackgroundImage(UIImage(), forBarMetrics: .Default)
        //UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().backgroundColor = UIColor(red: 0.21, green: 0.22, blue: 0.27, alpha: 0.97)//UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.0)
        UINavigationBar.appearance().translucent = true
        let navbarFont = UIFont(name: "Ubuntu", size: 17) ?? UIFont.systemFontOfSize(17)
        let barbuttonFont = UIFont(name: "Ubuntu-Light", size: 15) ?? UIFont.systemFontOfSize(15)
        
        UINavigationBar.appearance().titleTextAttributes = [NSFontAttributeName: navbarFont, NSForegroundColorAttributeName:UIColor.whiteColor()]
        UIBarButtonItem.appearance().setTitleTextAttributes([NSFontAttributeName: barbuttonFont, NSForegroundColorAttributeName:UIColor.whiteColor()], forState: UIControlState.Normal)
        
        UITabBar.appearance().backgroundImage = UIImage()
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().backgroundColor = UIColor(red: 0.21, green: 0.22, blue: 0.27, alpha: 0.97)//UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.03)
        UITabBar.appearance().translucent = true
        
        UIToolbar.appearance().setBackgroundImage(UIImage(), forToolbarPosition: .Any, barMetrics: .Default)
        UIToolbar.appearance().shadowImageForToolbarPosition(.Top)
        UIToolbar.appearance().backgroundColor = UIColor(red: 0.21, green: 0.22, blue: 0.27, alpha: 0.9)//UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.03)
        UIToolbar.appearance().translucent = true
        
        
        UILabel.appearance().textColor = UIColor.whiteColor()
    }
}