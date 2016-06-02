//
//  AppNetwork.swift
//  Project-X
//
//  Created by majeed on 20/05/2016.
//  Copyright © 2016 Almond Media Ltd. All rights reserved.
//

import Foundation

extension App {
    
    // 
    static var projectHub: Hub!
    static var projectConnection: SignalR!

    
    static var accountHub: Hub!
    static var accontConnection: SignalR!
    
    
    static func setupNetwork()
    {
        
        email = "testmail1@thealmondmedia.com";
        password = "12345678";
        
        accontConnection = SwiftR.connect("http://projectxplatform.azurewebsites.net"){ connection in
            
            accountHub = connection.createHubProxy("accountHub")
            
            connection.starting = {
                print("starting")
            }
            
            connection.reconnecting = {
                print("reconnecting")
            }
            
            connection.connected = {
                print("connected")
                Login();
            }
            
            connection.reconnected = {
                print("reconnected")
                Login();
            }
            
            connection.disconnected = {
                print("disconnected")
                connection.start()
            }
        }

    }
    
    static var email : String!
    static var password : String!
    static var accessToken : String!  = "";
    
    static func Login()
    {
        accountHub.invoke("login", arguments: [email, password]) { (result, error) in
            if(error == nil && result != nil){
                let feedback = AccountAccessFeedback(dictionary: (result as! [String : AnyObject]))
                let appUser = feedback.User;
                if(appUser != nil){
                    accessToken = appUser?.AccessToken;
                    print(accessToken);
                    CreatProjectHub()
                }
            }
            else{
                print(error)
            }
        }
    }
    
    
    static func CreatProjectHub()
    {
        projectConnection = SwiftR.connect("http://projectxplatform.azurewebsites.net"){ connection in
            connection.queryString = ["token" : accessToken];
            
            projectHub = connection.createHubProxy("projectHub")
            
            projectHub.on("userFound", callback: { args in
                print("Found " + args![0].description);
            })
            connection.starting = {
                print("starting")
            }
            
            connection.reconnecting = {
                print("reconnecting")
            }
            
            connection.connected = {
                print("connected")
                getProjects();
            }
            
            connection.reconnected = {
                print("reconnected")
            }
            
            connection.disconnected = {
                print("disconnected")
                connection.start()
            }
        }
    }
    
    
    static func getProjects()
    {
        projectHub.invoke("getProjects", arguments: [[0]]) { (result, error) in
            if(error == nil){
                let response = ProjectsResults(dictionary: (result as! [String : AnyObject]))
                App.Data.Projects = response.Projects;
                ProjectsReloadedEvent.raise()
                print(response.Message)
            }
            else{
                print(error);
            }
            
        };
        
    }
    

    
/*  projectHub.invoke("", arguments: []) { (result, error) in
 
    }
*/
}


class Event<T> {
    
    typealias EventHandler = T -> ()
    
    private var eventHandlers = [EventHandler]()
    
    func addHandler(handler: EventHandler) {
        eventHandlers.append(handler)
    }
    
    func raise(data: T) {
        for handler in eventHandlers {
            handler(data)
        }
    }
}