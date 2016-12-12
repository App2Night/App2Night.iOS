//
//  PartyDetailTableViewController.swift
//  App2Night
//
//  Created by Robin on 28.11.16.
//  Copyright © 2016 DHBW. All rights reserved.
//

import UIKit
import MapKit

class PartyDetailTableViewController: UITableViewController, MKMapViewDelegate {
	
	var selectedParty: Party = Party()
	
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
		navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissView))
		
		tableView.register(BaseCell.self, forCellReuseIdentifier: cellId)
	}
	
	override func viewWillAppear(_ animated: Bool) {
		// zoom to pin
		let center = CLLocationCoordinate2D(latitude: pin.coordinate.latitude, longitude: pin.coordinate.longitude)
		let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
		self.mapView.setRegion(region, animated: true)
	}
	
	// dismiss view
	func dismissView() {
		dismiss(animated: true, completion: nil)
	}
	
	// MARK: - Table view data
	override func numberOfSections(in tableView: UITableView) -> Int {
		return 3
	}
	
	// set number of rows in section
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		switch (section) {
		case 0: return 1
		case 1: return 1
		case 2: return 1
		default: fatalError(error)
		}
	}
	
	// set class
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		return tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
	}
	
	// set height
	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 44
	}

	// set header
	override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		switch(section) {
		case 0: return ""
		case 1: return ""
		case 2: return ""
		default: fatalError(error)
		}
	}
	
}
