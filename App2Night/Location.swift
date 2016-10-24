//
//  Location.swift
//  App2Night
//
//  Created by Robin on 24.10.16.
//  Copyright © 2016 DHBW. All rights reserved.
//

import Foundation
import Gloss

//MARK: - Location
public struct Location: Glossy {
    
    public let cityName : String!
    public let countryName : String!
    public let houseNumber : Int!
    public let houseNumberAdditional : String!
    public let latitude : Int!
    public let longitude : Int!
    public let streetName : String!
    public let zipcode : Int!
    
    
    //MARK: Decodable
    public init?(json: JSON){
        cityName = "cityName" <~~ json
        countryName = "countryName" <~~ json
        houseNumber = "houseNumber" <~~ json
        houseNumberAdditional = "houseNumberAdditional" <~~ json
        latitude = "latitude" <~~ json
        longitude = "longitude" <~~ json
        streetName = "streetName" <~~ json
        zipcode = "zipcode" <~~ json
    }
    
    //MARK: Encodable
    public func toJSON() -> JSON? {
        return jsonify([
            "cityName" ~~> cityName,
            "countryName" ~~> countryName,
            "houseNumber" ~~> houseNumber,
            "houseNumberAdditional" ~~> houseNumberAdditional,
            "latitude" ~~> latitude,
            "longitude" ~~> longitude,
            "streetName" ~~> streetName,
            "zipcode" ~~> zipcode,
            ])
    }
    
    
}

