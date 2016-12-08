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
		let id: String?
		let coordinate: CLLocationCoordinate2D
		var subtitle: String? {
			return cityName
		}
		
		init(party: Party) {
			self.id = party.id
			self.title = party.name
			self.cityName = party.cityName
			self.coordinate = CLLocationCoordinate2D(latitude: party.latitude, longitude: party.longitude)
			
			super.init()
		}
		
	}
	
	class PartyDetailViewButton: UIButton {
		
		var currentPin: PartyMapViewPin?
		
		override init(frame: CGRect) {
			super.init(frame: frame)
		}
		
		required init?(coder aDecoder: NSCoder) {
			fatalError("init(coder:) has not been implemented")
		}
		
	}
	
}
