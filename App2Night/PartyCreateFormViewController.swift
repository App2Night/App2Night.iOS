//
//  PartyCreateFormViewController.swift
//  App2Night
//
//  Created by Robin on 10.12.16.
//  Copyright © 2016 DHBW. All rights reserved.
//

import UIKit
import Eureka

class PartyCreateFormViewController: FormViewController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// setup navigation bar
		navigationItem.title = "Neue Party erstellen"
		navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissView))
		navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(post))
		
		form = Section("Party Details")
			<<< TextRow() { row in
				row.title = "Name"
				row.placeholder = "max. 32 Zeichen"
				row.add(rule: RuleRequired())
				row.add(rule: RuleMaxLength(maxLength: 32))
				row.validationOptions = .validatesOnChange
				row.tag = "name"
				}
				.cellUpdate { cell, row in
					if !row.isValid {
						cell.titleLabel?.textColor = .red
					}
			}
			<<< TextRow() { row in
				row.title = "Beschreibung"
				row.placeholder = "max. 256 Zeichen"
				row.add(rule: RuleRequired())
				row.add(rule: RuleMaxLength(maxLength: 256))
				row.validationOptions = .validatesOnChange
				row.tag = "text"
				}
				.cellUpdate { cell, row in
					if !row.isValid {
						cell.titleLabel?.textColor = .red
					}
			}
			<<< DateTimeRow() { row in
				row.title = "Datum"
				row.value = Date()
				row.tag = "date"
			}
			<<< ActionSheetRow<String>() { row in
				row.title = "Typ"
				row.selectorTitle = "Typ der Party auswählen"
				row.options = [PartyType.Venue.rawValue, PartyType.Disco.rawValue, PartyType.Remote.rawValue]
				row.value = PartyType.Venue.rawValue
				row.tag = "type"
			}
			<<< ActionSheetRow<String>() { row in
				row.title = "Musikrichtung"
				row.selectorTitle = "Musikrichtung auswählen"
				row.options = [MusicGenre.Mixed.rawValue, MusicGenre.Rock.rawValue, MusicGenre.Pop.rawValue, MusicGenre.HipHop.rawValue, MusicGenre.Rap.rawValue, MusicGenre.Electro.rawValue]
				row.value = MusicGenre.Mixed.rawValue
				row.tag = "musicGenre"
			}
			+++ Section("Standort Details")
			<<< TextRow() { row in
				row.title = "Land"
				row.placeholder = "z.B. Deutschland"
				row.add(rule: RuleRequired())
				row.validationOptions = .validatesOnChange
				row.tag = "countryName"
				}
				.cellUpdate { cell, row in
					if !row.isValid {
						cell.titleLabel?.textColor = .red
					}
			}
			<<< TextRow() { row in
				row.title = "Stadt"
				row.placeholder = "z.B. Horb am Neckar"
				row.add(rule: RuleRequired())
				row.validationOptions = .validatesOnChange
				row.tag = "cityName"
				}
				.cellUpdate { cell, row in
					if !row.isValid {
						cell.titleLabel?.textColor = .red
					}
			}
			<<< TextRow() { row in
				row.title = "Straßenname"
				row.placeholder = "z.B. Florianstraße"
				row.add(rule: RuleRequired())
				row.validationOptions = .validatesOnChange
				row.tag = "streetName"
				}
				.cellUpdate { cell, row in
					if !row.isValid {
						cell.titleLabel?.textColor = .red
					}
			}
			<<< ZipCodeRow() { row in
				row.title = "Hausnummer"
				row.placeholder = "z.B. 15"
				row.add(rule: RuleRequired())
				row.validationOptions = .validatesOnChange
				row.tag = "houseNumber"
				}
				.cellUpdate { cell, row in
					if !row.isValid {
						cell.titleLabel?.textColor = .red
					}
			}
			<<< ZipCodeRow() { row in
				row.title = "Postleitzahl"
				row.placeholder = "z.B. 72160"
				row.add(rule: RuleRequired())
				row.validationOptions = .validatesOnChange
				row.tag = "zipcode"
				}
				.cellUpdate { cell, row in
					if !row.isValid {
						cell.titleLabel?.textColor = .red
					}
		}
	}
	
	// dismiss view
	func dismissView() {
		self.view.endEditing(true)
		dismiss(animated: true, completion: nil)
	}
	
	// post party
	func post() {
		SwaggerCommunication.shared.postParty(with: assembleParty()) { success in
			if success {
				print("POST OK.")
				self.dismissView()
			} else {
				print("POST FAILED.")
			}
		}
	}
	
	func assembleParty() -> Data {
		let party = Party()
		
		let values = form.values()
		
		/*
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
		*/
		
		return party.toRawData()
	}
	
}
