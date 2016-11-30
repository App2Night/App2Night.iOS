//
//  PartyMapViewPin.swift
//  App2Night
//
//  Created by Robin on 30.11.16.
//  Copyright © 2016 DHBW. All rights reserved.
//

import UIKit
import MapKit

class PartyPin: NSObject, MKAnnotation {
	
	let title: String?
	let cityName: String?
	
	var subtitle: String? {
		return cityName
	}
	
	let coordinate: CLLocationCoordinate2D
	
	init(party: Party) {
		self.title = party.name
		self.cityName = party.cityName
		self.coordinate = CLLocationCoordinate2D(latitude: party.latitude, longitude: party.longitude)
		
		super.init()
	}
	
}

