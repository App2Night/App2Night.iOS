//
//  Party.swift
//  App2Night
//
//  Created by Robin on 24.10.16.
//  Copyright © 2016 DHBW. All rights reserved.
//

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

