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
		
		label.textAlignment = .left
		label.font = UIFont.systemFont(ofSize: 18)
		
		return label
	}()
	
	let ratingLabel: UILabel = {
		let label = UILabel()
		
		label.textAlignment = .center
		label.font = UIFont.systemFont(ofSize: 12)
		
		return label
	}()
	
	/*
	let ratingView: UIView = {
		let view = UIView()
		view.frame = CGRect(x: 0, y: 0, width: 60, height: 60)
		view.layer.cornerRadius = view.frame.width / 2
		view.clipsToBounds = true
		view.backgroundColor = .a2nRed
		return view
	}()
	*/
	
	let distanceLabel: UILabel = {
		let label = UILabel()
		
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
		
		_ = ratingLabel.anchor(self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: nameLabel.leftAnchor, topConstant: 8, leftConstant: 8, bottomConstant: 8, rightConstant: 4, widthConstant: 60, heightConstant: 0)
		
		_ = nameLabel.anchor(self.topAnchor, left: ratingLabel.rightAnchor, bottom: self.bottomAnchor, right: distanceLabel.leftAnchor, topConstant: 8, leftConstant: 4, bottomConstant: 8, rightConstant: 4, widthConstant: 0, heightConstant: 0)
		
		_ = distanceLabel.anchor(self.topAnchor, left: nameLabel.rightAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, topConstant: 8, leftConstant: 4, bottomConstant: 8, rightConstant: 8, widthConstant: 80, heightConstant: 0)
		
		/*
		// horizontal
		addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[v0(30)]-[v1]-[v2(80)]-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": ratingLabel, "v1": nameLabel, "v2": distanceLabel]))
		
		// vertical
		addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": nameLabel]))
		addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": distanceLabel]))
		addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": ratingLabel]))
		*/
	}
	
	override func awakeFromNib() {
		super.awakeFromNib()
	}
	
	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
	}
	
}

