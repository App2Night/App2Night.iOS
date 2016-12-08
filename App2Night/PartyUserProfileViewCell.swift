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
		
		override func awakeFromNib() {
			super.awakeFromNib()
		}
		
		override func setSelected(_ selected: Bool, animated: Bool) {
			super.setSelected(selected, animated: animated)
		}
		
	}
	
	class RadiusCell: UITableViewCell {
		
		lazy var radiusSlider: UISlider = {
			let slider = UISlider()
			slider.minimumValue = 1
			slider.maximumValue = 200
			slider.isContinuous = true
			slider.addTarget(self, action: #selector(sliderValueDidChange(_:)), for: .valueChanged)
			return slider
		}()
		
		let radiusLabel: UILabel = {
			let label = UILabel()
			label.textAlignment = .center
			return label
		}()
		
		let radiusStep: Float = 10
		
		override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
			super.init(style: style, reuseIdentifier: reuseIdentifier)
			setupCell()
		}
		
		required init?(coder aDecoder: NSCoder) {
			fatalError("init(coder:) has not been implemented")
		}
		
		func setupCell() {
			addSubview(radiusSlider)
			addSubview(radiusLabel)
			
			let currentUser = try! Realm().object(ofType: CurrentUser.self, forPrimaryKey: "0")
			
			let radius = currentUser?.radius
			
			var sliderValue: Float
			
			if (radius != nil) {
				sliderValue = Float(radius!)
			} else {
				sliderValue = 100
			}
			
			radiusSlider.value = sliderValue
			radiusLabel.text = String(describing: Int(radiusSlider.value))
			
			_ = radiusSlider.anchor(self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: radiusLabel.leftAnchor, topConstant: 0, leftConstant: 16, bottomConstant: 0, rightConstant: 8, widthConstant: 0, heightConstant: 0)
			
			_ = radiusLabel.anchor(self.topAnchor, left: radiusSlider.rightAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, topConstant: 0, leftConstant: 8, bottomConstant: 0, rightConstant: 16, widthConstant: 40, heightConstant: 0)
			
		}
		
		func sliderValueDidChange(_ sender : UISlider!)
		{
			let roundedStepValue = round(sender.value / radiusStep) * radiusStep
			sender.value = roundedStepValue
			
			try! RealmManager.currentRealm.write {
				RealmManager.currentRealm.create(CurrentUser.self, value: ["id": "0", "radius": Int(roundedStepValue)], update: true)
			}
			
			radiusLabel.text = String(describing: Int(roundedStepValue))
		}
		
		override func awakeFromNib() {
			super.awakeFromNib()
		}
		
		override func setSelected(_ selected: Bool, animated: Bool) {
			super.setSelected(selected, animated: animated)
		}
		
	}
	
}

