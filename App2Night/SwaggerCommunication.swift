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
		// get user radius settings
		let currentUser = try! Realm().object(ofType: You.self, forPrimaryKey: "0")
		let radius = currentUser?.radius
		var radiusValue: Int
		
		if (radius != nil) {
			radiusValue = radius!
		} else {
			radiusValue = 100
		}
		
		let coordinates: Parameters = [
			"lat": location.latitude,
			"lon": location.longitude,
			"radius": radiusValue
		]
		
		Alamofire.request(SwaggerCommunication.apiUrl + "api/party", method: .get, parameters: coordinates).validate().responseJSON { (response) in
			print("REQUEST URL: \(response.request)")
			print("HTTP URL RESPONSE: \(response.response)")
			print("SERVER DATA: \(response.data)")
			print("RESULT OF SERIALIZATION: \(response.result)")
			
			switch response.result {
			case .success:
				DispatchQueue.main.async(execute: { () -> Void in
					
					// prepare comparision
					let responseValue = JSON(response.result.value!)
					let parties = try! Realm().objects(Party.self)
					let users = try! Realm().objects(User.self)
					
					try! RealmManager.currentRealm.write {
						RealmManager.currentRealm.delete(parties)
						RealmManager.currentRealm.delete(users)
					}
					
					for (_, object) in responseValue {
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
	
	func postParty(with party: Data, completionHandler: @escaping (Bool) -> ()) {
		let currentUser = try! Realm().object(ofType: You.self, forPrimaryKey: "0")
		
		let tokenType = (currentUser?.tokenType)!
		let accessToken = (currentUser?.accessToken)!
		
		let requestUrl: URLRequest = {
			var request = URLRequest(url: URL(string: SwaggerCommunication.apiUrl + "api/party")!)
			request.httpMethod = "POST"
			request.setValue("application/json", forHTTPHeaderField: "Content-Type")
			request.setValue("\(tokenType) \(accessToken)", forHTTPHeaderField: "Authorization")
			request.httpBody = party
			
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
				let currentUser = You(username: username, password: password, json: JSON(response.result.value!))
				
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
	
	func postUser(username: String, email: String, password: String, completionHandler: @escaping (Bool) -> ()) {
		let userPayload: JSON = [
			"username": username,
			"password": password,
			"email": email
		]
		
		let requestUrl: URLRequest = {
			var request = URLRequest(url: URL(string: SwaggerCommunication.userUrl + "api/user")!)
			request.httpMethod = "POST"
			request.setValue("application/json", forHTTPHeaderField: "Content-Type")
			request.httpBody = try! userPayload.rawData()
			
			return request
		}()
		
		Alamofire.request(requestUrl).validate().responseData { (response) in
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
	
	func validateLocation(with locationData: Data, completionHandler: @escaping (Bool) -> ()) {
		let currentUser = try! Realm().object(ofType: You.self, forPrimaryKey: "0")
		
		let tokenType = (currentUser?.tokenType)!
		let accessToken = (currentUser?.accessToken)!
		
		let requestUrl: URLRequest = {
			var request = URLRequest(url: URL(string: SwaggerCommunication.apiUrl + "api/party/validate")!)
			request.httpMethod = "POST"
			request.setValue("application/json", forHTTPHeaderField: "Content-Type")
			request.setValue("\(tokenType) \(accessToken)", forHTTPHeaderField: "Authorization")
			request.httpBody = locationData
			
			return request
		}()
		
		Alamofire.request(requestUrl).validate().responseData { (response) in
			print("REQUEST URL: \(response.request)")
			print("HTTP URL RESPONSE: \(response.response)")
			print("SERVER DATA: \(response.data)")
			print("RESULT OF SERIALIZATION: \(response.result)")
			
			switch response.result {
			case .success:
				print(response.result.value!)
				
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

