//
//  Enumerations.swift
//  App2Night
//
//  Created by Robin on 10.12.16.
//  Copyright © 2016 DHBW. All rights reserved.
//

import UIKit

enum EventCommitment: String {
	
	// Accepted
	// Noted
	// Rejected
	
	case Attending = "Anwesend"
	case Noted = "Vorgemerkt"
	case Declined = "Abgesagt"
	
	static func from(hashValue value: Int) -> EventCommitment {
		switch (value) {
		case 0: return .Attending
		case 1: return .Noted
		case 2: return .Declined
		default: return .Attending
		}
	}
	
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
	
	static func from(hashValue value: Int) -> MusicGenre {
		switch (value) {
		case 0: return .Mixed
		case 1: return .Rock
		case 2: return .Pop
		case 3: return .HipHop
		case 4: return .Rap
		case 5: return .Electro
		default: return .Mixed
		}
	}
	
}

enum PartyType: String {
	
	// Bar
	// Disco
	// Forest
	
	case Venue = "Lokal"
	case Disco = "Disko"
	case Remote = "Abseits"
	
	static func from(hashValue value: Int) -> PartyType {
		switch (value) {
		case 0: return .Venue
		case 1: return .Disco
		case 2: return .Remote
		default: return .Venue
		}
	}
	
}
