//
//  Location+CoreDataClass.swift
//  App2Night
//
//  Created by Robin on 08.11.16.
//  Copyright © 2016 DHBW. All rights reserved.
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData

@objc(Location)
public class Location: NSManagedObject {
	
	@nonobjc public class func fetchRequest() -> NSFetchRequest<Location> {
		return NSFetchRequest<Location>(entityName: "Location");
	}
	
	@NSManaged public var cityName: String
	@NSManaged public var countryName: String
	@NSManaged public var houseNumber: String
	@NSManaged public var houseNumberAdditional: String
	@NSManaged public var latitude: Double
	@NSManaged public var longitude: Double
	@NSManaged public var streetName: String
	@NSManaged public var zipcode: String
	@NSManaged public var party: Party
	
	
}

