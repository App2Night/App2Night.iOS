//
//  Party.swift
//  App2Night
//
//  Created by Robin on 10.11.16.
//  Copyright © 2016 DHBW. All rights reserved.
//

import UIKit
import RealmSwift
import SwiftyJSON

// MARK: Party entity
class Party: Object {
	
	dynamic var id: String = ""
	dynamic var name: String = ""
	dynamic var price: Int = 0
	dynamic var date: Date = Date(timeIntervalSince1970: 0)
	dynamic var musicGenre: Int = 0
	dynamic var type: Int = 0
	dynamic var text: String = ""
	
	dynamic var countryName: String = ""
	dynamic var cityName: String = ""
	dynamic var streetName: String = ""
	dynamic var houseNumber: String = ""
	dynamic var zipcode: String = ""
	dynamic var latitude: Double = 0.0
	dynamic var longitude: Double = 0.0
	
	dynamic var host: User?
	
	dynamic var hostedByUser: Bool = false
	dynamic var generalUpVoting: Int = 0
	dynamic var generalDownVoting: Int = 0
	dynamic var priceUpVoting: Int = 0
	dynamic var priceDownVoting: Int = 0
	dynamic var locationUpVoting: Int = 0
	dynamic var locationDownVoting: Int = 0
	dynamic var moodUpVoting: Int = 0
	dynamic var moodDownVoting: Int = 0
	
	let committedUser = List<User>()
	
	dynamic var userCommitmentState: Int = 2
	
	override static func primaryKey() -> String? {
		return "id"
	}
	
	convenience required init(json: JSON) {
		self.init()
		
		self.id = json["PartyId"].stringValue
		self.name = json["PartyName"].stringValue
		self.price = json["Price"].intValue
		self.date = DateHelper.shared.parseString(with: json["PartyDate"].stringValue)
		self.musicGenre = json["MusicGenre"].intValue
		self.type = json["PartyType"].intValue
		self.text = json["Description"].stringValue
		
		self.countryName = json["Location"]["CountryName"].stringValue
		self.cityName = json["Location"]["CityName"].stringValue
		self.streetName = json["Location"]["StreetName"].stringValue
		self.houseNumber = json["Location"]["HouseNumber"].stringValue
		self.zipcode = json["Location"]["Zipcode"].stringValue
		self.latitude = json["Location"]["Latitude"].doubleValue
		self.longitude = json["Location"]["Longitude"].doubleValue
		
		self.host = User(json: json["Host"])
		
		// ist immer false da get keine userinfo mitschickt?
		self.hostedByUser = json["HostedByUser"].boolValue
		
		/*
		let currentUser = try! Realm().object(ofType: You.self, forPrimaryKey: "0")
		let myId = currentUser?.userId
		
		if self.host?.id == myId {
		self.hostedByUser = true
		} else {
		self.hostedByUser = false
		}
		*/
		
		self.generalUpVoting = json["GeneralUpVoting"].intValue
		self.generalDownVoting = json["GeneralDownVoting"].intValue
		self.priceUpVoting = json["PriceUpVoting"].intValue
		self.priceDownVoting = json["PriceDownVoting"].intValue
		self.locationUpVoting = json["LocationUpVoting"].intValue
		self.locationDownVoting = json["LocationDownVoting"].intValue
		self.moodUpVoting = json["MoodUpVoting"].intValue
		self.moodDownVoting = json["MoodDownVoting"].intValue
		
		for (_, object) in json["CommittedUser"] {
			self.committedUser.append(User(json: object))
		}
		
		self.userCommitmentState = json["UserCommitmentState"].intValue
	}
	
	private func getDate(string: String) -> Date {
		let dateFormatter: DateFormatter = {
			let dateFormatter = DateFormatter()
			dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
			return dateFormatter
		}()
		
		return dateFormatter.date(from: string)!
	}
	
	func toPartyRawData() -> Data {
		let json: JSON = [
			"partyName": self.name,
			"partyDate": DateHelper.shared.getString(from: self.date),
			"musicGenre": self.musicGenre,
			"countryName": self.countryName,
			"cityName": self.cityName,
			"streetName": self.streetName,
			"houseNumber": self.houseNumber,
			"zipcode": self.zipcode,
			"partyType": self.type,
			"description": self.text,
			"price": self.price
		]
		
		return try! json.rawData()
	}
	
	func toLocationRawData() -> Data {
		let json: JSON = [
			"countryName": self.countryName,
			"cityName": self.cityName,
			"streetName": self.streetName,
			"houseNumber": self.houseNumber,
			"zipcode": self.zipcode,
			"latitude": 0.0,
			"longitude": 0.0
		]
		
		return try! json.rawData()
	}
	
}

// MARK: - User entity
class User: Object {
	
	dynamic var id: String = ""
	dynamic var userName: String = ""
	
	override static func primaryKey() -> String? {
		return "id"
	}
	
	convenience required init(json: JSON) {
		self.init()
		
		if (json["HostId"].exists()) {
			self.id = json["HostId"].stringValue
		} else {
			self.id = json["UserId"].stringValue
		}
		
		self.userName = json["UserName"].stringValue
	}
	
}

// MARK: - Date formatter helper
class DateHelper {
	
	// shared instance
	static let shared = DateHelper()
	
	// setup date formatter
	let apiFormatter: DateFormatter = {
		let formatter = DateFormatter()
		formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
		return formatter
	}()
	
	func parseString(with string: String) -> Date {
		return apiFormatter.date(from: string)!
	}
	
	func getString(from date: Date) -> String {
		return apiFormatter.string(from: date)
	}
	
}

