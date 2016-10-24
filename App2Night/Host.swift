//
//  Host.swift
//  App2Night
//
//  Created by Robin on 24.10.16.
//  Copyright © 2016 DHBW. All rights reserved.
//

import Foundation
import Gloss

//MARK: - Host
public struct Host: Glossy {
    
    public let location : Location!
    public let password : String!
    public let userId : String!
    public let username : String!
    
    
    //MARK: Decodable
    public init?(json: JSON){
        location = "location" <~~ json
        password = "password" <~~ json
        userId = "userId" <~~ json
        username = "username" <~~ json
    }
    
    //MARK: Encodable
    public func toJSON() -> JSON? {
        return jsonify([
            "location" ~~> location,
            "password" ~~> password,
            "userId" ~~> userId,
            "username" ~~> username,
            ])
    }
    
    
}

