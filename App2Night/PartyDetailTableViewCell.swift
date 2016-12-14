//
//  PartyDetailTableViewCell.swift
//  App2Night
//
//  Created by Robin on 11.12.16.
//  Copyright © 2016 DHBW. All rights reserved.
//

import UIKit

// all detail cells, rating, etc..
extension PartyDetailTableViewController {
	
	class RatingButtonCell: BaseCell {
		
		let button: UIButton = {
			let button = UIButton(type: .system)
			button.layer.cornerRadius = 12
			button.setTitle("Bewerten", for: .normal)
			button.setTitleColor(.white, for: .normal)
			button.backgroundColor = UIColor(red: 21/255, green: 126/255, blue: 251/255, alpha: 1)
			return button
		}()
		
		override func setupCell() {
			addSubview(button)
			self.selectionStyle = .none
			
			_ = button.anchor(nil, left: nil, bottom: nil, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 128, heightConstant: 44)
			button.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
			button.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
		}
	}
	
	class RatingCell: BaseCell {
		
		let leftLabel: UILabel = {
			let label = UILabel()
			label.textAlignment = .left
			label.text = "Left"
			return label
		}()
		
		let rightLabel: UILabel = {
			let label = UILabel()
			label.textAlignment = .center
			label.textColor = UIColor(red: 0.3, green: 0.3, blue: 0.3, alpha: 1)
			label.text = "Right"
			return label
		}()
		
		let segmentedControl: UISegmentedControl = {
			let ratingStates = ["-", "0", "+"]
			let sc = UISegmentedControl(items: ratingStates)
			return sc
		}()
		
		override func setupCell() {
			addSubview(segmentedControl)
			addSubview(leftLabel)
			addSubview(rightLabel)
			self.selectionStyle = .none
			
			segmentedControl.selectedSegmentIndex = 1
			
			_ = leftLabel.anchor(nil, left: self.leftAnchor, bottom: nil, right: segmentedControl.leftAnchor, topConstant: 0, leftConstant: 16, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
			leftLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
			
			_ = rightLabel.anchor(nil, left: nil, bottom: nil, right: segmentedControl.leftAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 16, widthConstant: 80, heightConstant: 0)
			rightLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
			
			_ = segmentedControl.anchor(nil, left: nil, bottom: nil, right: self.rightAnchor, topConstant: 0, leftConstant: 16, bottomConstant: 0, rightConstant: 16, widthConstant: 160, heightConstant: 44)
			segmentedControl.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
		}
	}
	
	class TextCell: BaseCell {
		
		let leftLabel: UILabel = {
			let label = UILabel()
			label.textAlignment = .left
			label.text = "Left"
			return label
		}()
		
		let rightLabel: UITextView = {
			let view = UITextView()
			view.isUserInteractionEnabled = true
			view.isScrollEnabled = true
			view.isEditable = false
			view.isSelectable = false
			view.textAlignment = .left
			view.text = "Right"
			view.font = .systemFont(ofSize: 18)
			view.textColor = UIColor(red: 142/255, green: 142/255, blue: 147/255, alpha: 1)
			return view
		}()
		
		override func setupCell() {
			addSubview(leftLabel)
			addSubview(rightLabel)
			
			self.selectionStyle = .none
			
			_ = leftLabel.anchor(self.topAnchor, left: self.leftAnchor, bottom: nil, right: nil, topConstant: 13, leftConstant: 16, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 18)
			
			_ = rightLabel.anchor(leftLabel.bottomAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, topConstant: 4, leftConstant: 16, bottomConstant: 13, rightConstant: 16, widthConstant: 0, heightConstant: 0)
		}
		
	}
	
	class CommitmentCell: BaseCell {
		
		var delegate: PartyDetailTableViewController?
		
		let segmentedControl: UISegmentedControl = {
			let commitmentStates = [EventCommitment.Attending.rawValue, EventCommitment.Noted.rawValue, EventCommitment.Declined.rawValue]
			let sc = UISegmentedControl(items: commitmentStates)
			return sc
		}()
		
		override func setupCell() {
			addSubview(segmentedControl)
			self.selectionStyle = .none
			
			_ = segmentedControl.anchor(nil, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, topConstant: 0, leftConstant: 16, bottomConstant: 0, rightConstant: 16, widthConstant: 0, heightConstant: 44)
			segmentedControl.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
			
			segmentedControl.addTarget(self, action: #selector(putCommitmentState), for: .valueChanged)
		}
		
		func putCommitmentState() {
			self.delegate?.putCommitmentState()
		}
	}
	
	class DetailCell: BaseCell {
		
		let leftLabel: UILabel = {
			let label = UILabel()
			label.textAlignment = .left
			label.text = "Left"
			return label
		}()
		
		let rightLabel: UILabel = {
			let label = UILabel()
			label.textAlignment = .right
			label.text = "Right"
			label.textColor = UIColor(red: 142/255, green: 142/255, blue: 147/255, alpha: 1)
			return label
		}()
		
		override func setupCell() {
			self.isUserInteractionEnabled = false
			
			addSubview(leftLabel)
			addSubview(rightLabel)
			
			_ = leftLabel.anchor(nil, left: self.leftAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 16, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
			leftLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
			
			_ = rightLabel.anchor(nil, left: nil, bottom: nil, right: self.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 16, widthConstant: 0, heightConstant: 0)
			rightLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
			
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

