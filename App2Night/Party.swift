//
//  Party.swift
//  App2Night
//
//  Created by Robin on 10.11.16.
//  Copyright © 2016 DHBW. All rights reserved.
//

import Foundation
import RealmSwift

class Party: Object {
	
	dynamic var id: String = ""
	dynamic var name: String = ""
	dynamic var price: Int = 0
	dynamic var date: Date = Date(timeIntervalSince1970: 0)
	dynamic var musicGenre: Int = 0
	dynamic var type: Int = 0
	dynamic var text: String = ""
	
	dynamic var location: Location?
	dynamic var host: Host?
	
	dynamic var hostedByUser: Bool = false
	dynamic var generalUpVoting: Int = 0
	dynamic var generalDownVoting: Int = 0
	dynamic var priceUpVotring: Int = 0
	dynamic var priceDownVoting: Int = 0
	dynamic var locationUpVoting: Int = 0
	dynamic var locationDownVoting: Int = 0
	dynamic var moodUpVoting: Int = 0
	dynamic var moodDownVoting: Int = 0
	
	// TODO: committedUser
	
	override static func primaryKey() -> String? {
		return "id"
	}
	
	
}

