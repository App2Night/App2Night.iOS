//
//  PartyDetailViewController.swift
//  App2Night
//
//  Created by Robin on 28.11.16.
//  Copyright © 2016 DHBW. All rights reserved.
//

import UIKit

class PartyDetailViewController: UIViewController {
	
	var party: Party = Party()
	
	let partyNameLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false

		label.text = "Party Name Label"
		label.textAlignment = .center
		label.font = UIFont.systemFont(ofSize: 24)
		
		return label
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// background color
		navigationItem.title = party.name
		view.backgroundColor = .white
		
		// set labels
		partyNameLabel.text = party.name
		
		// add labels
		view.addSubview(partyNameLabel)
		
		// horizontal
		view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[v0]-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": partyNameLabel]))
		
		// vertical
		view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": partyNameLabel]))
		
	}
	
}
