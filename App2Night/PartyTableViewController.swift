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
		
		// setup navigation bar
		navigationItem.title = "Parties"
		
		// location things
		locationManager.requestAlwaysAuthorization()
		locationManager.requestWhenInUseAuthorization()
		if CLLocationManager.locationServicesEnabled() {
			locationManager.delegate = self
			locationManager.desiredAccuracy = kCLLocationAccuracyBest
			locationManager.startUpdatingLocation()
		}
		
		// pull to refresh
		tableView.addSubview(partyRefreshControl)
		
		// debug button to clear realm
		navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Löschen", style: .plain, target: self, action: #selector(clear))
		
		tableView.rowHeight = 90
		tableView.estimatedRowHeight = 90
		
		// register PartyTableViewCell
		tableView.register(PartyTableViewCell.self, forCellReuseIdentifier: "PartyCell")
    }
	
	// MARK - Location delegate
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		let lastLocation = locations.last
		self.currentLocation = CLLocationCoordinate2D(latitude: lastLocation!.coordinate.latitude, longitude: lastLocation!.coordinate.longitude)
	}
	
	// MARK - Navigation items
	func clear() {
		RealmManager.shared.clear()
		tableView.reloadData()
	}
	
	// MARK - Refresh control
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

	// MARK - Table view data
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return parties.count
    }
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "PartyCell", for: indexPath) as! PartyTableViewCell
		
		let party = parties[indexPath.row]
		
		// location things
		let distance = CLLocation(latitude: currentLocation.latitude, longitude: currentLocation.longitude).distance(from: CLLocation(latitude: party.latitude, longitude: party.longitude))
		
		cell.partyDistanceLabel.text = String(format: "%.1f", (distance/1000))
		cell.partyNameLabel.text = party.name
		cell.partyRatingLabel.text = String(describing: (party.generalUpVoting-party.generalDownVoting))
		
		return cell
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let detailView = PartyDetailViewController()
		detailView.party = parties[indexPath.row]
		self.show(detailView, sender: self)
	}

}

class PartyTableViewCell: UITableViewCell {
	
	let partyNameLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		
		label.text = "Party Name Label"
		label.textAlignment = .left
		label.font = UIFont.systemFont(ofSize: 18)
		
		return label
	}()
	
	let partyRatingLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		
		label.text = "123"
		label.textAlignment = .center
		label.font = UIFont.systemFont(ofSize: 12)
		
		return label
	}()
	
	let partyDistanceLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		
		label.text = "1,2"
		label.textAlignment = .center
		label.font = UIFont.systemFont(ofSize: 24)
		
		return label
	}()
	
	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setupCell()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func setupCell() {
		// add elements
		addSubview(partyNameLabel)
		addSubview(partyDistanceLabel)
		addSubview(partyRatingLabel)
		
		// horizontal
		addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[v3(30)]-[v0]-[v1(80)]-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": partyNameLabel, "v1": partyDistanceLabel, "v3": partyRatingLabel]))
		
		// vertical
		addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": partyNameLabel]))
		addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": partyDistanceLabel]))
		addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": partyRatingLabel]))
	}
	
	override func awakeFromNib() {
		super.awakeFromNib()
	}
	
	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
	}
	
}

