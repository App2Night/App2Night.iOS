//
//  DummyParty.swift
//  App2Night
//
//  Created by Robin on 09.11.16.
//  Copyright © 2016 DHBW. All rights reserved.
//

import Foundation

public class dParty {
	
	var id: String!
	var name: String!
	var price: Int!
	var date: String!
	var musicGenre: Int!
	var type: Int!
	var text: String!
	var location: dLocation!
	var host: dHost!
	
	static var partiesArray: [dParty] = []
	
	init() {
		setupDummyData()
		dParty.partiesArray.append(self)
	}
	
	func setupDummyData() {
		let location: dLocation = {
			let location = dLocation()
			
			location.countryName = "Germany"
			location.cityName = "Horb am Neckar"
			location.streetName = "Florianstraße"
			location.houseNumber = "11"
			location.houseNumberAdditional = ""
			location.zipcode = "72160"
			location.latitude = 48.4452168
			location.longitude = 8.6962267
			
			return location
		}()
		
		let host: dHost = {
			let host = dHost()
			
			host.id = "7754fde5-ec70-45b5-72dc-08d403b9007a"
			host.userName = "Markus"
			
			return host
		}()
		
		self.id = "8396e318-a972-40be-3992-08d4081922fd"
		self.name = "Dummy Party!"
		self.price = 0
		self.date = "2016-12-10T20:26:43.624"
		self.musicGenre = 2
		self.type = 1
		self.text = "Super cool description!"
		
		self.location = location
		self.host = host
	}
	
	
}

public class dLocation {
	
	var countryName: String!
	var cityName: String!
	var streetName: String!
	var houseNumber: String!
	var houseNumberAdditional: String!
	var zipcode: String!
	var latitude: Double!
	var longitude: Double!
	
	init() {
		
	}
	
	
}

public class dHost {
	
	var id: String!
	var userName: String!
	
	init() {
		
	}
	
	
}

