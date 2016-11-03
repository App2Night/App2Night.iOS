//
//  Properties.swift
//  App2Night
//
//  Created by Robin on 01.11.16.
//  Copyright © 2016 DHBW. All rights reserved.
//

import Foundation

struct Properties {
	
	// Backend URLs
	private static let baseUrl = "https://app2nightapi.azurewebsites.net/"
	
	public static let partyUrl = baseUrl + "api/party"
	public static let userUrl = baseUrl + "api/user"
	public static let valuesUrl = baseUrl + "api/values"
	public static let tokenUrl = "https://app2nightuser.azurewebsites.net/connect/token"
	
	
}
