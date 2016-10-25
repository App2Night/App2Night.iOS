//
//  Host.swift
//  App2Night
//
//  Created by Robin on 24.10.16.
//  Copyright © 2016 DHBW. All rights reserved.
//

import Foundation

class Host {
    
    var userId: String!
    var username: String!
    var location: Location!
    
    
    init(fromDictionary dictionary: NSDictionary) {
        // password = dictionary["password"] as? String
        userId = dictionary["userId"] as? String
        username = dictionary["username"] as? String
    }
    
    
}

