//
//  SwaggerCommunication.swift
//  App2Night
//
//  Created by Robin on 07.11.16.
//  Copyright © 2016 DHBW. All rights reserved.
//

import Foundation
import Alamofire

class SwaggerCommunication {
	
	static func getParties() {
		Alamofire.request(Properties.partyUrl, method: .get).validate().responseJSON { (response) in
			print("REQUEST URL:\n\(response.request as Any)")
			print("HTTP URL RESPONSE:\n\(response.response as Any)")
			print("SERVER DATA (BYTES):\n\(response.data as Any)")
			print("RESULT OF SERIALIZATION:\n\(response.result as Any)")
			print("VALUE OF THE RESULT:\n\(response.result.value as Any)")
			switch response.result {
			case .success:
				print("SERIALIZATION SUCCESS.")
			case .failure(let e):
				print("SERIALIZATION FAILED:\n\(e)")
			}
		}
	}
	
	
}

/*
public static func getParties(completionHandler: @escaping ([Party]?) -> ()) {
	Alamofire.request(Properties.partyUrl, method: .get).validate().responseJSON { (response) in
		// print response data
		print("***START ALAMOFIRE REQUEST***")
		print("REQUEST URL:\n\(response.request as Any)")
		print("HTTP URL RESPONSE:\n\(response.response as Any)")
		print("SERVER DATA (BYTES):\n\(response.data as Any)")
		print("RESULT OF SERIALIZATION:\n\(response.result as Any)")
		print("VALUE OF THE RESULT:\n\(response.result.value as Any)")
		
		// switch based on serialization result
		switch response.result {
		case .success:
			print("SERIALIZATION SUCCESS.")
			DispatchQueue.main.async(execute: { () -> Void in
				completionHandler(Party.parseResponse(pResponseData: response.result.value))
			})
		case .failure(let error):
			print("SERIALIZATION FAILED.")
			print(error)
		}
		}.resume()
}

public static func retrieveToken(pUser: User) {
	var request = URLRequest(url: URL(string: Properties.tokenUrl)!)
	request.httpMethod = "POST"
	request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
	let requestString = "client_id=nativeApp&" + "client_secret=secret&" + "grant_type=password&" + "username=" + pUser.getUserName() + "&" + "password=" + pUser.getPassword() + "&" + "scope=App2NightAPI offline_access&" + "offline_access=true"
	let requestData: Data = (requestString as NSString).data(using: String.Encoding.utf8.rawValue)!
	request.httpBody = requestData
	
	Alamofire.request(request).validate().responseJSON { (response) in
		// print response data
		print("***START ALAMOFIRE REQUEST***")
		print("REQUEST URL:\n\(response.request as Any)")
		print("HTTP URL RESPONSE:\n\(response.response as Any)")
		print("SERVER DATA (BYTES):\n\(response.data as Any)")
		print("RESULT OF SERIALIZATION:\n\(response.result as Any)")
		print("VALUE OF THE RESULT:\n\(response.result.value as Any)")
		
		// switch based on serialization result
		switch response.result {
		case .success:
			print("SERIALIZATION SUCCESS.")
		case .failure(let error):
			print("SERIALIZATION FAILED.")
			print(error)
		}
	}
}

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

public static func postToken(pUsername: String, pPassword: String) {
	// post request
	var postUrl = URLRequest(url: URL(string: Properties.tokenUrl)!)
	postUrl.httpMethod = "POST"
	postUrl.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
	
	// token body data
	let tokenString = "client_id=nativeApp&" + "client_secret=secret&" + "grant_type=password&" + "username=" + pUsername + "&" + "password=" + pPassword + "&" + "scope=App2NightAPI offline_access&" + "offline_access=true"
	let tokenData: Data = (tokenString as NSString).data(using: String.Encoding.utf8.rawValue)!
	
	postUrl.httpBody = tokenData
	
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
*/

