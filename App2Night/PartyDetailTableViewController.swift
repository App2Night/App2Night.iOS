//
//  PartyDetailTableViewController.swift
//  App2Night
//
//  Created by Robin on 28.11.16.
//  Copyright © 2016 DHBW. All rights reserved.
//

import UIKit
import MapKit
import RealmSwift
import SwiftyJSON

protocol PartyDetailTableViewControllerDelegate: class {
	
	func putCommitmentState()
	func reloadTable()
	
}

class PartyDetailTableViewController: UITableViewController, MKMapViewDelegate, PartyDetailTableViewControllerDelegate {
	
	var selectedParty: Party = Party()
	
	// init cells
	let nameCell: DetailCell = {
		let cell = DetailCell()
		cell.leftLabel.text = "Name"
		return cell
	}()
	
	let dateCell: DetailCell = {
		let cell = DetailCell()
		cell.leftLabel.text = "Datum"
		return cell
	}()
	
	let musicGenreCell: DetailCell = {
		let cell = DetailCell()
		cell.leftLabel.text = "Musikrichtung"
		return cell
	}()
	
	let typeCell: DetailCell = {
		let cell = DetailCell()
		cell.leftLabel.text = "Typ"
		return cell
	}()
	
	let textCell: TextCell = {
		let cell = TextCell()
		cell.leftLabel.text = "Beschreibung"
		return cell
	}()
	
	let countryCell: DetailCell = {
		let cell = DetailCell()
		cell.leftLabel.text = "Land"
		return cell
	}()
	
	let cityCell: DetailCell = {
		let cell = DetailCell()
		cell.leftLabel.text = "Stadt"
		return cell
	}()
	
	let streetCell: DetailCell = {
		let cell = DetailCell()
		cell.leftLabel.text = "Straße"
		return cell
	}()
	
	let houseNumberCell: DetailCell = {
		let cell = DetailCell()
		cell.leftLabel.text = "Hausnummer"
		return cell
	}()
	
	let zipcodeCell: DetailCell = {
		let cell = DetailCell()
		cell.leftLabel.text = "Postleitzahl"
		return cell
	}()
	
	let priceCell: DetailCell = {
		let cell = DetailCell()
		cell.leftLabel.text = "Preis (€)"
		return cell
	}()
	
	let hostCell: DetailCell = {
		let cell = DetailCell()
		cell.leftLabel.text = "Veranstalter"
		return cell
	}()
	
	let userCell: TextCell = {
		let cell = TextCell()
		cell.leftLabel.text = "Teilnehmende User"
		return cell
	}()
	
	let commitmentCell = CommitmentCell()
	
	let generalRatingCell = RatingCell()
	let priceRatingCell = RatingCell()
	let locationRatingCell = RatingCell()
	let moodRatingCell = RatingCell()
	
	let ratingButtonCell = RatingButtonCell()
	
