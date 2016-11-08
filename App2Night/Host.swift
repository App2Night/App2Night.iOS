//
//  Host+CoreDataClass.swift
//  App2Night
//
//  Created by Robin on 08.11.16.
//  Copyright © 2016 DHBW. All rights reserved.
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData

@objc(Host)
public class Host: NSManagedObject {
	
	@nonobjc public class func fetchRequest() -> NSFetchRequest<Host> {
		return NSFetchRequest<Host>(entityName: "Host");
	}
	
	@NSManaged public var id: String
	@NSManaged public var userName: String
	@NSManaged public var party: Set<Party>
	
	@objc(addPartyObject:)
	@NSManaged public func addToParty(_ value: Party)
	
	@objc(removePartyObject:)
	@NSManaged public func removeFromParty(_ value: Party)
	
	@objc(addParty:)
	@NSManaged public func addToParty(_ values: Set<Party>)
	
	@objc(removeParty:)
	@NSManaged public func removeFromParty(_ values: Set<Party>)
	
	
}

