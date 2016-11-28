//
//  PartyTabBarController.swift
//  App2Night
//
//  Created by Robin on 28.11.16.
//  Copyright © 2016 DHBW. All rights reserved.
//

import UIKit

class PartyTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
		
		if !isLoggedIn() {
			perform(#selector(showLoginController), with: nil, afterDelay: 0.01)
		}
    }
	
	fileprivate func isLoggedIn() -> Bool {
		return UserDefaults.standard.isLoggedIn()
	}
	
	func showLoginController() {
		let loginController = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "LoginController")
		
		present(loginController, animated: true, completion: {
		})
	}
	
}

