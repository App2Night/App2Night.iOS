//
//  PartyCreateViewController.swift
//  App2Night
//
//  Created by Robin on 30.11.16.
//  Copyright © 2016 DHBW. All rights reserved.
//

import UIKit

class PartyCreateViewController: UIViewController {
	
	// spinner stuff
	var spinner = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
	var loadingView: UIView = UIView()
	var darkView: UIView = UIView()
	
	func showActivityIndicator() {
		DispatchQueue.main.async {
			self.view.isUserInteractionEnabled = false
			
			self.darkView = UIView()
			self.darkView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
			self.darkView.backgroundColor = .black
			self.darkView.alpha = 0.2
			
			self.loadingView = UIView()
			self.loadingView.frame = CGRect(x: 0.0, y: 0.0, width: 100.0, height: 100.0)
			self.loadingView.center = self.view.center
			self.loadingView.backgroundColor = .a2nRed
			self.loadingView.alpha = 1
			self.loadingView.clipsToBounds = true
			self.loadingView.layer.cornerRadius = 10
			
			self.spinner = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
			self.spinner.frame = CGRect(x: 0.0, y: 0.0, width: 80.0, height: 80.0)
			self.spinner.center = CGPoint(x:self.loadingView.bounds.size.width / 2, y:self.loadingView.bounds.size.height / 2)
			
			self.view.addSubview(self.darkView)
			self.loadingView.addSubview(self.spinner)
			self.view.addSubview(self.loadingView)
			self.spinner.startAnimating()
		}
	}
	
	func hideActivityIndicator() {
		DispatchQueue.main.async {
			self.view.isUserInteractionEnabled = true
			self.spinner.stopAnimating()
			self.loadingView.removeFromSuperview()
			self.darkView.removeFromSuperview()
		}
	}
	
	// ui
	let datePickerLineSeperatorView: UIView = {
		let view = UIView()
		view.backgroundColor = UIColor(red: 178/255, green: 178/255, blue: 178/255, alpha: 1)
		return view
	}()
	
	let partyHeaderLabel: UILabel = {
		let label = UILabel()
		label.text = "Party Details"
		label.textAlignment = .center
		label.font = UIFont.boldSystemFont(ofSize: 16)
		return label
	}()
	
	let locationHeaderLabel: UILabel = {
		let label = UILabel()
		label.text = "Standort Details"
		label.textAlignment = .center
		label.font = UIFont.boldSystemFont(ofSize: 16)
		return label
	}()
	
	// party
	let partyNameTextField: CreatePartyTextField = {
		let field = CreatePartyTextField()
		field.placeholder = "Name"
		return field
	}()
	
	let partyDateTextField: CreatePartyTextField = {
		let field = CreatePartyTextField()
		field.placeholder = "Datum"
		return field
	}()
	
	let partyDescriptionTextField: CreatePartyTextField = {
		let field = CreatePartyTextField()
		field.placeholder = "Beschreibung"
		return field
	}()
	
	let partyTypeTextField: CreatePartyTextField = {
		let field = CreatePartyTextField()
		field.placeholder = "Partytyp"
		return field
	}()
	
	let partyMusicGenreTextField: CreatePartyTextField = {
		let field = CreatePartyTextField()
		field.placeholder = "Musikrichtung"
		return field
	}()
	
	// location
	let locationCountryNameTextField: CreatePartyTextField = {
		let field = CreatePartyTextField()
		field.placeholder = "Land"
		return field
	}()
	
	let locationCityNameTextField: CreatePartyTextField = {
		let field = CreatePartyTextField()
		field.placeholder = "Stadt"
		return field
	}()
	
	let locationStreetNameTextField: CreatePartyTextField = {
		let field = CreatePartyTextField()
		field.placeholder = "Straßenname"
		return field
	}()
	
	let locationHouseNumberTextField: CreatePartyTextField = {
		let field = CreatePartyTextField()
		field.placeholder = "Nummer"
		return field
	}()
	
	let locationZipcodeTextField: CreatePartyTextField = {
		let field = CreatePartyTextField()
		field.placeholder = "PLZ"
		return field
	}()
	
	var tempDate: Date = Date()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.hideKeyboardWhenTappedAround()
		
		// background color
		view.backgroundColor = .white
		
