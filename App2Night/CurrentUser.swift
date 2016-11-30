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

class CurrentUser: Object {
	
	dynamic var id: String = "0"
	
	dynamic var username: String = ""
	dynamic var password: String = ""
	
	dynamic var accessToken: String = ""
	dynamic var expiresIn: Int = 0
	dynamic var refreshToken: String = ""
	dynamic var tokenType: String = ""
	
	
	override static func primaryKey() -> String? {
		return "id"
	}
	
	convenience required init(username: String, password: String, json: JSON) {
		self.init()
		
		self.username = username
		self.password = password
		self.accessToken = json["access_token"].stringValue
		self.expiresIn = json["expires_in"].intValue
		self.refreshToken = json["refresh_token"].stringValue
		self.tokenType = json["token_type"].stringValue
	}
	
}

