//
//  LoginCollectionViewCell.swift
//  App2Night
//
//  Created by Robin on 05.12.16.
//  Copyright © 2016 DHBW. All rights reserved.
//

import UIKit

extension LoginViewController {
	
	class LoginCollectionViewCell: UICollectionViewCell {
		
		let logoView: UIImageView = {
			let image = UIImageView()
			image.image = #imageLiteral(resourceName: "Logo")
			image.contentMode = .scaleAspectFit
			return image
		}()
		
		let logoTitleView: UIImageView = {
			let image = UIImageView()
			image.image = #imageLiteral(resourceName: "LogoTitle")
			image.contentMode = .scaleAspectFit
			return image
		}()
		
		let usernameTextField: PaddedTextField = {
			let field = PaddedTextField()
			field.placeholder = "Username"
			field.layer.borderColor = UIColor.lightGray.cgColor
			field.layer.borderWidth = 1
			field.layer.cornerRadius = 12
			field.keyboardType = .default
			field.autocapitalizationType = .none
			field.autocorrectionType = .no
			return field
		}()
		
		let passwordTextField: PaddedTextField = {
			let field = PaddedTextField()
			field.placeholder = "Passwort"
			field.layer.borderColor = UIColor.lightGray.cgColor
			field.layer.borderWidth = 1
			field.isSecureTextEntry = true
			field.layer.cornerRadius = 12
			return field
		}()
		
		lazy var loginButton: UIButton = {
			let button = UIButton(type: .system)
			button.backgroundColor = .a2nRed
			button.layer.cornerRadius = 12
			button.setTitle("Einloggen", for: .normal)
			button.setTitleColor(.white, for: .normal)
			button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
			return button
		}()
		
		weak var delegate: LoginViewControllerDelegate?
		
		func handleLogin() {
			delegate?.dismissKeyboard()
			
			guard let username = usernameTextField.text, !username.isEmpty else {
				self.delegate?.displayAlert(title: "Username-Feld darf nicht leer sein!", message: "Bitte gib deinen Username ein.", buttonTitle: "Okay")
				return
			}
			
			guard let password = passwordTextField.text, !password.isEmpty else {
				self.delegate?.displayAlert(title: "Passwort-Feld darf nicht leer sein!", message: "Bitte gib dein Passwort ein.", buttonTitle: "Okay")
				return
			}
			
			SwiftSpinner.show("Login wird übertragen...")
			SwaggerCommunication.shared.getToken(username: username, password: password) { success in
				if success {
					SwiftSpinner.show("Profil wird geladen...")
					SwaggerCommunication.shared.getUserInfo { (success) in
						if success {
							self.delegate?.finishLoggingIn()
							SwiftSpinner.hide()
						} else {
							print("LOGIN FAILED.")
							SwiftSpinner.hide()
							self.delegate?.displayAlert(title: "Login fehlgeschlagen!", message: "Überprüfe bitte deine eingegebenen Daten.", buttonTitle: "Okay")
						}
					}
				} else {
					print("LOGIN FAILED.")
					SwiftSpinner.hide()
					self.delegate?.displayAlert(title: "Login fehlgeschlagen!", message: "Überprüfe bitte deine eingegebenen Daten.", buttonTitle: "Okay")
				}
			}
		}
		
		override init(frame: CGRect) {
			super.init(frame: frame)
			
			setupView()
		}
		
		func setupView() {
			backgroundColor = .clear
			
			addSubview(usernameTextField)
			addSubview(passwordTextField)
			addSubview(loginButton)
			
			// add logo
			addSubview(logoView)
			addSubview(logoTitleView)
			
			_ = logoView.anchor(centerYAnchor, left: nil, bottom: nil, right: nil, topConstant: -230, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 160, heightConstant: 160)
			logoView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
			
			_ = logoTitleView.anchor(logoView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 16, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 50)
			
			_ = usernameTextField.anchor(logoTitleView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 32, leftConstant: 64, bottomConstant: 0, rightConstant: 64, widthConstant: 0, heightConstant: 50)
			
			_ = passwordTextField.anchor(usernameTextField.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 16, leftConstant: 64, bottomConstant: 0, rightConstant: 64, widthConstant: 0, heightConstant: 50)
			
			_ = loginButton.anchor(passwordTextField.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 32, leftConstant: 128, bottomConstant: 0, rightConstant: 128, widthConstant: 0, heightConstant: 50)
			
		}
		
		required init?(coder aDecoder: NSCoder) {
			fatalError("init(coder:) has not been implemented")
		}
		
	}
	
	class RegisterCollectionViewCell: UICollectionViewCell {
		
		let logoView: UIImageView = {
			let image = UIImageView()
			image.image = #imageLiteral(resourceName: "Logo")
			image.contentMode = .scaleAspectFit
			return image
		}()
		
		let logoTitleView: UIImageView = {
			let image = UIImageView()
			image.image = #imageLiteral(resourceName: "LogoTitle")
			image.contentMode = .scaleAspectFit
			return image
		}()
		