	func configureCells() {
		// init date formatter
		let dateFormatter: DateFormatter = {
			let formatter = DateFormatter()
			formatter.dateFormat = "dd.MM.yyyy', 'HH:mm"
			return formatter
		}()
		
		var userList: String = ""
		let userCount = selectedParty.committedUser.count
		var counter: Int = 1
		
		for user in selectedParty.committedUser {
			userList.append(user.userName)
			if (userCount != counter) {
				userList.append(", ")
			}
			counter = counter+1
		}
		
		let startDate = Calendar(identifier: .gregorian).startOfDay(for: selectedParty.date)
		
		if (selectedParty.userCommitmentState == 0) {
			if ((Date() >= startDate) && (Date() <= startDate + 86400)) {
				enableRating()
			} else {
				disableRating()
			}
		} else {
			disableRating()
		}
		
		ratingButtonCell.button.addTarget(self, action: #selector(handleRating), for: .touchUpInside)
		
		generalRatingCell.leftLabel.text = "Allgemein"
		priceRatingCell.leftLabel.text = "Preis"
		locationRatingCell.leftLabel.text = "Standort"
		moodRatingCell.leftLabel.text = "Stimmung"
		
		generalRatingCell.rightLabel.text = getRatingCellText(up: selectedParty.generalUpVoting, down: selectedParty.generalDownVoting)
		priceRatingCell.rightLabel.text = getRatingCellText(up: selectedParty.priceUpVoting, down: selectedParty.priceDownVoting)
		locationRatingCell.rightLabel.text = getRatingCellText(up: selectedParty.locationUpVoting, down: selectedParty.locationDownVoting)
		moodRatingCell.rightLabel.text = getRatingCellText(up: selectedParty.moodUpVoting, down: selectedParty.moodDownVoting)
		
		commitmentCell.delegate = self
		
		userCell.rightLabel.text = userList
		
		commitmentCell.segmentedControl.selectedSegmentIndex = selectedParty.userCommitmentState
		
		nameCell.rightLabel.text = selectedParty.name
		textCell.rightLabel.text = selectedParty.text
		hostCell.rightLabel.text = selectedParty.host?.userName
		priceCell.rightLabel.text = String(describing: selectedParty.price)
		dateCell.rightLabel.text = dateFormatter.string(from: selectedParty.date)
		typeCell.rightLabel.text = PartyType.from(hashValue: selectedParty.type).rawValue
		musicGenreCell.rightLabel.text = MusicGenre.from(hashValue: selectedParty.musicGenre).rawValue
		countryCell.rightLabel.text = selectedParty.countryName
		cityCell.rightLabel.text = selectedParty.cityName
		streetCell.rightLabel.text = selectedParty.streetName
		houseNumberCell.rightLabel.text = selectedParty.houseNumber
		zipcodeCell.rightLabel.text = selectedParty.zipcode
	}
	// init end
	
	func getRatingCellText(up: Int, down: Int) ->String {
		return "👍\(up)  👎\(down)"
	}
	
	func handleRating() {
		let json: JSON = [
			"generalRating": getRating(from: generalRatingCell.segmentedControl.selectedSegmentIndex),
			"priceRating": getRating(from: priceRatingCell.segmentedControl.selectedSegmentIndex),
			"locationRating": getRating(from: locationRatingCell.segmentedControl.selectedSegmentIndex),
			"moodRating": getRating(from: moodRatingCell.segmentedControl.selectedSegmentIndex)
		]
		
		let data = try! json.rawData()
		
		disableRating()
		
		SwiftSpinner.show("Dein Token wird überprüft...")
		SwaggerCommunication.shared.revokeToken { (success) in
			if success {
				SwiftSpinner.show("Deine Bewertung wird gesendet...")
				SwaggerCommunication.shared.putPartyRating(with: data, for: self.selectedParty.id) { (success) in
					if success {
						SwiftSpinner.hide()
						
						SwiftSpinner.show("Deine Party wird aktualisiert...")
						SwaggerCommunication.shared.getParty(for: self.selectedParty.id) { (success) in
							if success {
								// update previous view
								self.reloadTable()
								self.enableRating()
								SwiftSpinner.hide()
							} else {
								self.enableRating()
								SwiftSpinner.hide()
								self.displayAlert(title: "Party wurde nicht aktualisiert!", message: "Update ist schiefgelaufen.", buttonTitle: "Okay")
							}
						}
					} else {
						self.enableRating()
						SwiftSpinner.hide()
						self.displayAlert(title: "Dein Rating konnte nicht übertragen werden.", message: "Irgendetwas ist schiefgelaufen.", buttonTitle: "Okay")
						
					}
				}
			} else {
				self.enableRating()
				SwiftSpinner.hide()
				self.displayAlert(title: "Dein Rating konnte nicht übertragen werden.", message: "Irgendetwas ist schiefgelaufen.", buttonTitle: "Okay")
			}
			
		}
	}
	
	func getRating(from index: Int) -> Int {
		switch (index) {
		case 0: return -1
		case 1: return 0
		case 2: return 1
		default: return 0
		}
	}
	
	func disableRating() {
		ratingButtonCell.button.backgroundColor = .lightGray
		ratingButtonCell.button.isEnabled = false
		generalRatingCell.segmentedControl.isEnabled = false
		priceRatingCell.segmentedControl.isEnabled = false
		locationRatingCell.segmentedControl.isEnabled = false
		moodRatingCell.segmentedControl.isEnabled = false
	}
	
	func enableRating() {
		ratingButtonCell.button.backgroundColor = UIColor(red: 21/255, green: 126/255, blue: 251/255, alpha: 1)
		ratingButtonCell.button.isEnabled = true
		generalRatingCell.segmentedControl.isEnabled = true
		priceRatingCell.segmentedControl.isEnabled = true
		locationRatingCell.segmentedControl.isEnabled = true
		moodRatingCell.segmentedControl.isEnabled = true
	}
	
	let pin = MKPointAnnotation()
	
	let headerView: UIView = {
		let view = UIView()
		return UIView()
	}()
	
	let upperDivider: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = .a2nGray
		return view
	}()
	
