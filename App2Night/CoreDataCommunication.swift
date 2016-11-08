//
//  CoreDataCommunication.swift
//  App2Night
//
//  Created by Robin on 07.11.16.
//  Copyright © 2016 DHBW. All rights reserved.
//

import UIKit
import CoreData

class CoreDataCommunication {
	
	// get local dummy parties
	func getDummyParties() -> [[String: Any]] {
		let dummyParties = [
			[
				"PartyId": "11111111-1111-1111-1111-111111111111",
				"Price": 3,
				"PartyName": "Robin's Party",
				"PartyDate": "2017-07-07T17:00:00.000",
				"MusicGenre": 0,
				"Location": [
					"CountryName": "Germany",
					"CityName": "Stuttgart",
					"StreetName": "Florianstraße",
					"HouseNumber": "12",
					"HouseNumberAdditional": "",
					"Zipcode": "70188",
					"Latitude": 48.7849762,
					"Longitude": 9.2065099
				],
				"PartyType": 2,
				"Description": "Applepen? Pineapplepen!",
				"Host": [
					"HostId": "RRRRRRRR-RRRR-RRRR-RRRR-RRRRRRRRRRRR",
					"UserName": "Robin"
				]
			],
			[
				"PartyId": "22222222-2222-2222-2222-222222222222",
				"Price": 12,
				"PartyName": "Tobi's Fete",
				"PartyDate": "2017-08-08T18:00:00.000",
				"MusicGenre": 5,
				"Location": [
					"CountryName": "Germany",
					"CityName": "Stuttgart",
					"StreetName": "Florianstraße",
					"HouseNumber": "12",
					"HouseNumberAdditional": "",
					"Zipcode": "70188",
					"Latitude": 48.7849762,
					"Longitude": 9.2065099
				],
				"PartyType": 2,
				"Description": "Viel Alkohol!",
				"Host": [
					"HostId": "TTTTTTTT-TTTT-TTTT-TTTT-TTTTTTTTTTTT",
					"UserName": "Tobias"
				]
			]
		] as [[String: Any]]
		
		return dummyParties
	}
	
	/*
	// format date
	func formatDate(any: Any?) -> Date {
		let formatter : DateFormatter = {
			let dateFormatter = DateFormatter()
			dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
			return dateFormatter
		}()
		
		return formatter.date(from: String(describing: any))!
	}
	*/
	
}

