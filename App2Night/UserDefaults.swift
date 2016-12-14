//
//  UserDefaults.swift
//  App2Night
//
//  Created by Robin on 27.11.16.
//  Copyright © 2016 DHBW. All rights reserved.
//

import Foundation

// extension for UserDefaults to easily fetch/set login status
extension UserDefaults {
	
	enum UserDefaultsKeys: String {
		case IsLoggedIn
	}
	
	func setIsLoggedIn(value bool: Bool) {
		set(bool, forKey: UserDefaultsKeys.IsLoggedIn.rawValue)
		synchronize()
	}
	
	func isLoggedIn() -> Bool {
		return bool(forKey: UserDefaultsKeys.IsLoggedIn.rawValue)
	}
	
}

