//
//  PartyUserProfileViewController.swift
//  App2Night
//
//  Created by Robin on 30.11.16.
//  Copyright © 2016 DHBW. All rights reserved.
//

import UIKit
import RealmSwift

// settings page
class PartyUserProfileViewController: UITableViewController {
	
	let profileCell = ProfileCell()
	let radiusCell = RadiusCell()
	let logoutCell = BaseCell()
	
	let error = "Switch case failed in tableView!"
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// setup cells
		profileCell.user.text = try! Realm().object(ofType: You.self, forPrimaryKey: "0")?.username ?? "Username"
		profileCell.email.text = try! Realm().object(ofType: You.self, forPrimaryKey: "0")?.email ?? "Email"
		profileCell.isUserInteractionEnabled = false
		
		// configure basecell
		logoutCell.accessoryType = .disclosureIndicator
		logoutCell.textLabel?.text = "Ausloggen"
		
		// setup navigation bar
		navigationItem.title = "Profil"
	}
	
	// fix for empty username/email after first creation
	override func viewWillAppear(_ animated: Bool) {
		profileCell.user.text = try! Realm().object(ofType: You.self, forPrimaryKey: "0")?.username ?? "Username"
		profileCell.email.text = try! Realm().object(ofType: You.self, forPrimaryKey: "0")?.email ?? "Email"
		tableView.reloadData()
	}
	
	// the moment the view disappears save the settings to realm
	override func viewWillDisappear(_ animated: Bool) {
		try! RealmManager.currentRealm.write {
			RealmManager.currentRealm.create(You.self, value: ["id": "0", "radius": Int(radiusCell.slider.value)], update: true)
		}
	}
	
	// table view data
	override func numberOfSections(in tableView: UITableView) -> Int {
		return 3
	}
	
	// set number of rows in section
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		switch (section) {
		case 0: return 1
		case 1: return 1
		case 2: return 1
		default: fatalError(error)
		}
	}
	
	// set class
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		switch(indexPath.section) {
		case 0:
			switch(indexPath.row) {
			case 0: return self.profileCell
			default: fatalError(error)
			}
		case 1:
			switch(indexPath.row) {
			case 0: return self.radiusCell
			default: fatalError(error)
			}
		case 2:
			switch(indexPath.row) {
			case 0: return self.logoutCell
			default: fatalError(error)
			}
		default: fatalError(error)
		}
	}
	
	// set height
	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		switch(indexPath.section) {
		case 0:
			switch(indexPath.row) {
			case 0: return 90
			default: fatalError(error)
			}
		case 1:
			switch(indexPath.row) {
			case 0: return 80
			default: fatalError(error)
			}
		case 2:
			switch(indexPath.row) {
			case 0: return 50
			default: fatalError(error)
			}
		default: fatalError(error)
		}
	}
	
	// handle tap
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if (indexPath.section == 2) {
			if(indexPath.row == 0) {
				handleLogOut()
			}
		}
	}
	
	// logout
	func handleLogOut() {
		UserDefaults.standard.setIsLoggedIn(value: false)
		perform(#selector(showLoginController), with: nil, afterDelay: 0.01)
		RealmManager.shared.clearAll()
	}
	
	// crete new login controller and present
	func showLoginController() {
		let loginViewController = LoginViewController()
		
		present(loginViewController, animated: true, completion: {
		})
	}
	
	// set header titles
	override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		switch(section) {
		case 0: return "Account"
		case 1: return "Einstellungen"
		case 2: return ""
		default: fatalError(error)
		}
	}
	
	
}

