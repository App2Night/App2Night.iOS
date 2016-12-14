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
	
	var delegate: PartyCollectionViewController?
	
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
			<<< IntRow() { row in
				row.title = "Preis (€)"
				row.placeholder = "z.B. 5"
				row.add(rule: RuleRequired())
				row.tag = "price"
				}
				.cellUpdate { cell, row in
					if !row.isValid {
						cell.titleLabel?.textColor = .red
					}
			}
			<<< DateTimeRow() { row in
				row.title = "Datum"
				row.value = Date()
				row.dateFormatter?.dateFormat = "dd.MM.yyyy', 'HH:mm"
				row.minimumDate = Date()
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
		let errors = form.validate()
		tableView?.reloadData()
		
		if (errors.isEmpty) {
			// SwiftSpinner.show("Party wird gepostet...")
			let assembledParty = assembleParty()
			
			// overly nested check if token is old -> check if location is valid -> post party
			SwiftSpinner.show("Dein Token wird geprüft...")
			SwaggerCommunication.shared.revokeToken { (success) in
				if success {
					SwiftSpinner.show("Der Standort wird gegoogelt...")
					SwaggerCommunication.shared.validateLocation(with: assembledParty.toLocationRawData()) { (success) in
						if success {
							SwiftSpinner.show("Deine Party wird gepostet...")
							SwaggerCommunication.shared.postParty(with: assembledParty.toPartyRawData()) { (success, id) in
								if success {
									print("POST OK.")
									SwiftSpinner.show("Deine Party wird geladen...")
									SwaggerCommunication.shared.getParty(for: id!) { (success) in
										if success {
											// update previous view
											self.delegate?.reloadRealm()
											SwiftSpinner.hide()
											self.dismissView()
										} else {
											SwiftSpinner.hide()
											self.displayAlert(title: "Party wurde nicht geladen!", message: "Laden ist schiefgelaufen.", buttonTitle: "Okay")
										}
									}
								} else {
									print("POST FAILED.")
									
									// stop the spinner
									SwiftSpinner.hide()
									
									self.displayAlert(title: "Party wurde nicht gepostet!", message: "Posten ist schiefgelaufen.", buttonTitle: "Okay")
								}
							}
						} else {
							SwiftSpinner.hide()
							self.displayAlert(title: "Standort wurde nicht gefunden!", message: "Bitte gib einen gültigen Standort ein.", buttonTitle: "Okay")
						}
					}
					
				}
				else {
					SwiftSpinner.hide()
					self.displayAlert(title: "Token konnte nicht widerrufen werden!", message: "Oops.", buttonTitle: "Okay")
				}
			}
		}
		else {
			SwiftSpinner.hide()
			self.displayAlert(title: "Alle Felder müssen korrekt ausgefüllt werden!", message: "Überprüfe bitte deine Eingaben.", buttonTitle: "Okay")
		}
		
	}
	
	func assembleParty() -> Party {
		let party = Party()
		let values = form.values()
		
		party.name = values["name"] as! String
		party.date = (values["date"] as! Date).floorSeconds()
		party.musicGenre = (MusicGenre(rawValue: values["musicGenre"] as! String)?.hashValue)!
		party.countryName = values["countryName"] as! String
		party.cityName = values["cityName"] as! String
		party.streetName = values["streetName"] as! String
		party.houseNumber = values["houseNumber"] as! String
		party.zipcode = values["zipcode"] as! String
		party.type = (PartyType(rawValue: values["type"] as! String)?.hashValue)!
		party.text = values["text"] as! String
		party.price = values["price"] as! Int
		
		return party
	}
	
	// alert controllers
	func displayAlert(title: String, message: String, buttonTitle: String) {
		let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
		let defaultAction = UIAlertAction(title: buttonTitle, style: .default, handler: nil)
		alert.addAction(defaultAction)
		self.present(alert, animated: true, completion: nil)
	}
	
}
