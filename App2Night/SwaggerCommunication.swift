//
//  SwaggerCommunication.swift
//  App2Night
//
//  Created by Robin on 22.10.16.
//  Copyright © 2016 DHBW. All rights reserved.
//

import Foundation
import Alamofire

public class SwaggerCommunication {
	
	// MARK: Variables
	private static var parties: [Party] = [Party]()
	private static var user: User = User()
	
	// MARK: Alamofire requests
	public static func getParty(completionHandler: @escaping ([Party]) -> ()) {
		Alamofire.request(Properties.partyUrl, method: .get).validate().responseJSON { response in
			// debug messages from response - some are downcasted to any because of warnings xcode 8.1
			debugPrint(response.request as Any)    // original URL request
			debugPrint(response.response as Any)   // HTTP URL response
			debugPrint(response.data as Any)   // server data
			debugPrint(response.result) // result of response serialization
			debugPrint(response.result.value as Any)   // value of the response result
			
			// switch case success/failure of request
			switch response.result {
			case .success:
				debugPrint("Validation Successful")
				parseParty(pResponseData: response.result.value)
			// printArray()
			case .failure(let error):
				debugPrint(error)
			}
			
			DispatchQueue.main.async(execute: { () -> Void in
				completionHandler(self.parties)
			})
			
			}.resume()
	}
	
	/*
	initialize empty party array in class:
	var partiesArray: [Party]?
	
	call function with trailing closure and assign returned parties array to class variable:
	SwaggerCommunication.getParty { (parties) in
	self.partiesArray = parties
	self.PartyTableView.reloadData()
	}
	*/
	
	public static func postParty(pDictionary: [String: Any]) {
		// post request
		var postUrl = URLRequest(url: URL(string: Properties.partyUrl)!)
		postUrl.httpMethod = "POST"
		postUrl.setValue("application/json", forHTTPHeaderField: "Content-Type")
		
		// try json serialization
		postUrl.httpBody = try! JSONSerialization.data(withJSONObject: pDictionary)
		
		Alamofire.request(postUrl).validate().responseJSON { response in
			// debug messages from response - some are downcasted to any because of warnings xcode 8.1
			debugPrint(response.request as Any)    // original URL request
			debugPrint(response.response as Any)   // HTTP URL response
			debugPrint(response.data as Any)   // server data
			debugPrint(response.result) // result of response serialization
			debugPrint(response.result.value as Any)   // value of the response result
			
			// switch case success/failure of request
			switch response.result {
			case .success:
				debugPrint("Validation Successful")
			case .failure(let error):
				debugPrint(error)
				if let responseData = response.data, let responseString = String(data: responseData, encoding: .utf8) {
					print(responseString)
				}
			}
		}
	}
	
	public static func postToken() {
		// post request
		var postUrl = URLRequest(url: URL(string: Properties.tokenUrl)!)
		postUrl.httpMethod = "POST"
		postUrl.setValue("application/json", forHTTPHeaderField: "Content-Type")
		
		// token json
		let tokenDictionary = [
			"client_id": "nativeApp",
			"client_secret": "secret",
			"grant_type": "password",
			"username": "iosuser",
			"password": "applerulez",
			"scope": "App2NightAPI offline_access",
			"offline_access": "true"
			] as [String : Any]
		
		// try json serialization
		postUrl.httpBody = try! JSONSerialization.data(withJSONObject: tokenDictionary)
		
		Alamofire.request(postUrl).validate().responseJSON { response in
			// debug messages from response - some are downcasted to any because of warnings xcode 8.1
			debugPrint(response.request as Any)    // original URL request
			debugPrint(response.response as Any)   // HTTP URL response
			debugPrint(response.data as Any)   // server data
			debugPrint(response.result) // result of response serialization
			debugPrint(response.result.value as Any)   // value of the response result
			
			// switch case success/failure of request
			switch response.result {
			case .success:
				debugPrint("Validation Successful")
				parseToken(pResponseData: response.result.value)
			case .failure(let error):
				debugPrint(error)
				if let responseData = response.data, let responseString = String(data: responseData, encoding: .utf8) {
					print(responseString)
				}
			}
		}
	}
	
	// MARK: Parse response
	private static func parseParty(pResponseData: Any?) {
		let responseData = pResponseData as! [[String: AnyObject]]
		
		for Dictionary in responseData {
			// root model
			let partyDictionary = Dictionary as NSDictionary
			let party = Party(pDictionary: partyDictionary)
			
			// host model
			let hostDictionary = Dictionary["Host"] as! NSDictionary
			let host = Host(pDictionary: hostDictionary)
			party.setHost(pHost: host)
			
			/*
			// host.location model
			let hostLocationDictionary = Dictionary["Host"]!["Location"] as! NSDictionary
			let hostLocation = Location(pDictionary: hostLocationDictionary)
			party.getHost().setLocation(pLocation: hostLocation)
			*/
			
			// location model
			let locationDictionary = Dictionary["Location"] as! NSDictionary
			let location = Location(pDictionary: locationDictionary)
			party.setLocation(pLocation: location)
			
			// append to array of parties
			self.parties.append(party)
		}
		
		debugPrint("Parsed response data.")
	}
	
	private static func parseToken(pResponseData: Any?) {
		let responseData = pResponseData as! [String: AnyObject]
		
		user.setAccessToken(pAccessToken: responseData["access_token"] as! String)
		user.setExpiresIn(pExpiresIn: responseData["expires_in"] as! Int)
		user.setTokenType(pTokenType: responseData["token_type"] as! String)
		user.setRefreshToken(pRefreshToken: responseData["refresh_token"] as! String)
		
		debugPrint("Parsed response data.")
	}
	
	// MARK: Debug functions
	public static func printArray() {
		debugPrint("Printing array content..")
		for Party in self.parties {
			let partyVariable = Party.getPartyName()
			debugPrint(partyVariable)
		}
	}
	
	public static func postTestParty() {
		let testParty = Party()
		let testLocation = Location()
		testParty.setLocation(pLocation: testLocation)
		testParty.setPartyName(pPartyName: "iOS dummy party")
		testParty.setPartyDate(pPartyDate: "2016-12-24T20:00:00.000Z")
		testParty.setMusicGenre(pMusicGenre: MusicGenre.Mixed)
		testParty.setPartyType(pPartyType: PartyType.Venue)
		testParty.setDescription(pDescription: "string")
		testLocation.setCountryName(pCountryName: "string")
		testLocation.setCityName(pCityName: "string")
		testLocation.setStreetName(pStreetName: "string")
		testLocation.setHouseNumber(pHouseNumber: 0)
		testLocation.setHouseNumberAdditional(pHouseNumberAdditional: "string")
		testLocation.setZipcode(pZipcode: 0)
		testLocation.setLatitude(pLatitude: 0)
		testLocation.setLongitude(pLongitude: 0)
		
		postParty(pDictionary: testParty.toDictionary())
	}
	
}

