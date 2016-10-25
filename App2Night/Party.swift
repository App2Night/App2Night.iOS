//
//  Party.swift
//  App2Night
//
//  Created by Robin on 24.10.16.
//  Copyright © 2016 DHBW. All rights reserved.
//

import Foundation

class Party {
    
    var partId: String!
    var date: String!
    var price: Int!
    var partyName: String!
    var partyDate: String!
    var musicGenre: Int!
    var partyType: Int!
    var descriptionField: String!
    
    var host: Host!
    var location: Location!
    
    
    init(fromDictionary dictionary: NSDictionary) {
        date = dictionary["date"] as? String
        descriptionField = dictionary["description"] as? String
        musicGenre = dictionary["musicGenre"] as? Int
        partId = dictionary["partId"] as? String
        partyDate = dictionary["partyDate"] as? String
        partyName = dictionary["partyName"] as? String
        partyType = dictionary["partyType"] as? Int
        price = dictionary["price"] as? Int
    }
    
    
}

