//
//  ViewController.swift
//  App2Night
//
//  Created by Robin on 01.11.16.
//  Copyright © 2016 DHBW. All rights reserved.
//

import UIKit

class LoginController: UIViewController {
	
	var parties: [Party]?
	
	let testUser: User = {
		let testUser = User()
		testUser.setUserName(pUserName: "test")
		testUser.setPassword(pPassword: "test")
		return testUser
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		view.backgroundColor = .white
		
		/*
		SwaggerCommunication.getParties { (parties) in
			self.parties = parties
		}
		
		SwaggerCommunication.retrieveToken(pUser: testUser)
		*/
	}
	
	
}

