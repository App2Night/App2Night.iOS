//
//  PartyMapViewController.swift
//  App2Night
//
//  Created by Robin on 28.11.16.
//  Copyright © 2016 DHBW. All rights reserved.
//

import UIKit
import MapKit
import RealmSwift

class PartyMapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
	
	// get parties from realm
	var parties = try! Realm().objects(Party.self)
	
	// location things
	var mapView: MKMapView = MKMapView()
	let locationManager = CLLocationManager()
	
	let pinId = "PartyMapViewPin"
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// update
		parties = try! Realm().objects(Party.self)
		
		// setup navigation bar
		navigationItem.title = "Parties"
		
		// location things
		locationManager.requestWhenInUseAuthorization()
		if CLLocationManager.locationServicesEnabled() {
			locationManager.delegate = self
			locationManager.desiredAccuracy = kCLLocationAccuracyBest
			locationManager.startUpdatingLocation()
		}
		
		// map frame
		mapView.mapType = .standard
		mapView.frame = view.frame
		mapView.delegate = self
		mapView.showsUserLocation = true
		
		// parse realm objects to pins and add them to the mapView
		parseAnnotations()
		
		view.addSubview(mapView)
	}
	
	// MARK: - parse parties to annotations
	func parseAnnotations() {
		for object in parties {
			let pin = PartyMapViewPin(party: object)
			mapView.addAnnotation(pin)
		}
	}
	
	// MARK: - Location delegate
	func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
		let lastLocation = locations.last
		let center = CLLocationCoordinate2D(latitude: lastLocation!.coordinate.latitude, longitude: lastLocation!.coordinate.longitude)
		let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1))
		self.mapView.setRegion(region, animated: true)
		self.locationManager.stopUpdatingLocation()
	}
	
	// display pins
	func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
		if let annotation = annotation as? PartyMapViewPin {
			let id = pinId
			var view: MKPinAnnotationView
			
			if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: id) as? MKPinAnnotationView {
				dequeuedView.annotation = annotation
				view = dequeuedView
			}
			else {
				view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: id)
				view.canShowCallout = true
				// hacky custom Button class to pass annotation pin reference
				let detailViewButton = PartyDetailViewButton(type: .detailDisclosure)
				detailViewButton.currentPin = annotation
				detailViewButton.addTarget(self, action: #selector(handleDetailViewButton), for: .touchUpInside)
				view.rightCalloutAccessoryView = detailViewButton
			}
			return view
		}
		return nil
	}
	
	// handle button tap
	func handleDetailViewButton(sender: PartyDetailViewButton) {
		let detailView = PartyDetailViewController()
		detailView.selectedParty = (sender.currentPin?.object)!
		let wrappedDetailView = PartyNavigationController(rootViewController: detailView)
		present(wrappedDetailView, animated: true, completion: nil)
	}
	
}

