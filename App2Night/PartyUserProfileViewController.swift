//
//  PartyUserProfileViewController.swift
//  App2Night
//
//  Created by Robin on 30.11.16.
//  Copyright © 2016 DHBW. All rights reserved.
//

import UIKit
import RealmSwift

class PartyUserProfileViewController: UITableViewController {
	
	let profileCell = BaseCell()
	let radiusCell = BaseCell()
	let logoutCell = BaseCell()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// setup cells
		profileCell.accessoryType = .disclosureIndicator
		profileCell.textLabel?.text = try! Realm().object(ofType: CurrentUser.self, forPrimaryKey: "0")?.username
		
		radiusCell.textLabel?.text = "Radius"
		
		logoutCell.accessoryType = .disclosureIndicator
		logoutCell.textLabel?.text = "Ausloggen"
		
		// setup navigation bar
		navigationItem.title = "Profil"
	}
	
	// MARK: - Table view data
	override func numberOfSections(in tableView: UITableView) -> Int {
		return 3
	}
	
	// set number of rows in section
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		switch (section) {
		case 0: return 1
		case 1: return 1
		case 2: return 1
		default: fatalError("More than 3 sections in tableView")
		}
	}
	
	// set class
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		switch(indexPath.section) {
		case 0:
			switch(indexPath.row) {
			case 0: return self.profileCell
			default: fatalError("More than 1 row in section")
			}
		case 1:
			switch(indexPath.row) {
			case 0: return self.radiusCell
			default: fatalError("More than 1 row in section")
			}
		case 2:
			switch(indexPath.row) {
			case 0: return self.logoutCell
			default: fatalError("More than 1 row in section")
			}
		default: fatalError("More than 3 sections in tableView")
		}
	}
	
	// set height
	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		switch(indexPath.section) {
		case 0:
			switch(indexPath.row) {
			case 0: return 88
			default: fatalError("More than 1 row in section")
			}
		case 1:
			switch(indexPath.row) {
			case 0: return 44
			default: fatalError("More than 1 row in section")
			}
		case 2:
			switch(indexPath.row) {
			case 0: return 44
			default: fatalError("More than 1 row in section")
			}
		default: fatalError("More than 3 sections in tableView")
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
	}
	
	func showLoginController() {
		let loginViewController = LoginViewController()
		
		present(loginViewController, animated: true, completion: {
		})
	}
	
	// set header titles
	/*
	override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
	switch(section) {
	case 0: return "Profile"
	case 1: return "Social"
	default: fatalError("Unknown section")
	}
	}
	*/
	
}

