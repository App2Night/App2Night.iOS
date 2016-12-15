//
//  PartyEditFormViewController.swift
//  App2Night
//
//  Created by Robin on 12.12.16.
//  Copyright © 2016 DHBW. All rights reserved.
//

import UIKit
import Eureka
import RealmSwift

// this is just a straight copy of PartyCreateFormViewController with a few modified functions; could be solved by just inheriting the other controller.
class PartyEditFormViewController: FormViewController {
	
	var party: Party?
	var delegate: PartyDetailTableViewController?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// setup navigation bar
		navigationItem.title = "Party editieren"
		navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(post))
		
		form = Section("Party Details")
			<<< TextRow() { row in
				row.title = "Name"
				row.value = party?.name
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
				row.value = party?.text
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
				row.value = party?.price
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
				row.value = party?.date
				row.dateFormatter?.dateFormat = "dd.MM.yyyy', 'HH:mm"
				row.minimumDate = Date()
				row.tag = "date"
			}
			<<< ActionSheetRow<String>() { row in
				row.title = "Typ"
				row.selectorTitle = "Typ der Party auswählen"
				row.options = [PartyType.Venue.rawValue, PartyType.Disco.rawValue, PartyType.Remote.rawValue]
				row.value = PartyType.from(hashValue: (party?.type)!).rawValue
				row.tag = "type"
			}
			<<< ActionSheetRow<String>() { row in
				row.title = "Musikrichtung"
				row.selectorTitle = "Musikrichtung auswählen"
				row.options = [MusicGenre.Mixed.rawValue, MusicGenre.Rock.rawValue, MusicGenre.Pop.rawValue, MusicGenre.HipHop.rawValue, MusicGenre.Rap.rawValue, MusicGenre.Electro.rawValue]
				row.value = MusicGenre.from(hashValue: (party?.musicGenre)!).rawValue
				row.tag = "musicGenre"
			}
			+++ Section("Standort Details")
			<<< TextRow() { row in
				row.title = "Land"
				row.value = party?.countryName
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
				row.value = party?.cityName
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
				row.value = party?.streetName
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
				row.value = party?.houseNumber
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
				row.value = party?.zipcode
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
			+++ Section("")
			<<< ButtonRow() { row in
				row.title = "Party löschen"
				}
				.onCellSelection { cell, row in
					self.deleteParty()
		}
	}
	
	// delete party
	func deleteParty() {
		
		if ((party?.date)! > Date()) {
			SwiftSpinner.show("Dein Token wird geprüft...")
			SwaggerCommunication.shared.revokeToken { (success) in
				if success {
					SwiftSpinner.show("Party wird gelöscht...")
					SwaggerCommunication.shared.deleteParty(with: (self.party?.id)!) { (success) in
						if success {
							SwiftSpinner.hide()
							self.dismiss(animated: true, completion: nil)
							print("DELETED PARTY LOCALLY.")
							try! RealmManager.currentRealm.write {
								let party = RealmManager.currentRealm.object(ofType: Party.self, forPrimaryKey: (self.party?.id)!)
								RealmManager.currentRealm.delete(party!)
							}
						} else {
							SwiftSpinner.hide()
							self.displayAlert(title: "Party wurde nicht gelöscht!", message: "Löschen ist schiefgelaufen.", buttonTitle: "Okay")
						}
					}
				} else {
					SwiftSpinner.hide()
					self.displayAlert(title: "Token konnte nicht widerrufen werden!", message: "Oops.", buttonTitle: "Okay")
				}
			}
		} else {
			self.displayAlert(title: "Parties die bereits passiert sind können nicht gelöscht werden!", message: "Diese Party kann nicht gelöscht werden.", buttonTitle: "Okay")
		}
		
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
					SwaggerCommunication.shared.validateLocation(with: assembledParty.toLocationRawData()) { (success, location) in
						if success {
							// get new validated location values
							let party = self.assembleParty()
							party.countryName = location["CountryName"].stringValue
							party.cityName = location["CityName"].stringValue
							party.streetName = location["StreetName"].stringValue
							party.houseNumber = location["HouseNumber"].stringValue
							party.zipcode = location["Zipcode"].stringValue
							
							SwiftSpinner.show("Deine Party wird editiert...")
							SwaggerCommunication.shared.putParty(with: party.toPartyRawData(), for: (self.party?.id)!) { (success) in
								if success {
									print("POST OK.")
									SwiftSpinner.show("Deine Party wird aktualisiert...")
									SwaggerCommunication.shared.getParty(for: (self.party?.id)!) { (success) in
										if success {
											// update previous view
											self.delegate?.reloadTable()
											SwiftSpinner.hide()
											// pop view
											_ = self.navigationController?.popViewController(animated: true)
										} else {
											SwiftSpinner.hide()
											self.displayAlert(title: "Party wurde nicht aktualisiert!", message: "Update ist schiefgelaufen.", buttonTitle: "Okay")
										}
									}
									
								} else {
									print("POST FAILED.")
									
									// stop the spinner
									SwiftSpinner.hide()
									
									self.displayAlert(title: "Party wurde nicht editiert!", message: "Irgendetwas ist schiefgelaufen.", buttonTitle: "Okay")
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
		
		party.name = (values["name"] as! String).trimmingCharacters(in: .whitespacesAndNewlines)
		party.date = (values["date"] as! Date).floorSeconds()
		party.musicGenre = (MusicGenre(rawValue: values["musicGenre"] as! String)?.hashValue)!
		party.countryName = (values["countryName"] as! String).trimmingCharacters(in: .whitespacesAndNewlines)
		party.cityName = (values["cityName"] as! String).trimmingCharacters(in: .whitespacesAndNewlines)
		party.streetName = (values["streetName"] as! String).trimmingCharacters(in: .whitespacesAndNewlines)
		party.houseNumber = (values["houseNumber"] as! String).trimmingCharacters(in: .whitespacesAndNewlines)
		party.zipcode = (values["zipcode"] as! String).trimmingCharacters(in: .whitespacesAndNewlines)
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
