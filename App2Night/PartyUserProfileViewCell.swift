//
//  PartyUserProfileViewCell.swift
//  App2Night
//
//  Created by Robin on 30.11.16.
//  Copyright © 2016 DHBW. All rights reserved.
//

import UIKit

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
	
}

