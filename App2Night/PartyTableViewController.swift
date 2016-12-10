//
//  PartyTableViewController.swift
//  App2Night
//
//  Created by Robin on 28.11.16.
//  Copyright © 2016 DHBW. All rights reserved.
//

import UIKit
import MapKit
import RealmSwift

class PartyTableViewController: UITableViewController, CLLocationManagerDelegate {
	
	// get parties from realm
	var parties = try! Realm().objects(Party.self)
	
	// location things
	let locationManager = CLLocationManager()
	var currentLocation = CLLocationCoordinate2D()
	
	// refresh control
	lazy var partyRefreshControl: UIRefreshControl = {
		let refreshControl = UIRefreshControl()
		refreshControl.addTarget(self, action: #selector(PartyTableViewController.handleRefresh(_:)), for: UIControlEvents.valueChanged)
		return refreshControl
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// update
		parties = try! Realm().objects(Party.self)
		
		// remove "empty" seperators
		self.tableView.tableFooterView = UIView()
		
		// setup navigation bar
		navigationItem.title = "Parties"
		
		// location things
		locationManager.requestWhenInUseAuthorization()
		if CLLocationManager.locationServicesEnabled() {
			locationManager.delegate = self
			locationManager.desiredAccuracy = kCLLocationAccuracyBest
			locationManager.startUpdatingLocation()
		}
		
		// pull to refresh
		tableView.addSubview(partyRefreshControl)
		
		// debug button to clear realm
		// navigationItem.leftBarButtonItem = UIBarButtonItem(title: "REALM CLEAR", style: .plain, target: self, action: #selector(clear))
		
		// button to add parties
		navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(create))
		
		// cell dimensions
		tableView.rowHeight = 90
		tableView.estimatedRowHeight = 90
		
		// register PartyTableViewCell
		tableView.register(PartyTableViewCell.self, forCellReuseIdentifier: "PartyCell")
	}
	
	// MARK: - Location delegate
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		let lastLocation = locations.last
		self.currentLocation = CLLocationCoordinate2D(latitude: lastLocation!.coordinate.latitude, longitude: lastLocation!.coordinate.longitude)
		self.tableView.reloadData()
	}
	
	// MARK: - Navigation items
	func clear() {
		RealmManager.shared.clear()
		tableView.reloadData()
	}
	
	// MARK: - Create new party
	func create() {
		let createView = PartyNavigationController(rootViewController: PartyCreateFormViewController())
		present(createView, animated: true, completion: nil)
	}
	
	// MARK: - Refresh control
	func handleRefresh(_ refreshControl: UIRefreshControl) {
		SwaggerCommunication.shared.getParties(at: currentLocation) { success in
			if success {
				self.parties = try! Realm().objects(Party.self)
				self.tableView.reloadData()
				refreshControl.endRefreshing()
			} else {
				refreshControl.endRefreshing()
			}
		}
	}
	
	// MARK: - Table view data
	override func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return parties.count
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "PartyCell", for: indexPath) as! PartyTableViewCell
		
		// get party by row
		let party = parties[indexPath.row]
		
		// location things
		let distance = CLLocation(latitude: currentLocation.latitude, longitude: currentLocation.longitude).distance(from: CLLocation(latitude: party.latitude, longitude: party.longitude))
		
		// smaller as 1 kilometer -> display 1 decimal
		if distance < 1000 {
			cell.distanceLabel.text = String(format: "%.1f", (distance/1000))
		} else {
			// smaller as 10 kilomter -> display 1 decimal
			if distance < 10000 {
				cell.distanceLabel.text = String(format: "%.1f", (distance/1000))
			}
				// bigger as 10 kilometer -> dont display any decimal
			else {
				cell.distanceLabel.text = String(format: "%.0f", (distance/1000))
			}
		}
		
		cell.nameLabel.text = party.name
		cell.ratingLabel.text = String(describing: (party.generalUpVoting-party.generalDownVoting))
		
		return cell
	}
	
	// tap on cell
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let detailView = PartyDetailViewController()
		detailView.selectedParty = parties[indexPath.row]
		let wrappedDetailView = PartyNavigationController(rootViewController: detailView)
		present(wrappedDetailView, animated: true, completion: nil)
	}
	
}

