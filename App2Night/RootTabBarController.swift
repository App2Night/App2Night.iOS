//
//  RootTabBarController.swift
//  App2Night
//
//  Created by Robin on 11.11.16.
//  Copyright © 2016 DHBW. All rights reserved.
//

import UIKit

class RootTabBarController: UITabBarController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// is user logged in?
		if !isLoggedIn() {
			perform(#selector(showLogin), with: nil, afterDelay: 0.01)
		}
	}
	
	func showLogin() {
		present(UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "LoginController"), animated: true, completion: {
			// TODO: something
		})
	}
	
	fileprivate func isLoggedIn() -> Bool {
		return false
	}
	
	
}

