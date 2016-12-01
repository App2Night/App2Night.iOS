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

	let scrollView = UIScrollView(frame: UIScreen.main.bounds)
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		// setup scroll view
		self.view = self.scrollView
		self.scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: 1200)
		
		// background color
		view.backgroundColor = .white
		
		// setup navigation bar
		navigationItem.title = "Neue Party erstellen"
		navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissView))
		navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(tryPost))
    }
	
	// dismiss view
	func dismissView() {
		dismiss(animated: true, completion: nil)
	}
	
	// try to submit party
	func tryPost() {
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
				self.dismissView()
			} else {
				print("POST FAILED.")
			}
		}
	}

}