	let lowerDivider: UIView = {
		let view = UIView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = .a2nGray
		return view
	}()
	
	var mapView: MKMapView = MKMapView()
	
	// init cells
	let baseCell = BaseCell()
	
	// debug dequeue
	let cellId = "BaseCell"
	
	let error = "Switch case failed in tableView!"
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		configureCells()
		
		// setup visuals
		navigationItem.title = selectedParty.name
		
		// setup map view
		mapView.mapType = .standard
		mapView.delegate = self
		mapView.showsUserLocation = false
		mapView.isUserInteractionEnabled = false
		
		headerView.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: 140)
		headerView.addSubview(mapView)
		headerView.addSubview(upperDivider)
		headerView.addSubview(lowerDivider)
		
		// seperator lines
		_ = upperDivider.anchor(headerView.topAnchor, left: headerView.leftAnchor, bottom: nil, right: headerView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0.5)
		
		_ = lowerDivider.anchor(nil, left: headerView.leftAnchor, bottom: headerView.bottomAnchor, right: headerView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0.5)
		
		// map view
		_ = mapView.anchor(headerView.topAnchor, left: headerView.leftAnchor, bottom: headerView.bottomAnchor, right: headerView.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
		
		// set tableHeaderView to custom headerView
		tableView.tableHeaderView = headerView
		
		// create pin
		pin.title = selectedParty.name
		pin.coordinate = CLLocationCoordinate2D(latitude: selectedParty.latitude, longitude: selectedParty.longitude)
		mapView.addAnnotation(pin)
		
		// nav bar button
		navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(dismissView))
		navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(presentEditForm))
		
		if selectedParty.hostedByUser {
			if (Date() <= selectedParty.date) {
				navigationItem.rightBarButtonItem?.isEnabled = true
			} else {
				navigationItem.rightBarButtonItem?.isEnabled = false
			}
		} else {
			navigationItem.rightBarButtonItem?.isEnabled = false
		}
		
		tableView.register(BaseCell.self, forCellReuseIdentifier: cellId)
	}
	
	func reloadTable() {
		configureCells()
		navigationItem.title = selectedParty.name
		self.tableView.reloadData()
	}
	
	override func viewWillAppear(_ animated: Bool) {
		// zoom to pin
		let center = CLLocationCoordinate2D(latitude: pin.coordinate.latitude, longitude: pin.coordinate.longitude)
		let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
		self.mapView.setRegion(region, animated: true)
		
		self.tableView?.reloadData()
	}
	
	// dismiss view
	func dismissView() {
		dismiss(animated: true, completion: nil)
	}
	
	// table view data
	override func numberOfSections(in tableView: UITableView) -> Int {
		return 4
	}
	
	// set number of rows in section
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		switch (section) {
		case 0: return 12
		case 1: return 5
		case 2: return 1
		case 3: return 1
		default: fatalError(error)
		}
	}
	
	// set class
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		switch(indexPath.section) {
		case 0:
			switch(indexPath.row) {
			case 0: return self.nameCell
			case 1: return self.textCell
			case 2: return self.hostCell
			case 3: return self.priceCell
			case 4: return self.dateCell
			case 5: return self.typeCell
			case 6: return self.musicGenreCell
			case 7: return self.countryCell
			case 8: return self.cityCell
			case 9: return self.streetCell
			case 10: return self.houseNumberCell
			case 11: return self.zipcodeCell
			default: fatalError(error)
			}
		case 1:
			switch(indexPath.row) {
			case 0: return self.generalRatingCell
			case 1: return self.priceRatingCell
			case 2: return self.locationRatingCell
			case 3: return self.moodRatingCell
			case 4: return self.ratingButtonCell
			default: fatalError(error)
			}
		case 2:
			switch(indexPath.row) {
			default: return commitmentCell
			}
		case 3:
			switch(indexPath.row) {
			default: return userCell
			}
		default: fatalError(error)
		}
	}
	
	// set height
	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		switch(indexPath.section) {
		case 0:
			switch(indexPath.row) {
			case 1: return 44*3
			default: return 44
			}
		case 1:
			switch(indexPath.row) {
			default: return 66
			}
		case 2:
			switch(indexPath.row) {
			default: return 76
			}
		case 3:
			switch(indexPath.row) {
			default: return 44*3
			}
		default: fatalError(error)
		}
	}
	
	// set header
	override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		switch(section) {
		case 0: return "Party Details"
		case 1: return "Bewertung"
		case 2: return "Teilnahme"
		case 3: return "Teilnehmende User"
		default: fatalError(error)
		}
	}
	
	override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
		switch(section) {
		case 1: return "Du musst anwesend sein und darfst bis zu maximal 24h später diese Party bewerten!"
		default: return ""
		}
	}
	
	override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return 44
	}
	
	func putCommitmentState() {
		// commitmentCell.segmentedControl.isUserInteractionEnabled = false
		self.commitmentCell.segmentedControl.isEnabled = false
		
		SwiftSpinner.show("Dein Token wird überprüft...")
		SwaggerCommunication.shared.revokeToken { (success) in
			if success {
				SwiftSpinner.show("Deine Teilnahme wird gesendet...")
				SwaggerCommunication.shared.putCommitmentState(for: self.selectedParty.id, with: self.commitmentCell.segmentedControl.selectedSegmentIndex) { (sucees) in
					if success {
						SwiftSpinner.hide()
						//self.commitmentCell.segmentedControl.isUserInteractionEnabled = true
						
						SwiftSpinner.show("Deine Party wird aktualisiert...")
						SwaggerCommunication.shared.getParty(for: self.selectedParty.id) { (success) in
							if success {
								// update previous view
								self.reloadTable()
								self.commitmentCell.segmentedControl.isEnabled = true
								SwiftSpinner.hide()
							} else {
								self.commitmentCell.segmentedControl.isEnabled = true
								SwiftSpinner.hide()
								self.displayAlert(title: "Party wurde nicht aktualisiert!", message: "Update ist schiefgelaufen.", buttonTitle: "Okay")
							}
						}
						
					} else {
						self.commitmentCell.segmentedControl.isEnabled = true
						SwiftSpinner.hide()
						self.displayAlert(title: "Deine Teilnahme konnte nicht übertragen werden.", message: "Irgendetwas ist schiefgelaufen.", buttonTitle: "Okay")
						// self.commitmentCell.segmentedControl.isUserInteractionEnabled = true
					}
				}
			} else {
				SwiftSpinner.hide()
				self.displayAlert(title: "Deine Teilnahme konnte nicht übertragen werden.", message: "Irgendetwas ist schiefgelaufen.", buttonTitle: "Okay")
				// self.commitmentCell.segmentedControl.isUserInteractionEnabled = true
				self.commitmentCell.segmentedControl.isEnabled = true
			}
			
		}
	}
	
	func presentEditForm() {
		let editFormView = PartyEditFormViewController()
		editFormView.party = selectedParty
		editFormView.delegate = self
		show(editFormView, sender: self)
	}
	
	// alert controllers
	func displayAlert(title: String, message: String, buttonTitle: String) {
		let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
		let defaultAction = UIAlertAction(title: buttonTitle, style: .default, handler: nil)
		alert.addAction(defaultAction)
		self.present(alert, animated: true, completion: nil)
	}
	
}
