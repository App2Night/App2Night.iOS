//
//  PartyUserProfileViewCell.swift
//  App2Night
//
//  Created by Robin on 30.11.16.
//  Copyright © 2016 DHBW. All rights reserved.
//

import UIKit
import RealmSwift

extension PartyUserProfileViewController {
	
	class ProfileCell: BaseCell {
		
		let user: UILabel = {
			let label = UILabel()
			label.textAlignment = .left
			return label
		}()
		
		let email: UILabel = {
			let label = UILabel()
			label.textAlignment = .left
			label.textColor = UIColor(red: 142/255, green: 142/255, blue: 147/255, alpha: 1)
			return label
		}()
		
		override func setupCell() {
			addSubview(user)
			addSubview(email)
			
			_ = user.anchor(nil, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, topConstant: 0, leftConstant: 16, bottomConstant: 0, rightConstant: 16, widthConstant: 0, heightConstant: 18)
			user.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -13).isActive = true
			
			_ = email.anchor(user.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, topConstant: 4, leftConstant: 16, bottomConstant: 0, rightConstant: 16, widthConstant: 0, heightConstant: 18)
		}
		
	}
	
	class RadiusCell: BaseCell {
		
		lazy var slider: UISlider = {
			let slider = UISlider()
			slider.minimumValue = 1
			slider.maximumValue = 200
			slider.isContinuous = true
			slider.addTarget(self, action: #selector(sliderValueDidChange(_:)), for: .valueChanged)
			return slider
		}()
		
		let radius: UILabel = {
			let label = UILabel()
			label.textAlignment = .right
			label.textColor = UIColor(red: 142/255, green: 142/255, blue: 147/255, alpha: 1)
			return label
		}()
		
		let radiusLabel: UILabel = {
			let label = UILabel()
			label.textAlignment = .left
			label.text = "Radius"
			return label
		}()
		
		let step: Float = 10
		
		override func setupCell() {
			addSubview(slider)
			addSubview(radius)
			addSubview(radiusLabel)
			
			// get current slider settings (pretty dirty)
			let currentUser = try! Realm().object(ofType: You.self, forPrimaryKey: "0")
			let radiusValue = currentUser?.radius
			
			var sliderValue: Float
			
			if (radiusValue != nil) {
				sliderValue = Float(radiusValue!)
			} else {
				sliderValue = 100
			}
			
			slider.value = sliderValue
			radius.text = String(describing: Int(slider.value)) + " km"
			
			_ = slider.anchor(nil, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, topConstant: 0, leftConstant: 16, bottomConstant: 8, rightConstant: 16, widthConstant: 0, heightConstant: 0)
			
			_ = radius.anchor(self.topAnchor, left: nil, bottom: nil, right: self.rightAnchor, topConstant: 12, leftConstant: 0, bottomConstant: 0, rightConstant: 16, widthConstant: 0, heightConstant: 0)
			
			_ = radiusLabel.anchor(self.topAnchor, left: self.leftAnchor, bottom: nil, right: nil, topConstant: 12, leftConstant: 16, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
			
		}
		
		func sliderValueDidChange(_ sender : UISlider!)
		{
			let rounded = round(sender.value / step) * step
			sender.value = rounded
			radius.text = String(describing: Int(rounded)) + " km"
		}
		
	}
	
	class BaseCell: UITableViewCell {
		
		override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
			super.init(style: style, reuseIdentifier: reuseIdentifier)
			setupCell()
		}
		
		required init?(coder aDecoder: NSCoder) {
			fatalError("init(coder:) has not been implemented")
		}
		
		func setupCell() {
			
		}
		
	}
	
}

