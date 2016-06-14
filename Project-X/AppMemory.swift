//
//  AppMemory.swift
//  Project-X
//
//  Created by majeed on 02/04/2016.
//  Copyright © 2016 Almond Media Ltd. All rights reserved.
//

import Foundation

class AppMemory
{
    var Templates : [ProjectTemplate] = []
    var selectedTemplate : ProjectTemplate? = nil
    
    var selectedProjectIndex : Int = -1
    var selectedProject : Project? {
        get{
            return App.Data.Projects[safe: selectedProjectIndex];
        }
        set (newValue)
        {
            if(newValue != nil){
            selectedProjectIndex = App.Data.Projects.indexOf(newValue!)!
            }
            else{
                selectedProjectIndex = -1;
            }
            
        }
    }
    
    var selectedTaskIndex : Int = -1
    var selectedTask : Task? {
        get{
            return selectedProject?.Tasks[safe: selectedTaskIndex];
        }
        set (newValue)
        {
            if(newValue != nil){
                selectedTaskIndex = (selectedProject?.Tasks.indexOf(newValue!))!
            }
            else{
                selectedTaskIndex = -1;
            }
            
        }
    }
    
    var selectedActivityIndex : Int = -1
    var selectedActivity : Activity? {
        get{
            return selectedTask?.Activities[safe: selectedActivityIndex];
        }
        set (newValue)
        {
            if(newValue != nil){
                selectedActivityIndex = (selectedTask?.Activities.indexOf(newValue!))!
            }
            else{
                selectedActivityIndex = -1;
            }
            
        }
    }
    
    var selectedAssigneeIndex : Int = -1
    var selectedAssignee : Assignee? {
        get{
            return selectedProject?.Contacts[safe: selectedAssigneeIndex];
        }
        set (newValue)
        {
            if(newValue != nil){
                selectedAssigneeIndex = (selectedProject?.Contacts.indexOf(newValue!))!
            }
            else{
                selectedAssigneeIndex = -1;
            }
            
        }
    }
    
    var selectedPaymentTaskndex : Int = -1
    var selectedPaymentTask : Task? {
        get{
            return selectedProject?.Tasks[safe: selectedPaymentTaskndex];
        }
        set (newValue)
        {
            if(newValue != nil){
                selectedPaymentTaskndex = (selectedProject?.Tasks.indexOf(newValue!))!
            }
            else{
                selectedPaymentTaskndex = -1;
            }
            
        }
    }
    
    var selectedPaymentIndex : Int = -1
    var selectedPayment : Payment? {
        get{
            return selectedPaymentTask?.Payments[safe: selectedPaymentIndex];
        }
        set (newValue)
        {
            if(newValue != nil){
                selectedPaymentIndex = (selectedPaymentTask?.Payments.indexOf(newValue!))!
            }
            else{
                selectedPaymentIndex = -1;
            }
            
        }
    }
}