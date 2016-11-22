//
//  Location.swift
//  App2Night
//
//  Created by Robin on 10.11.16.
//  Copyright © 2016 DHBW. All rights reserved.
//

import Foundation
import RealmSwift

class Location: Object {
	
	dynamic var partyId: String = ""
	
	dynamic var countryName: String = ""
	dynamic var cityName: String = ""
	dynamic var streetName: String = ""
	dynamic var houseNumber: String = ""
	dynamic var zipcode: String = ""
	dynamic var latitude: Double = 0.0
	dynamic var longitude: Double = 0.0
	
	override static func primaryKey() -> String? {
		return "partyId"
	}
	
	
}

