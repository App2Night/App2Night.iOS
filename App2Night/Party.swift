//
//  Party.swift
//  App2Night
//
//  Created by Robin on 24.10.16.
//  Copyright © 2016 DHBW. All rights reserved.
//

import Foundation
import Gloss

//MARK: - Party
public struct Party: Glossy {
    
    public let date : String!
    public let descriptionField : String!
    public let host : Host!
    public let location : Location!
    public let musicGenre : Int!
    public let partId : String!
    public let partyDate : String!
    public let partyName : String!
    public let partyType : Int!
    public let price : Int!
    
    
    //MARK: Decodable
    public init?(json: JSON){
        date = "date" <~~ json
        descriptionField = "description" <~~ json
        host = "host" <~~ json
        location = "location" <~~ json
        musicGenre = "musicGenre" <~~ json
        partId = "partId" <~~ json
        partyDate = "partyDate" <~~ json
        partyName = "partyName" <~~ json
        partyType = "partyType" <~~ json
        price = "price" <~~ json
    }
    
    //MARK: Encodable
    public func toJSON() -> JSON? {
        return jsonify([
            "date" ~~> date,
            "description" ~~> descriptionField,
            "host" ~~> host,
            "location" ~~> location,
            "musicGenre" ~~> musicGenre,
            "partId" ~~> partId,
            "partyDate" ~~> partyDate,
            "partyName" ~~> partyName,
            "partyType" ~~> partyType,
            "price" ~~> price,
            ])
    }
    
    
}

