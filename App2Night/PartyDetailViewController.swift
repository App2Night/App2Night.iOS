//
//  PartyDetailViewController.swift
//  App2Night
//
//  Created by Robin on 28.11.16.
//  Copyright © 2016 DHBW. All rights reserved.
//

import UIKit

class PartyDetailViewController: UIViewController {
	
	var selectedParty: Party = Party()
	
	let nameLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		
		label.textAlignment = .center
		label.font = UIFont.systemFont(ofSize: 24)
		
		return label
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// background color
		navigationItem.title = selectedParty.name
		view.backgroundColor = .white
		
		// set labels
		nameLabel.text = selectedParty.name
		
		// add labels
		view.addSubview(nameLabel)
		
		// horizontal
		view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[v0]-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": nameLabel]))
		
		// vertical
		view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": nameLabel]))
	}
	
}
