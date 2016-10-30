//
//  Location.swift
//  App2Night
//
//  Created by Robin on 24.10.16.
//  Copyright © 2016 DHBW. All rights reserved.
//

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
		cityName = pDictionary["cityName"] as? String
		countryName = pDictionary["countryName"] as? String
		houseNumber = pDictionary["houseNumber"] as? Int
		houseNumberAdditional = pDictionary["houseNumberAdditional"] as? String
		latitude = pDictionary["latitude"] as? Int
		longitude = pDictionary["longitude"] as? Int
		streetName = pDictionary["streetName"] as? String
		zipcode = pDictionary["zipcode"] as? Int
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

