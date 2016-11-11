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
	dynamic var date: String = ""
	dynamic var musicGenre: Int = 0
	dynamic var type: Int = 0
	dynamic var text: String = ""
	
	dynamic var location: Location?
	dynamic var host: Host?
	
	override static func primaryKey() -> String? {
		return "id"
	}
	
	
}

