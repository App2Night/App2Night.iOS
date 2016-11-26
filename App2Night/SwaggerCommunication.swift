//
//  SwaggerCommunication.swift
//  App2Night
//
//  Created by Robin on 07.11.16.
//  Copyright © 2016 DHBW. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class SwaggerCommunication {
	
	// shared instance
	static let shared = SwaggerCommunication()
	
	// backend urls
	private static let apiUrl = "https://app2nightapi.azurewebsites.net/"
	private static let userUrl = "https://app2nightuser.azurewebsites.net/"
	
	// userdefaults
	private static let defaults = UserDefaults.standard
	
	
	func getParties(completionHandler: @escaping (Bool) -> ()) {		
		let coordinates: Parameters = [
			"lat": PositionManager.shared.currentLocation.coordinate.latitude,
			"lon": PositionManager.shared.currentLocation.coordinate.longitude,
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
	
	func postParty(completionHandler: @escaping (Bool) -> ()) {
		
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
		
		let partyData = try! partyJson.rawData()
		
		let requestUrl: URLRequest = {
			var request = URLRequest(url: URL(string: SwaggerCommunication.apiUrl + "api/party")!)
			request.httpMethod = "POST"
			request.setValue("application/json", forHTTPHeaderField: "Content-Type")
			request.setValue("\(SwaggerCommunication.defaults.string(forKey: "token_type")) \(SwaggerCommunication.defaults.string(forKey: "access_token"))", forHTTPHeaderField: "Authorization")
			request.httpBody = partyData
			
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
				DispatchQueue.main.async(execute: { () -> Void in
					let json = JSON(response.result.value!)
					
					// replace with keychain later..
					SwaggerCommunication.defaults.set(username, forKey: "username")
					SwaggerCommunication.defaults.set(password, forKey: "password")
					SwaggerCommunication.defaults.set(json["access_token"].stringValue, forKey: "access_token")
					SwaggerCommunication.defaults.set(json["expires_in"].intValue, forKey: "expires_in")
					SwaggerCommunication.defaults.set(json["refresh_token"].stringValue, forKey: "refresh_token")
					SwaggerCommunication.defaults.set(json["token_type"].stringValue, forKey: "token_type")
					
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

