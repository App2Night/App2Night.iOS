//
//  Enums.swift
//  App2Night
//
//  Created by Robin on 01.11.16.
//  Copyright © 2016 DHBW. All rights reserved.
//

import Foundation

public enum EventCommitment: String {
	
	// Accepted
	// Noted
	// Rejected
	
	case Attending = "Anwesend"
	case Noted = "Vorgemerkt"
	case Declined = "Abgesagt"
	
	
}

public enum Gender: String {
	
	// Unknown
	// Men
	// Woman
	
	case Neutral = "Neutral"
	case Male = "Männlich"
	case Female = "Weiblich"
	
	
}

public enum MusicGenre: String {
	
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

public enum PartyType: String {
	
	// Bar
	// Disco
	// Forest
	
	case Venue = "Lokal"
	case Disco = "Diskothek"
	case Remote = "Abseits"
	
	
}

