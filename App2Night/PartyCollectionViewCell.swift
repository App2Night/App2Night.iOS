//
//  PartyCollectionViewCell.swift
//  App2Night
//
//  Created by Robin on 11.12.16.
//  Copyright © 2016 DHBW. All rights reserved.
//

import UIKit
import MapKit

extension PartyCollectionViewController {
	
	class PartyCell: BaseCell {
		
		let overlay: UIView = {
			let view = UIView()
			view.backgroundColor = .black
			view.alpha = 0.1
			return view
		}()
		
		override var isSelected: Bool {
			didSet {
				if self.isSelected {
					addSubview(overlay)
					_ = overlay.anchor(self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
				} else {
					overlay.removeFromSuperview()
				}
			}
		}
		
		let check: UIImageView = {
			let imageView = UIImageView()
			let arrow = #imageLiteral(resourceName: "Checked Filled")
			let templateArrow = arrow.withRenderingMode(.alwaysTemplate)
			imageView.image = templateArrow
			imageView.tintColor = UIColor(red: 21/255, green: 126/255, blue: 251/255, alpha: 1)
			return imageView
		}()
		
		let arrow: UIImageView = {
			let imageView = UIImageView()
			let arrow = #imageLiteral(resourceName: "Sort Right Filled")
			let templateArrow = arrow.withRenderingMode(.alwaysTemplate)
			imageView.image = templateArrow
			imageView.tintColor = UIColor(red: 199/255, green: 199/255, blue: 204/255, alpha: 1)
			return imageView
		}()
		
		let thumbnail: UIImageView = {
			let imageView = UIImageView()
			imageView.translatesAutoresizingMaskIntoConstraints = false
			imageView.contentMode = .scaleAspectFill
			imageView.layer.cornerRadius = 74/2
			imageView.layer.masksToBounds = true
			imageView.image = #imageLiteral(resourceName: "Default Party Thumbnail")
			return imageView
		}()
		
		let rating: UILabel = {
			let label = UILabel()
			label.textAlignment = .left
			label.font = .systemFont(ofSize: 16)
			label.textColor = UIColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 1)
			label.text = "👍1337  👎42"
			return label
		}()
		
		let name: UILabel = {
			let label = UILabel()
			label.textAlignment = .left
			label.font = .systemFont(ofSize: 18)
			label.textColor = UIColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 1)
			label.text = "Name"
			return label
		}()
		
		let subtitle: UILabel = {
			let label = UILabel()
			label.textAlignment = .left
			label.font = .systemFont(ofSize: 16)
			label.textColor = UIColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 1)
			label.text = "Subtitle"
			return label
		}()
		
		let distance: UILabel = {
			let label = UILabel()
			label.textAlignment = .center
			label.font = .systemFont(ofSize: 26)
			label.textColor = UIColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 1)
			label.text = "3.2"
			return label
		}()
		
		let distanceLabel: UILabel = {
			let label = UILabel()
			label.textAlignment = .center
			label.font = .systemFont(ofSize: 12)
			label.textColor = UIColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 1)
			label.text = "KM"
			return label
		}()
		
		let upperDivider: UIView = {
			let view = UIView()
			view.translatesAutoresizingMaskIntoConstraints = false
			view.backgroundColor = .a2nGray
			return view
		}()
		
		let lowerDivider: UIView = {
			let view = UIView()
			view.translatesAutoresizingMaskIntoConstraints = false
			view.backgroundColor = .a2nGray
			return view
		}()
		
		override func setupCell() {
			backgroundColor = .white
			
			addSubview(thumbnail)
			addSubview(arrow)
			addSubview(check)
			addSubview(distance)
			addSubview(distanceLabel)
			addSubview(rating)
			addSubview(name)
			addSubview(subtitle)
			addSubview(upperDivider)
			addSubview(lowerDivider)
			
			check.isHidden = true
			
			// thumbnail
			_ = thumbnail.anchor(nil, left: self.leftAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 13, bottomConstant: 0, rightConstant: 0, widthConstant: 74, heightConstant: 74)
			thumbnail.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
			
			// check
			_ = check.anchor(nil, left: self.leftAnchor, bottom: self.bottomAnchor, right: nil, topConstant: 0, leftConstant: 7, bottomConstant: 7, rightConstant: 0, widthConstant: 32, heightConstant: 32)
			
			// arrow
			_ = arrow.anchor(nil, left: nil, bottom: nil, right: self.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 8, widthConstant: 18, heightConstant: 18)
			arrow.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
			
			// distance
			_ = distance.anchor(nil, left: nil, bottom: nil, right: self.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 13, widthConstant: 74, heightConstant: 32)
			distance.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -10).isActive = true
			
			// distance - km label
			_ = distanceLabel.anchor(distance.bottomAnchor, left: distance.leftAnchor, bottom: nil, right: distance.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 14)
			
			// rating
			_ = rating.anchor(subtitle.bottomAnchor, left: thumbnail.rightAnchor, bottom: nil, right: distance.leftAnchor, topConstant: 0, leftConstant: 13, bottomConstant: 0, rightConstant: 13, widthConstant: 0, heightConstant: 24)
			//rating.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
			
			// labels
			_ = name.anchor(nil, left: thumbnail.rightAnchor, bottom: nil, right: distance.leftAnchor, topConstant: 0, leftConstant: 13, bottomConstant: 0, rightConstant: 13, widthConstant: 0, heightConstant: 24)
			name.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -24).isActive = true
			
			_ = subtitle.anchor(name.bottomAnchor, left: thumbnail.rightAnchor, bottom: nil, right: distance.leftAnchor, topConstant: 0, leftConstant: 13, bottomConstant: 0, rightConstant: 13, widthConstant: 0, heightConstant: 24)
			
			// seperator lines
			_ = upperDivider.anchor(self.topAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0.5)
			
			_ = lowerDivider.anchor(nil, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0.5)
			
		}
		
	}
	
	class BaseCell: UICollectionViewCell {
		
		override init(frame: CGRect) {
			super.init(frame: frame)
			setupCell()
		}
		
		required init?(coder aDecoder: NSCoder) {
			fatalError("init(coder:) has not been implemented")
		}
		
		func setupCell() {
			
		}
		
	}
	
}
