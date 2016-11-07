//
//  Party.swift
//  App2Night
//
//  Created by Robin on 24.10.16.
//  Copyright © 2016 DHBW. All rights reserved.
//

/*
import Foundation

public class Party {
	
	private var partyId: String!
	private var price: Int!
	private var partyName: String!
	private var partyDate: String!
	private var musicGenre: MusicGenre!
	private var location: Location!
	private var partyType: PartyType!
	private var descriptionField: String!
	private var host: Host!
	
	// MARK: init empty party object
	init() {
		
	}
	
	// MARK: init from NSDictionary
	init(pDictionary: NSDictionary) {
		partyId = pDictionary["PartId"] as? String
		price = pDictionary["Price"] as? Int
		partyName = pDictionary["PartyName"] as? String
		partyDate = pDictionary["PartyDate"] as? String
		musicGenre = pDictionary["MusicGenre"] as? MusicGenre
		partyType = pDictionary["PartyType"] as? PartyType
		descriptionField = pDictionary["Description"] as? String
	}
	
	// MARK: parse parties in response data
	static public func parseResponse(pResponseData: Any?) -> [Party]? {
		let responseData = pResponseData as! [[String: AnyObject]]
		
		var partiesArray: [Party] = [Party]()
		
		for Dictionary in responseData {
			// root model
			let partyDictionary = Dictionary as NSDictionary
			let party = Party(pDictionary: partyDictionary)
			
			// host model
			let hostDictionary = Dictionary["Host"] as! NSDictionary
			let host = Host(pDictionary: hostDictionary)
			party.setHost(pHost: host)
			
			// location model
			let locationDictionary = Dictionary["Location"] as! NSDictionary
			let location = Location(pDictionary: locationDictionary)
			party.setLocation(pLocation: location)
			
			/*
			// host.location model
			let hostLocationDictionary = Dictionary["Host"]!["Location"] as! NSDictionary
			let hostLocation = Location(pDictionary: hostLocationDictionary)
			party.getHost().setLocation(pLocation: hostLocation)
			*/
			
			// append to array of parties
			partiesArray.append(party)
		}
		print("RETURNED PARSED RESPONSE RESULT VALUE.")
		return partiesArray
	}
	
	// MARK: toDictionary()
	public func toDictionary() -> [String : Any] {
		let dict = [
			"partyName": self.getPartyName(),
			"partyDate": self.getPartyDate(),
			"musicGenre": self.getMusicGenre().rawValue,
			"location": [
				"countryName": self.location.getCountryName(),
				"cityName": self.location.getCityName(),
				"streetName": self.location.getStreetName(),
				"houseNumber": self.location.getHouseNumber(),
				"houseNumberAdditional": self.location.getHouseNumberAdditional(),
				"zipcode": self.location.getZipcode(),
				"latitude": self.location.getLatitude(),
				"longitude": self.location.getLongitude()
			],
			"partyType": self.getPartyType().rawValue,
			"description": self.getDescription()
			] as [String : Any]
		
		return dict
	}
	
	// MARK: GET & SET
	public func getPartyID() -> String {
		return self.partyId
	}
	
	public func setPartyID(pPartyID: String) {
		self.partyId = pPartyID
	}
	
	public func getPrice() -> Int {
		return self.price
	}
	
	public func setPrice(pPrice: Int) {
		self.price = pPrice
	}
	
	public func getHost() -> Host {
		return self.host
	}
	
	public func setHost(pHost: Host) {
		self.host = pHost
	}
	
	public func getPartyName() -> String {
		return self.partyName
	}
	
	public func setPartyName(pPartyName: String) {
		self.partyName = pPartyName
	}
	
	public func getPartyDate() -> String {
		return self.partyDate
	}
	
	public func setPartyDate(pPartyDate: String) {
		self.partyDate = pPartyDate
	}
	
	public func getMusicGenre() -> MusicGenre {
		return self.musicGenre
	}
	
	public func setMusicGenre(pMusicGenre: MusicGenre) {
		self.musicGenre = pMusicGenre
	}
	
	public func getLocation() -> Location {
		return self.location
	}
	
	public func setLocation(pLocation: Location) {
		self.location = pLocation
	}
	
	public func getPartyType() -> PartyType {
		return self.partyType
	}
	
	public func setPartyType(pPartyType: PartyType) {
		self.partyType = pPartyType
	}
	
	public func getDescription() -> String {
		return self.descriptionField
	}
	
	public func setDescription(pDescription: String) {
		self.descriptionField = pDescription
	}
	
	
}
*/

