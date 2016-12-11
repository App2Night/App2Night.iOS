//
//  PartyCollectionViewController.swift
//  App2Night
//
//  Created by Robin on 11.12.16.
//  Copyright © 2016 DHBW. All rights reserved.
//

import UIKit
import MapKit
import RealmSwift

protocol PartyCollectionViewControllerDelegate: class {
	
	func updateParties()
	
}

class PartyCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, CLLocationManagerDelegate, PartyCollectionViewControllerDelegate {
	
	// get parties from realm
	var parties = try! Realm().objects(Party.self)
	
	// location things
	let locationManager = CLLocationManager()
	var currentLocation = CLLocationCoordinate2D()
	
	// pull to refresh control
	lazy var refreshControl: UIRefreshControl = {
		let rc = UIRefreshControl()
		// rc.attributedTitle = NSAttributedString(string: "Neue Parties werden geladen.", attributes: [:])
		rc.addTarget(self, action: #selector(PartyCollectionViewController.handleRefresh(_:)), for: UIControlEvents.valueChanged)
		return rc
	}()
	
	// handle the refresh
	func handleRefresh(_ refreshControl: UIRefreshControl) {
		SwaggerCommunication.shared.getParties(at: currentLocation) { success in
			if success {
				self.parties = try! Realm().objects(Party.self)
				self.collectionView?.reloadData()
				refreshControl.endRefreshing()
			} else {
				refreshControl.endRefreshing()
			}
		}
	}
	
	private let cellId = "PartyCell"
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// add pull to refresh to view
		collectionView?.addSubview(refreshControl)
		
		// update
		parties = try! Realm().objects(Party.self)
		
		// location permission
		locationManager.requestWhenInUseAuthorization()
		if CLLocationManager.locationServicesEnabled() {
			locationManager.delegate = self
			locationManager.desiredAccuracy = kCLLocationAccuracyBest
			locationManager.startUpdatingLocation()
		}
		
		// setup visuals
		navigationItem.title = "Parties"
		collectionView?.backgroundColor = .a2nLightGray
		collectionView?.alwaysBounceVertical = true
		
		// button to add parties
		navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(create))
		
		collectionView?.register(PartyCell.self, forCellWithReuseIdentifier: cellId)
	}
	
	override func viewWillAppear(_ animated: Bool) {
		self.collectionView?.reloadData()
		refreshControl.endRefreshing()
	}
	
	// create new party
	func create() {
		let form = PartyCreateFormViewController()
		form.delegate = self
		let createView = PartyNavigationController(rootViewController: form)
		present(createView, animated: true, completion: nil)
	}
	
	// number of items in section (we only have one section)
	override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return parties.count
	}
	
	// deque cell based on indexPath
	override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! PartyCell
		
		let party = parties[indexPath.row]
		cell.name.text = party.name
		cell.subtitle.text = "\(PartyType.from(hashValue: party.type).rawValue) • \(MusicGenre.from(hashValue: party.musicGenre).rawValue) • \(String(describing: party.price))€"
		cell.rating.text = "👍\(String(describing: party.generalUpVoting))  👎\(String(describing: party.generalDownVoting))"
		
		// actual to party
		let distance = CLLocation(latitude: currentLocation.latitude, longitude: currentLocation.longitude).distance(from: CLLocation(latitude: party.latitude, longitude: party.longitude))
		// smaller as 1 kilometer -> display 1 decimal
		if distance < 1000 {
			cell.distance.text = String(format: "%.1f", (distance/1000))
		} else {
			// smaller as 10 kilomter -> display 1 decimal
			if distance < 10000 {
				cell.distance.text = String(format: "%.1f", (distance/1000))
			}
				// bigger as 10 kilometer -> dont display any decimal
			else {
				cell.distance.text = String(format: "%.0f", (distance/1000))
			}
		}
		
		// check commitment
		switch (party.userCommitmentState) {
		case 0:
			cell.check.isHidden = false
			break
		case 1:
			cell.check.isHidden = false
			cell.check.tintColor = UIColor(red: 254/255, green: 203/255, blue: 47/255, alpha: 1)
			break
		case 2:
			cell.check.isHidden = true
			break
		default:
			cell.check.isHidden = true
		}
		
		return cell
	}
	
	// use delegate to set dimensions of cells
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
		return CGSize(width: view.frame.width, height: 100)
	}
	
	// set spacing between cells
	func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
		return 12
	}
	
	override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let detailView = PartyDetailViewController()
		detailView.selectedParty = parties[indexPath.row]
		let wrappedDetailView = PartyNavigationController(rootViewController: detailView)
		present(wrappedDetailView, animated: true, completion: nil)
	}
	
	// location delegate
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		let lastLocation = locations.last
		self.currentLocation = CLLocationCoordinate2D(latitude: lastLocation!.coordinate.latitude, longitude: lastLocation!.coordinate.longitude)
		self.collectionView?.reloadData()
	}
	
	// delegate background update
	func updateParties() {
		print("STARTED UPDATE IN BACKGROUND.")
		SwaggerCommunication.shared.getParties(at: currentLocation) { success in
			if success {
				self.parties = try! Realm().objects(Party.self)
				self.collectionView?.reloadData()
			}
		}
	}
	
}
