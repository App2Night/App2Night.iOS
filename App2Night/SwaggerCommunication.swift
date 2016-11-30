//
//  SwaggerCommunication.swift
//  App2Night
//
//  Created by Robin on 07.11.16.
//  Copyright © 2016 DHBW. All rights reserved.
//

import UIKit
import MapKit
import Alamofire
import SwiftyJSON
import RealmSwift

class SwaggerCommunication {
	
	// shared instance
	static let shared = SwaggerCommunication()
	
	// backend urls
	private static let apiUrl = "https://app2nightapi.azurewebsites.net/"
	private static let userUrl = "https://app2nightuser.azurewebsites.net/"
	
	
	func getParties(at location: CLLocationCoordinate2D, completionHandler: @escaping (Bool) -> ()) {
		let coordinates: Parameters = [
			"lat": location.latitude,
			"lon": location.longitude,
			"radius": "200"
		]
		
		Alamofire.request(SwaggerCommunication.apiUrl + "api/party", method: .get, parameters: coordinates).validate().responseJSON { (response) in
			print("REQUEST URL: \(response.request)")
			print("HTTP URL RESPONSE: \(response.response)")
			print("SERVER DATA: \(response.data)")
			print("RESULT OF SERIALIZATION: \(response.result)")
			
			switch response.result {
			case .success:
				DispatchQueue.main.async(execute: { () -> Void in
					for (_, object) in JSON(response.result.value!) {
						let party = Party(json: object)
						
						try! RealmManager.currentRealm.write {
							RealmManager.currentRealm.add(party, update: true)
						}
					}
					
					RealmManager.printUrl()
					
					completionHandler(true)
				})
			case .failure(let e):
				print(e)
				
				DispatchQueue.main.async(execute: { () -> Void in
					completionHandler(false)
				})
			}
			}.resume()
	}
	
	func postParty(with party: JSON, completionHandler: @escaping (Bool) -> ()) {
		/*
		let partyJson: JSON = [
		"partyName": "iOS Party 2",
		"partyDate": "2016-12-24T12:00:00.000Z",
		"musicGenre": 0,
		"countryName": "Germany",
		"cityName": "Horb am Neckar",
		"streetName": "Florianstraße",
		"houseNumber": "12",
		"zipcode": "72160",
		"partyType": 0,
		"description": "iOS Description"
		]
		*/
		
		let currentUser = try! Realm().object(ofType: CurrentUser.self, forPrimaryKey: "0")
		
		let requestUrl: URLRequest = {
			var request = URLRequest(url: URL(string: SwaggerCommunication.apiUrl + "api/party")!)
			request.httpMethod = "POST"
			request.setValue("application/json", forHTTPHeaderField: "Content-Type")
			request.setValue("\(currentUser?.tokenType) \(currentUser?.accessToken)", forHTTPHeaderField: "Authorization")
			request.httpBody = try! party.rawData()
			
			return request
		}()
		
		Alamofire.request(requestUrl).validate().responseJSON { (response) in
			print("REQUEST URL: \(response.request)")
			print("HTTP URL RESPONSE: \(response.response)")
			print("SERVER DATA: \(response.data)")
			print("RESULT OF SERIALIZATION: \(response.result)")
			
			switch response.result {
			case .success:
				DispatchQueue.main.async(execute: { () -> Void in
					completionHandler(true)
				})
			case .failure(let e):
				print(e)
				DispatchQueue.main.async(execute: { () -> Void in
					completionHandler(false)
				})
			}
			}.resume()
	}
	
	func getToken(username: String, password: String, completionHandler: @escaping (Bool) -> ()) {
		let requestUrl: URLRequest = {
			var request = URLRequest(url: URL(string: SwaggerCommunication.userUrl + "connect/token")!)
			request.httpMethod = "POST"
			request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
			
			let tokenString = "client_id=nativeApp&" + "client_secret=secret&" + "grant_type=password&" + "username=" + username + "&" + "password=" + password + "&" + "scope=App2NightAPI offline_access openid email&"
			let tokenData: Data = (tokenString as NSString).data(using: String.Encoding.utf8.rawValue)!
			
			request.httpBody = tokenData
			
			return request
		}()
		
		Alamofire.request(requestUrl).validate().responseJSON { (response) in
			print("REQUEST URL: \(response.request)")
			print("HTTP URL RESPONSE: \(response.response)")
			print("SERVER DATA: \(response.data)")
			print("RESULT OF SERIALIZATION: \(response.result)")
			
			switch response.result {
			case .success:
				// create current user
				let currentUser = CurrentUser(username: username, password: password, json: JSON(response.result.value!))
				
				try! RealmManager.currentRealm.write {
					RealmManager.currentRealm.add(currentUser, update: true)
				}
				
				DispatchQueue.main.async(execute: { () -> Void in
					completionHandler(true)
				})
			case .failure(let e):
				print(e)
				
				DispatchQueue.main.async(execute: { () -> Void in
					completionHandler(false)
				})
			}
			}.resume()
	}
	
}

