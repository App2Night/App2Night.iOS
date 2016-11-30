//
//  PartyTableViewCell.swift
//  App2Night
//
//  Created by Robin on 30.11.16.
//  Copyright © 2016 DHBW. All rights reserved.
//

import UIKit

class PartyTableViewCell: UITableViewCell {
	
	let nameLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		
		label.textAlignment = .left
		label.font = UIFont.systemFont(ofSize: 18)
		
		return label
	}()
	
	let ratingLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		
		label.textAlignment = .center
		label.font = UIFont.systemFont(ofSize: 12)
		
		return label
	}()
	
	let distanceLabel: UILabel = {
		let label = UILabel()
		label.translatesAutoresizingMaskIntoConstraints = false
		
		label.textAlignment = .center
		label.font = UIFont.systemFont(ofSize: 24)
		
		return label
	}()
	
	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setupCell()
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	func setupCell() {
		// add elements
		addSubview(ratingLabel)
		addSubview(nameLabel)
		addSubview(distanceLabel)
		
		// add small arrow
		self.accessoryType = .disclosureIndicator
		
		// horizontal
		addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[v0(30)]-[v1]-[v2(80)]-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": ratingLabel, "v1": nameLabel, "v2": distanceLabel]))
		
		// vertical
		addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": nameLabel]))
		addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": distanceLabel]))
		addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": ratingLabel]))
	}
	
	override func awakeFromNib() {
		super.awakeFromNib()
	}
	
	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
	}
	
}

