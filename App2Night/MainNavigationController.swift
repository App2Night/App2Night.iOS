//
//  MainNavigationController.swift
//  App2Night
//
//  Created by Robin on 03.11.16.
//  Copyright © 2016 DHBW. All rights reserved.
//

import UIKit

class MainNavigationController: UINavigationController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .white
		
		if isLoggedIn() {
			let homeController = UIStoryboard(name: "Home", bundle: nil).instantiateViewController(withIdentifier: "homeController")
			viewControllers = [homeController]
		} else {
			perform(#selector(showLoginController), with: nil, afterDelay: 0.01)
		}
	}
	
	fileprivate func isLoggedIn() -> Bool {
		return true
	}
	
	func showLoginController() {
		let loginController = LoginController()
		present(loginController, animated: true, completion: {
			
		})
	}
	
	
}

