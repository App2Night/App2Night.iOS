//
//  PartyTableViewCell.swift
//  App2Night
//
//  Created by Tobias Müller on 05.11.16.
//  Copyright © 2016 DHBW. All rights reserved.
//

import UIKit

class PartyTableViewCell: UITableViewCell {
	
	//MARK: Properties
	@IBOutlet weak var PartyName: UILabel!
	@IBOutlet weak var PartyLocation: UILabel!
	@IBOutlet weak var Distance: UILabel!
	
	
	override func awakeFromNib() {
		super.awakeFromNib()
		// Initialization code
	}
	
	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
		
		// Configure the view for the selected state
	}
	
}
