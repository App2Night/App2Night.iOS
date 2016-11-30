//
//  PartyCreateViewController.swift
//  App2Night
//
//  Created by Robin on 30.11.16.
//  Copyright © 2016 DHBW. All rights reserved.
//

import UIKit
import SwiftyJSON

class PartyCreateViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
		
		// background color
		view.backgroundColor = .white
		
		// setup navigation bar
		navigationItem.title = "Neue Party erstellen"
		navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
		navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(done))
    }
	
	// dismiss view
	func cancel() {
		dismiss(animated: true, completion: nil)
	}
	
	// try to submit party
	func done() {
		let partyJson: JSON = [
		"partyName": "iOS Party 4",
		"partyDate": "2016-12-25T12:00:00.000Z",
		"musicGenre": 0,
		"countryName": "Germany",
		"cityName": "Eutingen im Gäu",
		"streetName": "Hauptstraße",
		"houseNumber": "17",
		"zipcode": "72184",
		"partyType": 0,
		"description": "iOS Description"
		]
		
		SwaggerCommunication.shared.postParty(with: partyJson) { success in
			if success {
				print("POST OK.")
				self.cancel()
			} else {
				print("POST FAILED.")
			}
		}
	}

}
