//
//  SwaggerCommunication.swift
//  App2Night
//
//  Created by Robin on 07.11.16.
//  Copyright © 2016 DHBW. All rights reserved.
//

import Foundation
import Alamofire
import RealmSwift
import SwiftyJSON

class SwaggerCommunication {
	
	// http request (get) parties from swagger
	static func getParties(completionHandler: @escaping (Results<Party>) -> ()) {
		Alamofire.request(Properties.partyUrl, method: .get).validate().responseJSON { (response) in
			print("REQUEST URL: \(response.request as Any)")
			print("HTTP URL RESPONSE: \(response.response as Any)")
			print("SERVER DATA: \(response.data as Any)")
			print("RESULT OF SERIALIZATION: \(response.result as Any)")
			
			switch response.result {
			case .success:
				RealmCommunication.parseParties(json: JSON(response.result.value!))
				DispatchQueue.main.async(execute: { () -> Void in
					completionHandler(try! Realm().objects(Party.self))
				})
			case .failure(let e):
				print(e)
			}
		}.resume()
	}
	
	
}

