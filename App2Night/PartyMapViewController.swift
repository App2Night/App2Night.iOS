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
		
		// map frame
		mapView.mapType = .standard
		mapView.frame = view.frame
		mapView.delegate = self
		mapView.showsUserLocation = true
		
		parseAnnotations()
		
		view.addSubview(mapView)
    }
	
	// MARK: - parse parties to annotations
	func parseAnnotations() {
		var annotations = [PartyAnnotation]()
		
		for object in parties {
			let party = PartyAnnotation(party: object)
			annotations.append(party)
		}
		
		mapView.addAnnotations(annotations)
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
		if let annotation = annotation as? PartyAnnotation {
			let identifier = "pin"
			var view: MKPinAnnotationView
			
			if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView {
				dequeuedView.annotation = annotation
				view = dequeuedView
			}
			else {
				view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
				view.canShowCallout = true
				// view.calloutOffset = CGPoint(x: -5, y: 5)
				// view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure) as UIView
			}
			return view
		}
		
		return nil
	}
	
}

class PartyAnnotation: NSObject, MKAnnotation {
	
	let title: String?
	let location: String
	let coordinate: CLLocationCoordinate2D
	
	init(party: Party) {
		self.title = party.name
		self.location = party.cityName
		self.coordinate = CLLocationCoordinate2D(latitude: party.latitude, longitude: party.longitude)
		
		super.init()
	}
	
	var subtitle: String? {
		return location
	}
	
}