		let usernameTextField: PaddedTextField = {
			let field = PaddedTextField()
			field.placeholder = "Username"
			field.layer.borderColor = UIColor.lightGray.cgColor
			field.layer.borderWidth = 1
			field.layer.cornerRadius = 12
			field.keyboardType = .default
			field.autocapitalizationType = .none
			field.autocorrectionType = .no
			return field
		}()
		
		let emailTextField: PaddedTextField = {
			let field = PaddedTextField()
			field.placeholder = "E-Mail"
			field.layer.borderColor = UIColor.lightGray.cgColor
			field.layer.borderWidth = 1
			field.layer.cornerRadius = 12
			field.keyboardType = .emailAddress
			field.autocapitalizationType = .none
			field.autocorrectionType = .no
			return field
		}()
		
		let passwordTextField: PaddedTextField = {
			let field = PaddedTextField()
			field.placeholder = "Passwort"
			field.layer.borderColor = UIColor.lightGray.cgColor
			field.layer.borderWidth = 1
			field.isSecureTextEntry = true
			field.layer.cornerRadius = 12
			return field
		}()
		
		lazy var registerButton: UIButton = {
			let button = UIButton(type: .system)
			button.backgroundColor = .a2nRed
			button.layer.cornerRadius = 12
			button.setTitle("Registrieren", for: .normal)
			button.setTitleColor(.white, for: .normal)
			button.addTarget(self, action: #selector(handleRegister), for: .touchUpInside)
			return button
		}()
		
		weak var delegate: LoginViewControllerDelegate?
		
		func handleRegister() {
			delegate?.dismissKeyboard()
			
			guard let username = usernameTextField.text, !username.isEmpty else {
				self.delegate?.displayAlert(title: "Username-Feld darf nicht leer sein!", message: "Bitte gib deinen Username ein.", buttonTitle: "Okay")
				return
			}
			
			guard let email = emailTextField.text, !email.isEmpty else {
				self.delegate?.displayAlert(title: "E-Mail-Feld darf nicht leer sein!", message: "Bitte gib eine gültige E-Mail-Adresse ein.", buttonTitle: "Okay")
				return
			}
			
			guard let password = passwordTextField.text, !password.isEmpty else {
				self.delegate?.displayAlert(title: "Passwort-Feld darf nicht leer sein!", message: "Bitte gib dein Passwort ein.", buttonTitle: "Okay")
				return
			}
			
			SwiftSpinner.show("Registrierung wird übertragen...")
			
			SwaggerCommunication.shared.postUser(username: username, email: email, password: password) { success in
				if success {
					print("REGISTER SUCCESS.")
					SwiftSpinner.hide()
				} else {
					print("REGISTER FAILED.")
					self.delegate?.displayAlert(title: "Registrierung fehlgeschlagen!", message: "Irgendetwas ist schiefgelaufen.", buttonTitle: "Okay")
					SwiftSpinner.hide()
				}
			}
		}
		
		override init(frame: CGRect) {
			super.init(frame: frame)
			
			setupView()
		}
		
		func setupView() {
			backgroundColor = .clear
			
			addSubview(usernameTextField)
			addSubview(emailTextField)
			addSubview(passwordTextField)
			addSubview(registerButton)
			
			// add logo
			addSubview(logoView)
			addSubview(logoTitleView)
			
			_ = logoView.anchor(centerYAnchor, left: nil, bottom: nil, right: nil, topConstant: -270, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 160, heightConstant: 160)
			logoView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
			
			_ = logoTitleView.anchor(logoView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 16, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 50)
			
			_ = usernameTextField.anchor(logoTitleView.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 32, leftConstant: 64, bottomConstant: 0, rightConstant: 64, widthConstant: 0, heightConstant: 50)
			
			_ = emailTextField.anchor(usernameTextField.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 16, leftConstant: 64, bottomConstant: 0, rightConstant: 64, widthConstant: 0, heightConstant: 50)
			
			_ = passwordTextField.anchor(emailTextField.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 16, leftConstant: 64, bottomConstant: 0, rightConstant: 64, widthConstant: 0, heightConstant: 50)
			
			_ = registerButton.anchor(passwordTextField.bottomAnchor, left: leftAnchor, bottom: nil, right: rightAnchor, topConstant: 32, leftConstant: 128, bottomConstant: 0, rightConstant: 128, widthConstant: 0, heightConstant: 50)
			
		}
		
		required init?(coder aDecoder: NSCoder) {
			fatalError("init(coder:) has not been implemented")
		}
		
	}
	
}

class PaddedTextField: UITextField {
	
	override func textRect(forBounds bounds: CGRect) -> CGRect {
		return CGRect(x: bounds.origin.x + 12, y: bounds.origin.y, width: bounds.width + 12, height: bounds.height)
	}
	
	override func editingRect(forBounds bounds: CGRect) -> CGRect {
		return CGRect(x: bounds.origin.x + 12, y: bounds.origin.y, width: bounds.width + 12, height: bounds.height)
	}
	
}

