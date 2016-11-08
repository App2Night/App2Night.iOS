//
//  Enumerations.swift
//  App2Night
//
//  Created by Robin on 01.11.16.
//  Copyright © 2016 DHBW. All rights reserved.
//

import Foundation

// MARK: properties struct
struct Properties {
	
	// Backend URLs
	private static let baseApiUrl = "https://app2nightapi.azurewebsites.net/"
	private static let baseUserUrl = "https://app2nightuser.azurewebsites.net/"
	
	// Specific URLs
	public static let partyUrl = baseApiUrl + "api/party"
	public static let tokenUrl = baseUserUrl + "connect/token"
	
	
}

// MARK: - enumerations
enum EventCommitment: String {
	
	// Accepted
	// Noted
	// Rejected
	
	case Attending = "Anwesend"
	case Noted = "Vorgemerkt"
	case Declined = "Abgesagt"
	
	
}

enum Gender: String {
	
	// Unknown
	// Men
	// Woman
	
	case Neutral = "Neutral"
	case Male = "Männlich"
	case Female = "Weiblich"
	
	
}

enum MusicGenre: String {
	
	// All
	// Rock
	// Pop
	// HipHop
	// Rap
	// Electro
	
	case Mixed = "Gemischt"
	case Rock = "Rock'n'Roll"
	case Pop = "Pop"
	case HipHop = "Hip Hop"
	case Rap = "Rap"
	case Electro = "Electro"
	
	
}

enum PartyType: String {
	
	// Bar
	// Disco
	// Forest
	
	case Venue = "Lokal"
	case Disco = "Diskothek"
	case Remote = "Abseits"
	
	
}

