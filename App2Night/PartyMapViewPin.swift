//
//  PartyMapViewPin.swift
//  App2Night
//
//  Created by Robin on 30.11.16.
//  Copyright © 2016 DHBW. All rights reserved.
//

import UIKit
import MapKit

extension PartyMapViewController {
	
	class PartyMapViewPin: NSObject, MKAnnotation {
		
		let title: String?
		let cityName: String?
		let coordinate: CLLocationCoordinate2D
		let object: Party
		var subtitle: String? {
			return cityName
		}
		
		init(party: Party) {
			self.object = party
			self.title = self.object.name
			self.cityName = self.object.cityName
			self.coordinate = CLLocationCoordinate2D(latitude: self.object.latitude, longitude: self.object.longitude)
			
			super.init()
		}
		
	}
	
}