//
//  Host.swift
//  App2Night
//
//  Created by Robin on 24.10.16.
//  Copyright © 2016 DHBW. All rights reserved.
//

/*
import Foundation

public class Host {

private var hostId: String!
private var userName: String!


// MARK: init empty host object
init() {

}

// MARK: init from NSDictionary
init(pDictionary: NSDictionary) {
hostId = pDictionary["HostId"] as? String
userName = pDictionary["UserName"] as? String
}

// MARK: GET & SET
public func getHostID() -> String {
return self.hostId
}

public func setHostID(pHostID: String) {
self.hostId = pHostID
}

public func getUserName() -> String {
return self.userName
}

public func setUserName(pUserName: String) {
self.userName = pUserName
}


}
*/

//
//  Location.swift
//  App2Night
//
//  Created by Robin on 24.10.16.
//  Copyright © 2016 DHBW. All rights reserved.
//

/*
import Foundation

public class Location {

private var countryName: String!
private var cityName: String!
private var streetName: String!
private var houseNumber: Int!
private var houseNumberAdditional: String!
private var zipcode: Int!
private var latitude: Int!
private var longitude: Int!


// MARK: init empty location object
init() {

}

// MARK: init from NSDictionary
init(pDictionary: NSDictionary) {
countryName = pDictionary["CountryName"] as? String
cityName = pDictionary["CityName"] as? String
streetName = pDictionary["StreetName"] as? String
houseNumber = pDictionary["HouseNumber"] as? Int
houseNumberAdditional = pDictionary["HouseNumberAdditional"] as? String
zipcode = pDictionary["Zipcode"] as? Int
latitude = pDictionary["Latitude"] as? Int
longitude = pDictionary["Longitude"] as? Int
}

// MARK: GET & SET
public func getCountryName() -> String {
return self.countryName
}

public func setCountryName(pCountryName: String) {
self.countryName = pCountryName
}

public func getCityName() -> String {
return self.cityName
}

public func setCityName(pCityName: String) {
self.cityName = pCityName
}

public func getStreetName() -> String {
return self.streetName
}

public func setStreetName(pStreetName: String) {
self.streetName = pStreetName
}

public func getHouseNumber() -> Int {
return self.houseNumber
}

public func setHouseNumber(pHouseNumber: Int) {
self.houseNumber = pHouseNumber
}

public func getHouseNumberAdditional() -> String {
return self.houseNumberAdditional
}

public func setHouseNumberAdditional(pHouseNumberAdditional: String) {
self.houseNumberAdditional = pHouseNumberAdditional
}

public func getZipcode() -> Int {
return self.zipcode
}

public func setZipcode(pZipcode: Int) {
self.zipcode = pZipcode
}

public func getLatitude() -> Int {
return self.latitude
}

public func setLatitude(pLatitude: Int) {
self.latitude = pLatitude
}

public func getLongitude() -> Int {
return self.longitude
}

public func setLongitude(pLongitude: Int) {
self.longitude = pLongitude
}


}
*/


//
//  User.swift
//  App2Night
//
//  Created by Robin on 31.10.16.
//  Copyright © 2016 DHBW. All rights reserved.
//

/*
import Foundation

public class User {

private var userId: String!
private var userName: String!
private var password: String!
private var accessToken: String!
private var expiresIn: Int!
private var tokenType: String!
private var refreshToken: String!


// MARK: init empty user object
init() {

}

// MARK: GET & SET
public func getUserID() -> String {
return self.userId
}

public func setUserID(pUserID: String) {
self.userId = pUserID
}

public func getUserName() -> String {
return self.userName
}

public func setUserName(pUserName: String) {
self.userName = pUserName
}

public func getPassword() -> String {
return self.password
}

public func setPassword(pPassword: String) {
self.password = pPassword
}

public func getAccessToken() -> String {
return self.accessToken
}

public func setAccessToken(pAccessToken: String) {
self.accessToken = pAccessToken
}

public func getExpiresIn() -> Int {
return self.expiresIn
}

public func setExpiresIn(pExpiresIn: Int) {
self.expiresIn = pExpiresIn
}

public func getTokenType() -> String {
return self.tokenType
}

public func setTokenType(pTokenType: String) {
self.tokenType = pTokenType
}

public func getRefreshToken() -> String {
return self.refreshToken
}

public func setRefreshToken(pRefreshToken: String) {
self.refreshToken = pRefreshToken
}


}
*/


