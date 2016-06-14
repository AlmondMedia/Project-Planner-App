//
//  AppEvents.swift
//  Planner
//
//  Created by majeed on 26/05/2016.
//  Copyright © 2016 Almond Media Ltd. All rights reserved.
//

import Foundation

extension App {
    
    static var UserLoggedInEvent = Event<Void>();
    static var UserLogInFailedEvent = Event<Void>();
    static var UserSignupFailedEvent = Event<String>();
    static var UserSignupEvent = Event<Void>();
    
    static var ProjectsReloadedEvent = Event<Void>();
    static var TasksReloadedEvent = Event<Void>();
    static var ActivitiesReloadedEvent = Event<Void>();
    static var PaymentsReloadedEvent = Event<Void>();
    static var ContactsReloadedEvent = Event<Void>();
    
    static var CurrentProjectChangedEvent = Event<Void>();
    static var CurrentTaskChangedEvent = Event<Void>();
    static var CurrentActivityChangedEvent = Event<Void>();
    static var CurrentPaymentChangedEvent = Event<Void>();
    
    static var ProfileImageDownloadedEvent = Event<Void>();
    static var ContactsImageDownloadedEvent = Event<String>();
    
}