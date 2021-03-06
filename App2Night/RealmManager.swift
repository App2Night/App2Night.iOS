//
//  RealmManager.swift
//  App2Night
//
//  Created by Robin Niebergall on 09.11.16.
//  Copyright © 2016 DHBW. All rights reserved.
//

import UIKit
import RealmSwift
import SwiftyJSON

// 'singleton' for common realm functions/information
class RealmManager {
	
	// shared instance
	static let shared = RealmManager()
	
	// current realm object
	static let currentRealm = try! Realm()
	
	func reset() {
		let realmUrl = Realm.Configuration.defaultConfiguration.fileURL!
		let realmUrls = [
			realmUrl,
			realmUrl.appendingPathExtension("lock"),
			realmUrl.appendingPathExtension("log_a"),
			realmUrl.appendingPathExtension("log_b"),
			realmUrl.appendingPathExtension("note")
		]
		
		for url in realmUrls {
			do {
				try FileManager.default.removeItem(at: url)
			} catch let e {
				print(e)
			}
		}
	}
	
	func clear() {
		let parties = try! Realm().objects(Party.self)
		let users = try! Realm().objects(User.self)
		
		try! RealmManager.currentRealm.write {
			RealmManager.currentRealm.delete(parties)
			RealmManager.currentRealm.delete(users)
		}
	}
	
	func clearAll() {
		try! RealmManager.currentRealm.write {
			RealmManager.currentRealm.deleteAll()
		}
	}
	
	static func printUrl() {
		print("REALM URL: \(Realm.Configuration.defaultConfiguration.fileURL!)")
	}
	
}

