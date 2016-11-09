//
//  RealmModel.swift
//  App2Night
//
//  Created by Robin on 09.11.16.
//  Copyright © 2016 DHBW. All rights reserved.
//

import Foundation
import RealmSwift

class Party: Object {
	
	dynamic var id: String = ""
	dynamic var name: String = ""
	dynamic var price: Int = 0
	dynamic var date: String = ""
	dynamic var musicGenre: Int = 0
	dynamic var type: Int = 0
	dynamic var text: String = ""
	
	dynamic var location: Location?
	dynamic var host: Host?
	
	override static func primaryKey() -> String? {
		return "id"
	}
	
	
}

class Location: Object {
	
	dynamic var countryName: String = ""
	dynamic var cityName: String = ""
	dynamic var streetName: String = ""
	dynamic var houseNumber: String = ""
	dynamic var houseNumberAdditional: String = ""
	dynamic var zipcode: String = ""
	dynamic var latitude: Double = 0.0
	dynamic var longitude: Double = 0.0
	
	dynamic var party: Party?
	
	
}

class Host: Object {
	
	dynamic var id: String = ""
	dynamic var userName: String = ""
	
	let parties = List<Party>()
	
	override static func primaryKey() -> String? {
		return "id"
	}
	
	
}
