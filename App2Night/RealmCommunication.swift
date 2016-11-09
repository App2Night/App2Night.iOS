//
//  RealmCommunication.swift
//  App2Night
//
//  Created by Robin on 09.11.16.
//  Copyright © 2016 DHBW. All rights reserved.
//

import Foundation
import RealmSwift

class RealmCommunication {
	
	func deleteRealm(realm: Realm) {
		try! realm.write {
			realm.deleteAll()
			print("DELETED REALM.")
		}
	}
	
	func createDummy() -> Party {
		let party = Party()
		let location = Location()
		let host = Host()
		
		party.location = location
		party.host = host
		location.party = party
		host.parties.append(party)
		
		party.id = "8396e318-a972-40be-3992-08d4081922fd"
		party.name = "Test test test"
		party.price = 0
		party.date = "2016-12-10T20:26:43.624"
		party.musicGenre = 2
		party.type = 1
		party.text = "This is a party description..."
		
		party.location?.countryName = "Germany"
		party.location?.cityName = "Horb am Neckar"
		party.location?.streetName = "Florianstraße"
		party.location?.houseNumber = "11"
		party.location?.houseNumberAdditional = ""
		party.location?.zipcode = "72160"
		party.location?.latitude = 48.4452168
		party.location?.longitude = 8.6962267
		
		party.host?.id = "7754fde5-ec70-45b5-72dc-08d403b9007a"
		party.host?.userName = "Markus"
		
		return party
	}
	
	
}

