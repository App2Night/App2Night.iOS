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
