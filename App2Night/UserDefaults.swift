//
//  UserDefaults.swift
//  App2Night
//
//  Created by Robin on 27.11.16.
//  Copyright © 2016 DHBW. All rights reserved.
//

import Foundation

extension UserDefaults {
	
	enum UserDefaultsKeys: String {
		case IsLoggedIn
	}
	
	
	func setIsLoggedIn(bool: Bool) {
		set(bool, forKey: UserDefaultsKeys.IsLoggedIn.rawValue)
		synchronize()
	}
	
	func isLoggedIn() -> Bool {
		return bool(forKey: UserDefaultsKeys.IsLoggedIn.rawValue)
	}
	
}

