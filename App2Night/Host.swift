//
//  Host.swift
//  App2Night
//
//  Created by Robin on 24.10.16.
//  Copyright © 2016 DHBW. All rights reserved.
//

import Foundation

public class Host {
	
	private var hostId: String!
	private var userName: String!
	
	
	// MARK: init empty host object
	init() {
		
	}
	
	// MARK: init from NSDictionary
	init(pDictionary: NSDictionary) {
		hostId = pDictionary["HostId"] as? String
		userName = pDictionary["UserName"] as? String
	}
	
	// MARK: GET & SET
	public func getHostID() -> String {
		return self.hostId
	}
	
	public func setHostID(pHostID: String) {
		self.hostId = pHostID
	}
	
	public func getUserName() -> String {
		return self.userName
	}
	
	public func setUserName(pUserName: String) {
		self.userName = pUserName
	}
	
	
}

