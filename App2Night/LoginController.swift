//
//  LoginController.swift
//  App2Night
//
//  Created by Robin on 16.11.16.
//  Copyright © 2016 DHBW. All rights reserved.
//

import UIKit

class LoginController: UIViewController {
	
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
	@IBOutlet weak var loginButton: UIButton!
    
	override func viewDidLoad() {
		super.viewDidLoad()
		
		loginButton.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
	}
	
	func handleLogin() {
		SwaggerCommunication.shared.getToken(username: username.text!, password: password.text!) { success in
			if success {
				self.finishLoggingIn()
			}
		}
	}
	
	func finishLoggingIn() {
		UserDefaults.standard.setIsLoggedIn(bool: true)
		
		dismiss(animated:true, completion: nil)
	}
	
}

