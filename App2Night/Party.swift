//
//  Party+CoreDataClass.swift
//  App2Night
//
//  Created by Robin on 08.11.16.
//  Copyright © 2016 DHBW. All rights reserved.
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData

@objc(Party)
public class Party: NSManagedObject {
	
	@nonobjc public class func fetchRequest() -> NSFetchRequest<Party> {
		return NSFetchRequest<Party>(entityName: "Party");
	}
	
	@NSManaged public var date: NSDate
	@NSManaged public var id: String
	@NSManaged public var musicGenre: Int16
	@NSManaged public var name: String
	@NSManaged public var price: NSDecimalNumber
	@NSManaged public var text: String
	@NSManaged public var type: Int16
	@NSManaged public var host: Host
	@NSManaged public var location: Location
	
	
}

