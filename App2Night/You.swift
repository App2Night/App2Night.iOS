//
//  CurrentUser.swift
//  App2Night
//
//  Created by Robin on 30.11.16.
//  Copyright © 2016 DHBW. All rights reserved.
//

import UIKit
import RealmSwift
import SwiftyJSON

class You: Object {
	
	dynamic var id: String = "0"
	
	dynamic var username: String = ""
	dynamic var password: String = ""
	
	dynamic var accessToken: String = ""
	dynamic var expiresIn: Date = Date(timeIntervalSince1970: 0)
	dynamic var refreshToken: String = ""
	dynamic var tokenType: String = ""
	
	dynamic var radius: Int = 100
	
	override static func primaryKey() -> String? {
		return "id"
	}
	
	convenience required init(username: String, password: String, json: JSON) {
		self.init()
		
		self.id = "0"
		self.username = username
		self.password = password
		self.accessToken = json["access_token"].stringValue
		self.expiresIn = Date().addingTimeInterval(TimeInterval(json["expires_in"].doubleValue))
		self.refreshToken = json["refresh_token"].stringValue
		self.tokenType = json["token_type"].stringValue
		self.radius = 100
	}
	
}

