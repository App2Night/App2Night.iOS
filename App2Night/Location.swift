//
//  Location.swift
//  App2Night
//
//  Created by Robin on 24.10.16.
//  Copyright © 2016 DHBW. All rights reserved.
//

import Foundation

class Location {
    
    var countryName: String!
    var cityName: String!
    var streetName: String!
    var houseNumber: Int!
    var houseNumberAdditional: String!
    var zipcode: Int!
    var latitude: Int!
    var longitude: Int!
    
    
    init(fromDictionary dictionary: NSDictionary) {
        cityName = dictionary["cityName"] as? String
        countryName = dictionary["countryName"] as? String
        houseNumber = dictionary["houseNumber"] as? Int
        houseNumberAdditional = dictionary["houseNumberAdditional"] as? String
        latitude = dictionary["latitude"] as? Int
        longitude = dictionary["longitude"] as? Int
        streetName = dictionary["streetName"] as? String
        zipcode = dictionary["zipcode"] as? Int
    }
    
    
}

