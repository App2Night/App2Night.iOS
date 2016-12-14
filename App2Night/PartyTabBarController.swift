//
//  PartyTabBarController.swift
//  App2Night
//
//  Created by Robin on 28.11.16.
//  Copyright © 2016 DHBW. All rights reserved.
//

import UIKit

// root tab bar controller of the app
class PartyTabBarController: UITabBarController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// check login status
		if !isLoggedIn() {
			perform(#selector(showLoginController), with: nil, afterDelay: 0.01)
		}
	}
	
	fileprivate func isLoggedIn() -> Bool {
		return UserDefaults.standard.isLoggedIn()
	}
	
	func showLoginController() {
		let loginViewController = LoginViewController()
		
		present(loginViewController, animated: true, completion: {
		})
	}
	
}

