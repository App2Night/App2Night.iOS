//
//  PositionManager.swift
//  App2Night
//
//  Created by Robin on 26.11.16.
//  Copyright © 2016 DHBW. All rights reserved.
//

import UIKit
import MapKit

class PositionManager {
	
	// shared instance
	static let shared = PositionManager()
	
	// mapkit
	private let locationManager = CLLocationManager()
	var currentLocation = CLLocation()
	
	func getPosition() {
		locationManager.requestWhenInUseAuthorization()
		
		if (CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedWhenInUse || CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedAlways) {
			
			currentLocation = locationManager.location!
		}
	}
	
}

