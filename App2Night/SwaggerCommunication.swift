//
//  SwaggerCommunication.swift
//  App2Night
//
//  Created by Robin on 07.11.16.
//  Copyright © 2016 DHBW. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class SwaggerCommunication {
	
	// http request (get) parties from swagger and parse them
	static func getParties(completionHandler: @escaping (Bool) -> ()) {
		let location: Parameters = [
			"lat": "48.442078",
			"lon": "8.684851",
			"radius": "200"
		]
		
		Alamofire.request(Properties.partyUrl, method: .get, parameters: location).validate().responseJSON { (response) in
			print("REQUEST URL: \(response.request)")
			print("HTTP URL RESPONSE: \(response.response)")
			print("SERVER DATA: \(response.data)")
			print("RESULT OF SERIALIZATION: \(response.result)")
			
			switch response.result {
			case .success:
				RealmCommunication.parseParties(json: JSON(response.result.value!))
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
	
	// http post to get user token data with username and password
	static func requestToken(username: String, password: String, completionHandler: @escaping (Bool) -> ()) {
		let requestUrl: URLRequest = {
			var request = URLRequest(url: URL(string: Properties.tokenUrl)!)
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
					print(response.result.value!)
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