		// setup navigation bar
		navigationItem.title = "Neue Party erstellen"
		navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissView))
		navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(postParty))
		
		// add all labels
		setupContent()
	}
	
	func createTemporaryParty() -> Party {
		// TODO: no error handling AT ALL -> refactor when we have time..
		let tempParty = Party()
		
		// cut seconds from date
		var newDate = Date()
		let timeInterval = floor(newDate.timeIntervalSinceReferenceDate / 60.0) * 60.0
		newDate = Date(timeIntervalSinceReferenceDate: timeInterval)
		
		tempParty.name = partyNameTextField.text!
		tempParty.date = newDate
		tempParty.musicGenre = Int(partyMusicGenreTextField.text!)!
		tempParty.countryName = locationCountryNameTextField.text!
		tempParty.cityName = locationCityNameTextField.text!
		tempParty.streetName = locationStreetNameTextField.text!
		tempParty.houseNumber = locationHouseNumberTextField.text!
		tempParty.zipcode = locationZipcodeTextField.text!
		tempParty.type = Int(partyTypeTextField.text!)!
		tempParty.text = partyDescriptionTextField.text!
		
		return tempParty
	}
	
	func setupContent() {
		view.addSubview(partyHeaderLabel)
		view.addSubview(partyNameTextField)
		view.addSubview(partyDateTextField)
		view.addSubview(partyDescriptionTextField)
		view.addSubview(partyTypeTextField)
		view.addSubview(partyMusicGenreTextField)
		
		view.addSubview(locationHeaderLabel)
		view.addSubview(locationCountryNameTextField)
		view.addSubview(locationCityNameTextField)
		view.addSubview(locationStreetNameTextField)
		view.addSubview(locationHouseNumberTextField)
		view.addSubview(locationZipcodeTextField)
		
		partyDateTextField.addTarget(self, action: #selector(editDate), for: .editingDidBegin)
		
		// cancer..
		_ = partyHeaderLabel.anchor(topLayoutGuide.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 8, leftConstant: 16, bottomConstant: 0, rightConstant: 16, widthConstant: 0, heightConstant: 44)
		
		_ = partyNameTextField.anchor(partyHeaderLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 8, leftConstant: 16, bottomConstant: 0, rightConstant: 16, widthConstant: 0, heightConstant: 44)
		
		_ = partyDateTextField.anchor(partyNameTextField.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 8, leftConstant: 16, bottomConstant: 0, rightConstant: 16, widthConstant: 0, heightConstant: 44)
		
		_ = partyDescriptionTextField.anchor(partyDateTextField.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 8, leftConstant: 16, bottomConstant: 0, rightConstant: 16, widthConstant: 0, heightConstant: 44)
		
		_ = partyTypeTextField.anchor(partyDescriptionTextField.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 8, leftConstant: 16, bottomConstant: 0, rightConstant: 16, widthConstant: 0, heightConstant: 44)
		
		_ = partyMusicGenreTextField.anchor(partyTypeTextField.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 8, leftConstant: 16, bottomConstant: 0, rightConstant: 16, widthConstant: 0, heightConstant: 44)
		
		_ = locationHeaderLabel.anchor(partyMusicGenreTextField.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 8, leftConstant: 16, bottomConstant: 0, rightConstant: 16, widthConstant: 0, heightConstant: 44)
		
		_ = locationCountryNameTextField.anchor(locationHeaderLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 8, leftConstant: 16, bottomConstant: 0, rightConstant: 16, widthConstant: 0, heightConstant: 44)
		
		_ = locationCityNameTextField.anchor(locationCountryNameTextField.bottomAnchor, left: view.leftAnchor, bottom: nil, right: locationZipcodeTextField.leftAnchor, topConstant: 8, leftConstant: 16, bottomConstant: 0, rightConstant: 8, widthConstant: 0, heightConstant: 44)
		
		_ = locationZipcodeTextField.anchor(locationCountryNameTextField.bottomAnchor, left: locationCityNameTextField.rightAnchor, bottom: nil, right: view.rightAnchor, topConstant: 8, leftConstant: 8, bottomConstant: 0, rightConstant: 16, widthConstant: 120, heightConstant: 44)
		
		_ = locationStreetNameTextField.anchor(locationCityNameTextField.bottomAnchor, left: view.leftAnchor, bottom: nil, right: locationHouseNumberTextField.leftAnchor, topConstant: 8, leftConstant: 16, bottomConstant: 0, rightConstant: 8, widthConstant: 0, heightConstant: 44)
		
		_ = locationHouseNumberTextField.anchor(locationCityNameTextField.bottomAnchor, left: locationStreetNameTextField.rightAnchor, bottom: nil, right: view.rightAnchor, topConstant: 8, leftConstant: 8, bottomConstant: 0, rightConstant: 16, widthConstant: 120, heightConstant: 44)
		
	}
	
	func editDate(sender: UITextField) {
		// replace keyboard with uidatepicker
		let dateView: UIDatePicker = UIDatePicker()
		dateView.datePickerMode = .dateAndTime
		dateView.backgroundColor = .white
		dateView.minimumDate = Date()
		dateView.addSubview(datePickerLineSeperatorView)
		_ = datePickerLineSeperatorView.anchor(nil, left: dateView.leftAnchor, bottom: dateView.topAnchor, right: dateView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
		datePickerLineSeperatorView.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
		
		sender.inputView = dateView
		dateView.addTarget(self, action: #selector(dateValueChanged), for: .valueChanged)
	}
	
	func dateValueChanged(sender: UIDatePicker) {
		let formatter: DateFormatter = {
			let dateFormatter = DateFormatter()
			dateFormatter.dateFormat = "dd.MM.yyyy', 'HH:mm"
			return dateFormatter
		}()
		
		tempDate = sender.date
		
		partyDateTextField.text = formatter.string(from: sender.date)
	}
	
	// dismiss view
	func dismissView() {
		dismiss(animated: true, completion: nil)
	}
	
	// try to submit party
	func postParty() {
		showActivityIndicator()
		
		let postParty = createTemporaryParty().toRawData()
		
		SwaggerCommunication.shared.postParty(with: postParty) { success in
			if success {
				self.hideActivityIndicator()
				print("POST OK.")
				self.dismissView()
			} else {
				self.hideActivityIndicator()
				print("POST FAILED.")
			}
		}
	}
	
}

class CreatePartyTextField: UITextField, UITextFieldDelegate {
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		self.layer.borderColor = UIColor.lightGray.cgColor
		self.layer.borderWidth = 1
		self.layer.cornerRadius = 12
		self.keyboardType = .default
		self.delegate = self
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func textRect(forBounds bounds: CGRect) -> CGRect {
		return CGRect(x: bounds.origin.x + 12, y: bounds.origin.y, width: bounds.width + 12, height: bounds.height)
	}
	
	override func editingRect(forBounds bounds: CGRect) -> CGRect {
		return CGRect(x: bounds.origin.x + 12, y: bounds.origin.y, width: bounds.width + 12, height: bounds.height)
	}
	
}


/*
Be sure to declare your ViewController as UITextFieldDelegate and set correct delegates in your initialization methods: ex:

self.you_text_field.delegate = self
And remember to call registerForKeyboardNotifications on viewInit and deregisterFromKeyboardNotifications on exit.

func registerForKeyboardNotifications(){
//Adding notifies on keyboard appearing
NotificationCenter.default.addObserver(self, selector: #selector(keyboardWasShown(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillBeHidden(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
}

func deregisterFromKeyboardNotifications(){
//Removing notifies on keyboard appearing
NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
}

func keyboardWasShown(notification: NSNotification){
//Need to calculate keyboard exact size due to Apple suggestions
self.scrollView.isScrollEnabled = true
var info = notification.userInfo!
let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size
let contentInsets : UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize!.height, 0.0)

self.scrollView.contentInset = contentInsets
self.scrollView.scrollIndicatorInsets = contentInsets

var aRect : CGRect = self.view.frame
aRect.size.height -= keyboardSize!.height
if let activeField = self.activeField {
if (!aRect.contains(activeField.frame.origin)){
self.scrollView.scrollRectToVisible(activeField.frame, animated: true)
}
}
}

func keyboardWillBeHidden(notification: NSNotification){
//Once keyboard disappears, restore original positions
var info = notification.userInfo!
let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size
let contentInsets : UIEdgeInsets = UIEdgeInsetsMake(0.0, 0.0, -keyboardSize!.height, 0.0)
self.scrollView.contentInset = contentInsets
self.scrollView.scrollIndicatorInsets = contentInsets
self.view.endEditing(true)
self.scrollView.isScrollEnabled = false
}

func textFieldDidBeginEditing(_ textField: UITextField){
activeField = textField
}

func textFieldDidEndEditing(_ textField: UITextField){
activeField = nil
}
*/
