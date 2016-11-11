//
//  RealmCommunication.swift
//  App2Night
//
//  Created by Robin on 09.11.16.
//  Copyright © 2016 DHBW. All rights reserved.
//

import Foundation
import RealmSwift
import SwiftyJSON

class RealmCommunication {
	
	static var partiesArray: [Party]?
	
	static func parseParties(json: JSON) {
		let realm = try! Realm()
		
		for (_, object) in json {
			let hostId = object["Host"]["HostId"].stringValue
			let existingHost = doesHostExist(realm: realm, id: hostId)
			
			switch existingHost {
			case true:
				// create objects
				let party = Party()
				let location = Location()
				let host = realm.object(ofType: Host.self, forPrimaryKey: hostId)!
				
				// add object references
				party.location = location
				party.host = host
				
				// set party attributes
				party.id = object["PartyId"].stringValue
				party.name = object["PartyName"].stringValue
				party.price = object["Price"].intValue
				party.date = object["PartyDate"].stringValue
				party.musicGenre = object["MusicGenre"].intValue
				party.type = object["PartyType"].intValue
				party.text = object["Description"].stringValue
				
				// set location attributes
				party.location?.countryName = object["Location"]["CountryName"].stringValue
				party.location?.cityName = object["Location"]["CityName"].stringValue
				party.location?.streetName = object["Location"]["StreetName"].stringValue
				party.location?.houseNumber = object["Location"]["HouseNumber"].stringValue
				party.location?.houseNumberAdditional = object["Location"]["HouseNumberAdditional"].stringValue
				party.location?.zipcode = object["Location"]["Zipcode"].stringValue
				party.location?.latitude = object["Location"]["Latitude"].doubleValue
				party.location?.longitude = object["Location"]["Longitude"].doubleValue
				
				try! realm.write {
					realm.add(party)
					host.parties.append(party)
				}
				
			case false:
				// create objects
				let party = Party()
				let location = Location()
				let host = Host()
				
				// add object references
				party.location = location
				party.host = host
				host.parties.append(party)
				
				// set party attributes
				party.id = object["PartyId"].stringValue
				party.name = object["PartyName"].stringValue
				party.price = object["Price"].intValue
				party.date = object["PartyDate"].stringValue
				party.musicGenre = object["MusicGenre"].intValue
				party.type = object["PartyType"].intValue
				party.text = object["Description"].stringValue
				
				// set location attributes
				party.location?.countryName = object["Location"]["CountryName"].stringValue
				party.location?.cityName = object["Location"]["CityName"].stringValue
				party.location?.streetName = object["Location"]["StreetName"].stringValue
				party.location?.houseNumber = object["Location"]["HouseNumber"].stringValue
				party.location?.houseNumberAdditional = object["Location"]["HouseNumberAdditional"].stringValue
				party.location?.zipcode = object["Location"]["Zipcode"].stringValue
				party.location?.latitude = object["Location"]["Latitude"].doubleValue
				party.location?.longitude = object["Location"]["Longitude"].doubleValue
				
				// set host attributes
				party.host?.id = object["Host"]["HostId"].stringValue
				party.host?.userName = object["Host"]["UserName"].stringValue
				
				try! realm.write {
					realm.add(party)
				}
			}
		}
	}
	
	static func doesHostExist(realm: Realm, id: String) -> Bool {
		let existingHost = realm.object(ofType: Host.self, forPrimaryKey: id)
		
		if (existingHost != nil) {
			return true
		}
		
		return false
	}
	
	static func delete() {
		let realmURL = Realm.Configuration.defaultConfiguration.fileURL!
		let realmURLs = [
			realmURL,
			realmURL.appendingPathExtension("lock"),
			realmURL.appendingPathExtension("log_a"),
			realmURL.appendingPathExtension("log_b"),
			realmURL.appendingPathExtension("note")
		]
		
		for URL in realmURLs {
			do {
				try FileManager.default.removeItem(at: URL)
			} catch let e {
				print(e)
			}
		}
	}
	
	func clear(realm: Realm) {
		try! realm.write {
			realm.deleteAll()
		}
	}
	
	func createDummy() -> Party {
		// create realm objecs
		let party = Party()
		let location = Location()
		let host = Host()
		
		// add object references
		party.location = location
		party.host = host
		host.parties.append(party)
		
		// set party attributes
		party.id = "8396e318-a972-40be-3992-08d4081922fd"
		party.name = "Test test test"
		party.price = 0
		party.date = "2016-12-10T20:26:43.624"
		party.musicGenre = 2
		party.type = 1
		party.text = "This is a party description..."
		
		// set location attributes
		party.location?.countryName = "Germany"
		party.location?.cityName = "Horb am Neckar"
		party.location?.streetName = "Florianstraße"
		party.location?.houseNumber = "11"
		party.location?.houseNumberAdditional = ""
		party.location?.zipcode = "72160"
		party.location?.latitude = 48.4452168
		party.location?.longitude = 8.6962267
		
		// set host attributes
		party.host?.id = "7754fde5-ec70-45b5-72dc-08d403b9007a"
		party.host?.userName = "Markus"
		
		return party
	}
	
	
}

