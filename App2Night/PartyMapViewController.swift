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
	var pins: [PartyMapViewPin] = [PartyMapViewPin]()
	
	// location things
	var mapView: MKMapView = MKMapView()
	let locationManager = CLLocationManager()
	
	let pinId = "PartyMapViewPin"
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
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
		
		view.addSubview(mapView)
	}
	
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		mapView.removeAnnotations(pins)
		mapView.reloadInputViews()
		pins.removeAll()
		
		parseAnnotations()
	}
	
	// MARK: - parse parties to annotations
	func parseAnnotations() {
		parties = try! Realm().objects(Party.self)
		
		for object in parties {
			let pin = PartyMapViewPin(party: object)
			pins.append(pin)
		}
		
		mapView.addAnnotations(pins)
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
				let detailViewButton = UIButton(type: .detailDisclosure)
				view.rightCalloutAccessoryView = detailViewButton
			}
			return view
		}
		return nil
	}
	
	func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
		let pin: PartyMapViewPin = view.annotation as! PartyMapViewPin
		
		let detailView = PartyDetailViewController()
		// use primary key string from pin to get party object from realm -> cant pass object reference because of realm limits
		detailView.selectedParty =  try! Realm().object(ofType: Party.self, forPrimaryKey: pin.id)!
		let wrappedDetailView = PartyNavigationController(rootViewController: detailView)
		present(wrappedDetailView, animated: true, completion: nil)
	}
	
}

