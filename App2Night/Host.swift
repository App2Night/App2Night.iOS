//
//  Host.swift
//  App2Night
//
//  Created by Robin on 10.11.16.
//  Copyright © 2016 DHBW. All rights reserved.
//

import Foundation
import RealmSwift

class Host: Object {
	
	dynamic var id: String = ""
	dynamic var userName: String = ""
	
	let parties = List<Party>()
	
	override static func primaryKey() -> String? {
		return "id"
	}
	
	
}

