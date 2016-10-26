//
//  Host.swift
//  App2Night
//
//  Created by Robin on 24.10.16.
//  Copyright © 2016 DHBW. All rights reserved.
//

import Foundation

public class Host {
    
    private var userId: String!
    private var username: String!
    private var password: String!
    private var location: Location!
    
    
    init(pDictionary: NSDictionary) {
        userId = pDictionary["userId"] as? String
        username = pDictionary["username"] as? String
        password = pDictionary["password"] as? String
    }
    
    // MARK: GET & SET
    public func getUserID() -> String {
        return self.userId
    }
    
    public func setUserID(pUserID: String) {
        self.userId = pUserID
    }
    
    public func getUsername() -> String {
        return self.username
    }
    
    public func setUsername(pUsername: String) {
        self.username = pUsername
    }
    
    public func getPassword() -> String {
        return self.password
    }
    
    public func setPassword(pPassword: String) {
        self.password = pPassword
    }
    
    public func getLocation() -> Location {
        return self.location
    }
    
    public func setLocation(pLocation: Location) {
        self.location = pLocation
    }
    
    
}

