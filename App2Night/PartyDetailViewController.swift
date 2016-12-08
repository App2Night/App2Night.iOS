//
//  PartyDetailViewController.swift
//  App2Night
//
//  Created by Robin on 28.11.16.
//  Copyright © 2016 DHBW. All rights reserved.
//

import UIKit
import MapKit

class PartyDetailViewController: UIViewController, UIScrollViewDelegate {
	
	var selectedParty: Party = Party()
	
	let priceLabel: UILabel = {
		let label = UILabel()
		return label
	}()
	
	let dateLabel: UILabel = {
		let label = UILabel()
		return label
	}()
	
	let musicGenreLabel: UILabel = {
		let label = UILabel()
		return label
	}()
	
	let partyTypeLabel: UILabel = {
		let label = UILabel()
		return label
	}()
	
	let partyDescriptionLabel: UILabel = {
		let label = UILabel()
		return label
	}()
	
	let countryNameLabel: UILabel = {
		let label = UILabel()
		return label
	}()
	
	let cityNameLabel: UILabel = {
		let label = UILabel()
		return label
	}()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// background color
		navigationItem.title = selectedParty.name
		view.backgroundColor = .white
		
		// nav bar button
		navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(dismissView))
		
		setupContent()
	}
	
	func setupContent() {
		view.addSubview(priceLabel)
		view.addSubview(dateLabel)
		view.addSubview(musicGenreLabel)
		view.addSubview(partyTypeLabel)
		view.addSubview(partyDescriptionLabel)
		view.addSubview(countryNameLabel)
		
		priceLabel.text = String(describing: selectedParty.price)
		dateLabel.text = DateHelper.shared.getString(from: selectedParty.date)
		musicGenreLabel.text = String(describing: selectedParty.musicGenre)
		partyTypeLabel.text = String(describing: selectedParty.type)
		partyDescriptionLabel.text = selectedParty.text
		countryNameLabel.text = selectedParty.countryName
		
		_ = priceLabel.anchor(topLayoutGuide.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 8, leftConstant: 16, bottomConstant: 0, rightConstant: 16, widthConstant: 0, heightConstant: 0)
		
		_ = dateLabel.anchor(priceLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 8, leftConstant: 16, bottomConstant: 0, rightConstant: 16, widthConstant: 0, heightConstant: 0)
		
		_ = musicGenreLabel.anchor(dateLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 8, leftConstant: 16, bottomConstant: 0, rightConstant: 16, widthConstant: 0, heightConstant: 0)
		
		_ = partyTypeLabel.anchor(musicGenreLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 8, leftConstant: 16, bottomConstant: 0, rightConstant: 16, widthConstant: 0, heightConstant: 0)
		
		_ = partyDescriptionLabel.anchor(partyTypeLabel.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 8, leftConstant: 16, bottomConstant: 0, rightConstant: 16, widthConstant: 0, heightConstant: 0)
	}
	
	// dismiss view
	func dismissView() {
		dismiss(animated: true, completion: nil)
	}
	
}
